import 'package:flutter/foundation.dart';

@immutable
class Weather {
  const Weather(
    this.rawDate,
    this.temp,
    this.tempMin,
    this.tempMax,
    this.icon,
    this.description,
    this.wind,
    this.humidity,
  );

  final int rawDate;
  final double temp;
  final double tempMin;
  final double tempMax;
  final String icon;
  final String description;
  final Wind wind;
  final Humidity humidity;

  String get smallIconPath {
    return 'assets/sun_small.svg';
  }

  String get largeIconPath {
    return 'assets/sun_large.png';
  }
}

@immutable
class Wind {
  const Wind(this.wind, this.deg);

  final double wind;
  final int deg;

  String get value {
    final windSpeed = wind.round();
    return '$windSpeed м/с';
  }

  String get direction {
    if (deg <= 22 || deg >= 338) return 'Ветер южный';
    if (22 < deg && deg <= 67) return 'Ветер юго-западный';
    if (67 < deg && deg <= 112) return 'Ветер западный';
    if (112 < deg && deg <= 157) return 'Ветер северо-западный';
    if (157 < deg && deg <= 202) return 'Ветер северный';
    if (202 < deg && deg <= 247) return 'Ветер северо-восточный';
    if (247 < deg && deg <= 292) return 'Ветер восточный';
    return 'Ветер юго-восточный';
  }
}

@immutable
class Humidity {
  const Humidity(this.humidity);

  final int humidity;

  String get value => '$humidity%';

  /// From https://weather.fandom.com/ru/wiki/Влажность
  String get title {
    if (humidity <= 3) return 'Безводная влажность';
    if (humidity <= 9) return 'Песчаная влажность';
    if (humidity <= 22) return 'Сухая влажность';
    if (humidity <= 40) return 'Низкая влажность';
    if (humidity <= 52) return 'Средняя влажность';
    if (humidity <= 64) return 'Привычная влажность';
    if (humidity <= 73) return 'Умеренная влажность';
    if (humidity <= 81) return 'Высокая влажность';
    if (humidity <= 99) return 'Туманная влажность';
    return 'Мокрая влажность';
  }
}
