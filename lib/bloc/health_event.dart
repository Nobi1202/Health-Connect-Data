import 'package:equatable/equatable.dart';

abstract class HealthEvent extends Equatable {
  const HealthEvent();

  @override
  List<Object?> get props => [];
}

class CheckHealthConnectStatus extends HealthEvent {
  const CheckHealthConnectStatus();
}

class RequestHealthPermissions extends HealthEvent {
  const RequestHealthPermissions();
}

class FetchSleepData extends HealthEvent {
  const FetchSleepData();
}

class InstallHealthConnect extends HealthEvent {
  const InstallHealthConnect();
}
