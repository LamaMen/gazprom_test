import 'package:gazprom_test/core/result.dart';
import 'package:gazprom_test/features/weather/domain/models/location.dart';

abstract class LocationRepository {
  FResult<Location> getCurrentLocation();
}
