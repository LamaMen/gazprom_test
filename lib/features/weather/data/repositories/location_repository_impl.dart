import 'package:gazprom_test/core/result.dart';
import 'package:gazprom_test/features/weather/domain/failures.dart';
import 'package:gazprom_test/features/weather/domain/models/location.dart';
import 'package:gazprom_test/features/weather/domain/repositories/location_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LocationRepository)
class LocationRepositoryImpl implements LocationRepository {
  const LocationRepositoryImpl();

  @override
  FResult<Location> getCurrentLocation() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return const LocationServiceDisabledFailure().asError<Location>();
    }

    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      final requestedPermission = await Geolocator.requestPermission();
      if (requestedPermission == LocationPermission.denied) {
        return const LocationPermissionDeniedFailure().asError();
      }

      if (requestedPermission == LocationPermission.deniedForever) {
        return const LocationPermissionDeniedForeverFailure().asError();
      }
    }

    final position = await Geolocator.getCurrentPosition();
    final location = Location(position.latitude, position.longitude);

    return Success(location);
  }
}
