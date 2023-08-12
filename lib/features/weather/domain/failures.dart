import 'package:gazprom_test/core/failure.dart';

class LocationServiceDisabledFailure extends Failure {
  const LocationServiceDisabledFailure();
}

class LocationPermissionDeniedFailure extends Failure {
  const LocationPermissionDeniedFailure();
}

class LocationPermissionDeniedForeverFailure extends Failure {
  const LocationPermissionDeniedForeverFailure();
}
