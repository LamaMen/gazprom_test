import 'package:gazprom_test/core/result.dart';
import 'package:gazprom_test/features/weather/domain/models/place.dart';
import 'package:gazprom_test/features/weather/domain/models/weather.dart';
import 'package:gazprom_test/features/weather/domain/models/weather_info.dart';
import 'package:gazprom_test/features/weather/domain/repositories/location_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetWeatherUseCase {
  const GetWeatherUseCase(this.locationRepository);

  final LocationRepository locationRepository;

  FResult<WeatherInfo> call() async {
    final location = await locationRepository.getCurrentLocation();
    if (location.isError) {
      return location.failure.asError();
    }

    return Success(_createMock());
  }

  WeatherInfo _createMock() {
    const place = Place(1, 'Санкт-петербург');
    const current = 1;
    final weather = [
      Weather(1691787600, 13.61, 13.61, 13.61, '01n', 'ясно',
          const Wind(1.8, 174), const Humidity(70)),
      Weather(1691798400, 13.35, 12.83, 13.35, '02n', 'ясно',
          const Wind(1.75, 194), const Humidity(70)),
      Weather(1691809200, 15.86, 15.86, 16.98, '13n', 'ясно',
          const Wind(1.56, 214), const Humidity(63)),
      Weather(1691820000, 22.48, 22.48, 22.48, '50n', 'ясно',
          const Wind(2.29, 192), const Humidity(41)),
    ];

    return WeatherInfo(place, weather, current);
  }
}
