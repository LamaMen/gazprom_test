import 'package:gazprom_test/features/weather/data/models/city_dto_remote.dart';
import 'package:gazprom_test/features/weather/domain/models/weather.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather_list_dto_remote.g.dart';

@JsonSerializable(createToJson: false)
class WeathersListRemote {
  const WeathersListRemote(this.list, this.city);

  final List<WeatherRemote> list;
  final CityRemote city;

  factory WeathersListRemote.fromJson(Map<String, dynamic> json) =>
      _$WeathersListRemoteFromJson(json);
}

@JsonSerializable(createToJson: false)
class WeatherRemote {
  const WeatherRemote(
    this.date,
    this.mainInfo,
    this.info,
    this.wind,
  );

  @JsonKey(name: 'dt')
  final int date;

  @JsonKey(name: 'main')
  final MainWeatherInfoRemote mainInfo;

  @JsonKey(name: 'weather')
  final List<WeatherInfoRemote> info;

  @JsonKey(name: 'wind')
  final WindRemote wind;

  factory WeatherRemote.fromJson(Map<String, dynamic> json) =>
      _$WeatherRemoteFromJson(json);

  Weather toWeather() {
    final weatherInfo = info.first;
    return Weather(
      date,
      mainInfo.temp,
      mainInfo.tempMin,
      mainInfo.tempMax,
      weatherInfo.icon,
      weatherInfo.description,
      wind.speed,
      wind.deg,
      mainInfo.humidity,
    );
  }
}

@JsonSerializable(createToJson: false)
class MainWeatherInfoRemote {
  const MainWeatherInfoRemote(
    this.temp,
    this.tempMin,
    this.tempMax,
    this.humidity,
  );

  final double temp;

  @JsonKey(name: 'temp_min')
  final double tempMin;

  @JsonKey(name: 'temp_max')
  final double tempMax;

  final int humidity;

  factory MainWeatherInfoRemote.fromJson(Map<String, dynamic> json) =>
      _$MainWeatherInfoRemoteFromJson(json);
}

@JsonSerializable(createToJson: false)
class WeatherInfoRemote {
  const WeatherInfoRemote(
    this.description,
    this.icon,
  );

  final String description;

  final String icon;

  factory WeatherInfoRemote.fromJson(Map<String, dynamic> json) =>
      _$WeatherInfoRemoteFromJson(json);
}

@JsonSerializable(createToJson: false)
class WindRemote {
  const WindRemote(
    this.speed,
    this.deg,
  );

  final double speed;

  final int deg;

  factory WindRemote.fromJson(Map<String, dynamic> json) =>
      _$WindRemoteFromJson(json);
}
