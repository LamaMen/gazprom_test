import 'package:gazprom_test/features/weather/data/models/city_dto_remote.dart';
import 'package:gazprom_test/features/weather/domain/dto/weather_list_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather_list_dto_remote.g.dart';

@JsonSerializable(createToJson: false)
class WeatherListDtoRemote implements WeatherListDto {
  const WeatherListDtoRemote(this.list, this.city);

  @override
  final List<WeatherDtoRemote> list;

  @override
  final CityDtoRemote city;

  factory WeatherListDtoRemote.fromJson(Map<String, dynamic> json) =>
      _$WeatherListDtoRemoteFromJson(json);
}

@JsonSerializable(createToJson: false)
class WeatherDtoRemote implements WeatherDto {
  const WeatherDtoRemote(
    this.date,
    this.mainInfo,
    this.info,
    this.wind,
  );

  @override
  @JsonKey(name: 'dt')
  final int date;

  @override
  @JsonKey(name: 'main')
  final MainWeatherInfoDtoRemote mainInfo;

  @override
  @JsonKey(name: 'weather')
  final List<WeatherInfoDtoRemote> info;

  @override
  @JsonKey(name: 'wind')
  final WindDtoRemote wind;

  factory WeatherDtoRemote.fromJson(Map<String, dynamic> json) =>
      _$WeatherDtoRemoteFromJson(json);
}

@JsonSerializable(createToJson: false)
class MainWeatherInfoDtoRemote implements MainWeatherInfoDto {
  const MainWeatherInfoDtoRemote(
    this.temp,
    this.tempMin,
    this.tempMax,
    this.humidity,
  );

  @override
  final double temp;

  @override
  @JsonKey(name: 'temp_min')
  final double tempMin;

  @override
  @JsonKey(name: 'temp_max')
  final double tempMax;

  @override
  final int humidity;

  factory MainWeatherInfoDtoRemote.fromJson(Map<String, dynamic> json) =>
      _$MainWeatherInfoDtoRemoteFromJson(json);
}

@JsonSerializable(createToJson: false)
class WeatherInfoDtoRemote implements WeatherInfoDto {
  const WeatherInfoDtoRemote(
    this.description,
    this.icon,
  );

  @override
  final String description;

  @override
  final String icon;

  factory WeatherInfoDtoRemote.fromJson(Map<String, dynamic> json) =>
      _$WeatherInfoDtoRemoteFromJson(json);
}

@JsonSerializable(createToJson: false)
class WindDtoRemote implements WindDto {
  const WindDtoRemote(
    this.speed,
    this.deg,
  );

  @override
  final double speed;

  @override
  final int deg;

  factory WindDtoRemote.fromJson(Map<String, dynamic> json) =>
      _$WindDtoRemoteFromJson(json);
}
