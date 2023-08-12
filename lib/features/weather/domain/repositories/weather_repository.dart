import 'package:gazprom_test/core/result.dart';
import 'package:gazprom_test/features/weather/domain/dto/weather_list_dto.dart';
import 'package:gazprom_test/features/weather/domain/models/location.dart';

abstract class WeatherRepository {
  FResult<WeatherWithPlaceDto> getWeatherByLocation(Location location);
}
