import 'package:flutter/foundation.dart';

@immutable
class Weather {
  Weather(
    this.rawDate,
    this.temp,
    this.tempMin,
    this.tempMax,
    String imageCode,
    this.description,
    double windSpeed,
    int windDeg,
    int humidity,
  )   : _image = _ImageHelper(imageCode),
        wind = Wind(windSpeed, windDeg),
        humidity = Humidity(humidity);

  final int rawDate;
  final double temp;
  final double tempMin;
  final double tempMax;
  final _ImageHelper _image;
  final String description;
  final Wind wind;
  final Humidity humidity;

  String get smallIconPath {
    return _image._smallPath;
  }

  String get largeIconPath {
    return _image._largePath;
  }
}

@immutable
class _ImageHelper {
  const _ImageHelper(this._code);

  final String _code;

  String get _weatherCode {
    return _code.substring(0, 2);
  }

  String get _timeOfDay {
    return _code.substring(2);
  }

  String get _smallPath {
    final iconCode = _weatherCode;

    if (iconCode == '01') return 'assets/sun_small.svg';
    if (iconCode == '09' || iconCode == '10') return 'assets/rain_small.svg';
    if (iconCode == '11') return 'assets/storm_small.svg';
    if (iconCode == '13') return 'assets/snow_small.svg';
    if ((iconCode == '02' || iconCode == '03') && _timeOfDay == 'n') {
      return 'assets/cloudy_night_small.svg';
    }

    return 'assets/cloudy_day_small.svg';
  }

  String get _largePath {
    final iconCode = _weatherCode;

    if (iconCode == '01') return 'assets/sun_large.png';
    if (iconCode == '09') return 'assets/shower_rain_large.png';
    if (iconCode == '10') return 'assets/rain_large.png';
    if (iconCode == '11') return 'assets/storm_large.png';
    if (iconCode == '13') return 'assets/snow_large.png';

    return 'assets/cloudy_large.png';
  }
}

@immutable
class Wind {
  const Wind(this.speed, this.deg);

  final double speed;
  final int deg;

  String get value {
    final windSpeed = speed.round();
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
