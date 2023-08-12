import 'package:dio/dio.dart';
import 'package:gazprom_test/core/failure.dart';
import 'package:gazprom_test/core/result.dart';
import 'package:gazprom_test/features/weather/data/services/weather_api_client.dart';
import 'package:gazprom_test/features/weather/domain/dto/weather_list_dto.dart';
import 'package:gazprom_test/features/weather/domain/models/location.dart';
import 'package:gazprom_test/features/weather/domain/repositories/weather_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: WeatherRepository)
class WeatherRepositoryImpl implements WeatherRepository {
  const WeatherRepositoryImpl(this._client);

  final WeatherApiClient _client;

  @override
  FResult<WeatherWithPlaceDto> getWeatherByLocation(Location location) async {
    try {
      final weather = await _client.fetchWeather(location.lat, location.lon);
      final place = weather.city.toPlace();
      final weathers = weather.list.map((w) => w.toWeather()).toList();

      return Success(WeatherWithPlaceDto(weathers, place));
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return const InternetFailure().asError();
      }

      return const UnknownFailure().asError();
    }
  }
}
