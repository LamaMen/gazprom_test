import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gazprom_test/core/failure.dart';
import 'package:gazprom_test/core/result.dart';
import 'package:gazprom_test/features/weather/data/services/weather_api_client.dart';
import 'package:gazprom_test/features/weather/data/services/weather_database_client.dart';
import 'package:gazprom_test/features/weather/domain/dto/weather_list_dto.dart';
import 'package:gazprom_test/features/weather/domain/models/location.dart';
import 'package:gazprom_test/features/weather/domain/repositories/weather_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: WeatherRepository)
class WeatherRepositoryImpl implements WeatherRepository {
  const WeatherRepositoryImpl(this._api, this._database);

  final WeatherApiClient _api;
  final WeatherDatabaseClient _database;

  @override
  FResult<WeatherWithPlaceDto> getWeatherByLocation(Location location) async {
    try {
      final weather = await _api.fetchWeather(location.lat, location.lon);
      await _database.savePlace(weather.city);
      final place = weather.city.toPlace();

      final saved = await _database.getPyPlace(place.id);
      final weathers = weather.list.map((w) => w.toWeather()).toList();
      weathers.addAll(saved);
      final uniques = weathers.toSet().toList();
      await _database.saveWeather(uniques, place.id);

      return Success(WeatherWithPlaceDto(uniques, place));
    } on DioException catch (e) {
      if (e.error is SocketException) {
        final weather = await _database.getAllByLocation(location);
        return weather != null
            ? Success(weather)
            : const InternetFailure().asError();
      }

      return const UnknownFailure().asError();
    }
  }
}
