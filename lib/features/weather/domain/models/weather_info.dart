import 'package:flutter/foundation.dart';
import 'package:gazprom_test/features/weather/domain/models/place.dart';
import 'package:gazprom_test/features/weather/domain/models/weather.dart';

@immutable
class WeatherInfo {
  const WeatherInfo(
    this.place,
    this.nearest,
    this.currentWeather,
  );

  final Place place;
  final List<Weather> nearest;
  final int currentWeather;

  Weather get current => nearest[currentWeather];
}
