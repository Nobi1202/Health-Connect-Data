import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health/health.dart';
import 'package:url_launcher/url_launcher.dart';
import 'health_event.dart';
import 'health_state.dart';

class HealthBloc extends Bloc<HealthEvent, HealthState> {
  final Health health = Health();

  // Define the types of sleep data to access
  // Note: SLEEP_IN_BED is not supported in Health Connect, removed
  static final types = [
    HealthDataType.SLEEP_ASLEEP,
    HealthDataType.SLEEP_AWAKE_IN_BED,
    HealthDataType.SLEEP_AWAKE,
    HealthDataType.SLEEP_DEEP,
    // HealthDataType.SLEEP_IN_BED,
    HealthDataType.SLEEP_LIGHT,
    HealthDataType.SLEEP_OUT_OF_BED,
    HealthDataType.SLEEP_REM,
    HealthDataType.SLEEP_SESSION,
    HealthDataType.SLEEP_UNKNOWN,

    // Health Connect
    // HealthDataType.TOTAL_CALORIES_BURNED,
  ];

  // Define permissions
  static final permissions = [HealthDataAccess.READ];

  HealthBloc() : super(const HealthState()) {
    on<CheckHealthConnectStatus>(_onCheckHealthConnectStatus);
    on<RequestHealthPermissions>(_onRequestHealthPermissions);
    on<FetchSleepData>(_onFetchSleepData);
    on<InstallHealthConnect>(_onInstallHealthConnect);

    // Configure health plugin
    health.configure();
  }

  Future<void> _onCheckHealthConnectStatus(
    CheckHealthConnectStatus event,
    Emitter<HealthState> emit,
  ) async {
    try {
      // Check if Health Connect is installed
      final isAvailable = health.isDataTypeAvailable(
        HealthDataType.SLEEP_ASLEEP,
      );

      if (!isAvailable) {
        emit(state.copyWith(status: HealthStatus.healthConnectNotInstalled));
        return;
      }

      // Try to fetch data directly - this will fail if no permissions
      // This is more reliable than checking hasPermissions
      add(const FetchSleepData());
    } catch (e) {
      emit(
        state.copyWith(
          status: HealthStatus.error,
          errorMessage: 'Error checking Health Connect status: $e',
        ),
      );
    }
  }

  Future<void> _onRequestHealthPermissions(
    RequestHealthPermissions event,
    Emitter<HealthState> emit,
  ) async {
    try {
      // Request permissions
      final granted = await health.requestAuthorization(
        types,
        permissions: permissions,
      );

      if (granted) {
        emit(state.copyWith(status: HealthStatus.permissionGranted));
        add(const FetchSleepData());
      } else {
        emit(state.copyWith(status: HealthStatus.permissionNotGranted));
      }
    } catch (e) {
      // If there's an error, it might be a configuration issue
      // Still set to permissionNotGranted so user can retry
      emit(
        state.copyWith(
          status: HealthStatus.permissionNotGranted,
          errorMessage:
              'Permission request failed. Please try again or check if Health Connect is properly installed. Error: $e',
        ),
      );
    }
  }

  Future<void> _onFetchSleepData(
    FetchSleepData event,
    Emitter<HealthState> emit,
  ) async {
    emit(state.copyWith(status: HealthStatus.loading));

    try {
      // Define time range: last 7 days
      final now = DateTime.now();
      final sevenDaysAgo = now.subtract(const Duration(days: 7));

      print('Fetching sleep data from $sevenDaysAgo to $now');

      // Fetch sleep data - the method signature from README
      final healthData = await health.getHealthDataFromTypes(
        types: types,
        startTime: sevenDaysAgo,
        endTime: now,
      );

      print('Raw health data points fetched: ${healthData.length}');

      // Remove duplicates
      final uniqueData = Health().removeDuplicates(healthData);

      print(
        'Unique data points after removing duplicates: ${uniqueData.length}',
      );

      if (uniqueData.isEmpty) {
        print('No sleep data found');
        emit(state.copyWith(status: HealthStatus.noData, sleepData: []));
      } else {
        print('Sleep data loaded successfully: ${uniqueData.length} points');
        for (var point in uniqueData) {
          print('  - ${point.type}: ${point.dateFrom} to ${point.dateTo}');
        }
        emit(
          state.copyWith(status: HealthStatus.loaded, sleepData: uniqueData),
        );
      }
    } catch (e) {
      print('Error fetching sleep data: $e');
      // If we get a permission error, show permission screen
      if (e.toString().contains('Permission') ||
          e.toString().contains('authorization') ||
          e.toString().contains('not granted')) {
        emit(state.copyWith(status: HealthStatus.permissionNotGranted));
      } else {
        emit(
          state.copyWith(
            status: HealthStatus.error,
            errorMessage: 'Error fetching sleep data: $e',
          ),
        );
      }
    }
  }

  Future<void> _onInstallHealthConnect(
    InstallHealthConnect event,
    Emitter<HealthState> emit,
  ) async {
    try {
      // Try to open Health Connect app directly first
      final healthConnectUrl = Uri.parse('healthconnect://home');
      if (await canLaunchUrl(healthConnectUrl)) {
        await launchUrl(healthConnectUrl, mode: LaunchMode.externalApplication);
        return;
      }

      // If that fails, try the package URL
      final packageUrl = Uri.parse(
        'package:com.google.android.apps.healthdata',
      );
      if (await canLaunchUrl(packageUrl)) {
        await launchUrl(packageUrl, mode: LaunchMode.externalApplication);
        return;
      }

      // Otherwise open Play Store
      final url = Uri.parse(
        'https://play.google.com/store/apps/details?id=com.google.android.apps.healthdata',
      );
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: HealthStatus.error,
          errorMessage: 'Error opening Health Connect: $e',
        ),
      );
    }
  }
}
