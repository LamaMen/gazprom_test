import 'package:gazprom_test/core/result.dart';
import 'package:gazprom_test/features/weather/domain/dto/weather_list_dto.dart';
import 'package:gazprom_test/features/weather/domain/models/place.dart';
import 'package:gazprom_test/features/weather/domain/models/weather.dart';
import 'package:gazprom_test/features/weather/domain/models/weather_info.dart';
import 'package:gazprom_test/features/weather/domain/repositories/location_repository.dart';
import 'package:gazprom_test/features/weather/domain/repositories/weather_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetWeatherUseCase {
  const GetWeatherUseCase(this._locationRepository, this._weatherRepository);

  final LocationRepository _locationRepository;
  final WeatherRepository _weatherRepository;

  FResult<WeatherInfo> call() async {
    final location = await _locationRepository.getCurrentLocation();
    if (location.isError) {
      return location.failure.asError();
    }

    final weather =
        await _weatherRepository.getWeatherByLocation(location.value);

    return weather.fold((f) => f.asError(), (dto) {
      final info = _createByDto(dto);
      return Success(info);
    });
  }

  WeatherInfo _createByDto(WeatherListDto dto) {
    final place = Place(dto.city.id, dto.city.name);
    final weathers = dto.list.take(4).map((w) {
      final info = w.info.first;

      return Weather(
        w.date,
        w.mainInfo.temp,
        w.mainInfo.tempMin,
        w.mainInfo.tempMax,
        info.icon,
        info.description,
        w.wind.speed,
        w.wind.deg,
        w.mainInfo.humidity,
      );
    }).toList();

    return WeatherInfo(place, weathers, 1);
  }

  WeatherInfo _createMock() {
    const place = Place(1, 'Санкт-петербург');
    const current = 1;
    final weather = [
      Weather(1691787600, 13.61, 13.61, 13.61, '01n', 'ясно', 1.8, 174, 70),
      Weather(1691798400, 13.35, 12.83, 13.35, '02n', 'ясно', 1.75, 194, 70),
      Weather(1691809200, 15.86, 15.86, 16.98, '13n', 'ясно', 1.56, 214, 63),
      Weather(1691820000, 22.48, 22.48, 22.48, '50n', 'ясно', 2.29, 192, 41),
    ];

    return WeatherInfo(place, weather, current);
  }
}
