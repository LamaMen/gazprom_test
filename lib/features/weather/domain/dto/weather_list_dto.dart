import 'package:flutter/foundation.dart';
import 'package:gazprom_test/features/weather/domain/dto/city_dto.dart';

@immutable
class WeatherListDto {
  const WeatherListDto(this.list, this.city);

  final List<WeatherDto> list;
  final CityDto city;
}

@immutable
class WeatherDto {
  const WeatherDto(
    this.date,
    this.mainInfo,
    this.info,
    this.wind,
  );

  final int date;
  final MainWeatherInfoDto mainInfo;
  final List<WeatherInfoDto> info;
  final WindDto wind;
}

@immutable
class MainWeatherInfoDto {
  const MainWeatherInfoDto(
    this.temp,
    this.tempMin,
    this.tempMax,
    this.humidity,
  );

  final double temp;
  final double tempMin;
  final double tempMax;
  final int humidity;
}

@immutable
class WeatherInfoDto {
  const WeatherInfoDto(
    this.description,
    this.icon,
  );

  final String description;
  final String icon;
}

@immutable
class WindDto {
  const WindDto(
    this.speed,
    this.deg,
  );

  final double speed;
  final int deg;
}
