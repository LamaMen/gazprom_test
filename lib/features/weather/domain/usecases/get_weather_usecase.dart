import 'package:gazprom_test/core/result.dart';
import 'package:gazprom_test/features/weather/domain/dto/weather_list_dto.dart';
import 'package:gazprom_test/features/weather/domain/failures.dart';
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
      return _selectNearestWeathers(dto);
    });
  }

  Result<WeatherInfo> _selectNearestWeathers(WeatherWithPlaceDto dto) {
    final weathers = dto.list;
    final count = weathers.length;
    weathers.sort((a, b) => a.rawDate.compareTo(b.rawDate));
    final current = weathers.indexWhere(_isNextWeather);
    if (current == -1 || count < 4) {
      return const WeatherProcessFailure().asError();
    }

    late final Iterable<Weather> nearest;
    late final int next;

    if (current == 0) {
      next = 0;
      nearest = weathers.getRange(0, 4);
    } else if (current >= count - 2) {
      nearest = weathers.getRange(count - 4, count);
      next = 4 - (count - current);
    } else {
      nearest = weathers.getRange(current - 1, current + 3);
      next = 1;
    }

    final weather = WeatherInfo(dto.place, nearest.toList(), next);
    return Success(weather);
  }

  bool _isNextWeather(Weather w) {
    final now = (DateTime.now().millisecondsSinceEpoch / 1000).floor();
    final dt = w.rawDate - now;
    return 0 < dt && dt < 10800;
  }
}
