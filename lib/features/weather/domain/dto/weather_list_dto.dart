import 'package:flutter/foundation.dart';
import 'package:gazprom_test/features/weather/domain/models/place.dart';
import 'package:gazprom_test/features/weather/domain/models/weather.dart';

@immutable
class WeatherWithPlaceDto {
  const WeatherWithPlaceDto(this.list, this.place);

  final List<Weather> list;
  final Place place;
}
