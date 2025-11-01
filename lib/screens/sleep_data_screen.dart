import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health/health.dart';
import 'package:intl/intl.dart';
import '../bloc/health_bloc.dart';
import '../bloc/health_event.dart';
import '../bloc/health_state.dart';

class SleepDataScreen extends StatelessWidget {
  const SleepDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sleep Data'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: BlocBuilder<HealthBloc, HealthState>(
        builder: (context, state) {
          switch (state.status) {
            case HealthStatus.initial:
              // Show initial loading
              return const Center(child: CircularProgressIndicator());

            case HealthStatus.healthConnectNotInstalled:
              return _buildHealthConnectNotInstalledView(context);

            case HealthStatus.permissionNotGranted:
              return _buildPermissionNotGrantedView(context);

            case HealthStatus.loading:
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Loading sleep data...'),
                  ],
                ),
              );

            case HealthStatus.loaded:
              return _buildSleepDataList(context, state.sleepData);

            case HealthStatus.noData:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.bedtime_outlined,
                      size: 64,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'No Data',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.0),
                      child: Text(
                        'No sleep data found for the last 7 days.\nPlease ensure you have sleep tracking apps installed and synced with Health Connect.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<HealthBloc>().add(const FetchSleepData());
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Refresh Data'),
                    ),
                  ],
                ),
              );

            case HealthStatus.error:
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        state.errorMessage ?? 'An error occurred',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          context.read<HealthBloc>().add(
                            const CheckHealthConnectStatus(),
                          );
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              );

            case HealthStatus.permissionGranted:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildHealthConnectNotInstalledView(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.health_and_safety_outlined,
              size: 80,
              color: Colors.orange,
            ),
            const SizedBox(height: 24),
            const Text(
              'Health Connect Required',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Health Connect is required to sync sleep data. Please install it.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                context.read<HealthBloc>().add(const InstallHealthConnect());
              },
              icon: const Icon(Icons.download),
              label: const Text('Install Health Connect'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                context.read<HealthBloc>().add(
                  const CheckHealthConnectStatus(),
                );
              },
              child: const Text('I have installed it, check again'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionNotGrantedView(BuildContext context) {
    return BlocBuilder<HealthBloc, HealthState>(
      builder: (context, state) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lock_outline, size: 80, color: Colors.blue),
                const SizedBox(height: 24),
                const Text(
                  'Permission Required',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  'The app cannot display sleep data without permission.',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                if (state.errorMessage != null) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.orange.shade200),
                    ),
                    child: Text(
                      state.errorMessage!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.orange.shade900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<HealthBloc>().add(
                      const RequestHealthPermissions(),
                    );
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry Permission'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton.icon(
                  onPressed: () {
                    context.read<HealthBloc>().add(
                      const InstallHealthConnect(),
                    );
                  },
                  icon: const Icon(Icons.open_in_new, size: 18),
                  label: const Text('Open Health Connect Settings'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSleepDataList(
    BuildContext context,
    List<HealthDataPoint> sleepData,
  ) {
    // Group sleep data by date
    final groupedData = <String, List<HealthDataPoint>>{};

    for (var data in sleepData) {
      final dateKey = DateFormat('yyyy-MM-dd').format(data.dateFrom);
      if (!groupedData.containsKey(dateKey)) {
        groupedData[dateKey] = [];
      }
      groupedData[dateKey]!.add(data);
    }

    // Sort dates in descending order
    final sortedDates = groupedData.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    return RefreshIndicator(
      onRefresh: () async {
        context.read<HealthBloc>().add(const FetchSleepData());
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: sortedDates.length,
        itemBuilder: (context, index) {
          final dateKey = sortedDates[index];
          final dataPoints = groupedData[dateKey]!;
          final date = DateFormat('yyyy-MM-dd').parse(dateKey);

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ExpansionTile(
              leading: const Icon(Icons.bedtime, color: Colors.indigo),
              title: Text(
                DateFormat('EEEE, MMM d, yyyy').format(date),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${dataPoints.length} sleep session(s)'),
              children: dataPoints.map((data) {
                return _buildSleepDataItem(data);
              }).toList(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSleepDataItem(HealthDataPoint data) {
    final duration = data.dateTo.difference(data.dateFrom);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: _getSleepIcon(data.type),
      title: Text(_getSleepTypeName(data.type)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'From: ${DateFormat('HH:mm').format(data.dateFrom)} - To: ${DateFormat('HH:mm').format(data.dateTo)}',
          ),
          Text('Duration: ${hours}h ${minutes}m'),
        ],
      ),
      trailing: Text(
        data.sourcePlatform.name,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
    );
  }

  Icon _getSleepIcon(HealthDataType type) {
    switch (type) {
      case HealthDataType.SLEEP_ASLEEP:
        return const Icon(Icons.bedtime, color: Colors.indigo);
      case HealthDataType.SLEEP_AWAKE:
        return const Icon(Icons.bedtime_outlined, color: Colors.orange);
      case HealthDataType.SLEEP_DEEP:
        return const Icon(Icons.dark_mode, color: Colors.deepPurple);
      case HealthDataType.SLEEP_REM:
        return const Icon(Icons.psychology, color: Colors.purple);
      case HealthDataType.SLEEP_LIGHT:
        return const Icon(Icons.wb_twilight, color: Colors.lightBlue);
      default:
        return const Icon(Icons.bedtime, color: Colors.grey);
    }
  }

  String _getSleepTypeName(HealthDataType type) {
    switch (type) {
      case HealthDataType.SLEEP_ASLEEP:
        return 'Asleep';
      case HealthDataType.SLEEP_AWAKE:
        return 'Awake';
      case HealthDataType.SLEEP_DEEP:
        return 'Deep Sleep';
      case HealthDataType.SLEEP_REM:
        return 'REM Sleep';
      case HealthDataType.SLEEP_LIGHT:
        return 'Light Sleep';
      default:
        return type.name;
    }
  }
}
