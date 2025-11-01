import 'package:equatable/equatable.dart';
import 'package:health/health.dart';

enum HealthStatus {
  initial,
  healthConnectNotInstalled,
  permissionNotGranted,
  permissionGranted,
  loading,
  loaded,
  noData,
  error,
}

class HealthState extends Equatable {
  final HealthStatus status;
  final List<HealthDataPoint> sleepData;
  final String? errorMessage;

  const HealthState({
    this.status = HealthStatus.initial,
    this.sleepData = const [],
    this.errorMessage,
  });

  HealthState copyWith({
    HealthStatus? status,
    List<HealthDataPoint>? sleepData,
    String? errorMessage,
  }) {
    return HealthState(
      status: status ?? this.status,
      sleepData: sleepData ?? this.sleepData,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, sleepData, errorMessage];
}
