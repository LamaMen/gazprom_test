import 'dart:math';

import 'package:gazprom_test/core/database.dart';
import 'package:gazprom_test/features/weather/data/models/city_remote.dart';
import 'package:gazprom_test/features/weather/domain/dto/weather_list_dto.dart';
import 'package:gazprom_test/features/weather/domain/models/location.dart';
import 'package:gazprom_test/features/weather/domain/models/place.dart';
import 'package:gazprom_test/features/weather/domain/models/weather.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@injectable
class WeatherDatabaseClient {
  const WeatherDatabaseClient();

  Future<void> savePlace(CityRemote city) async {
    final db = await DatabaseHelper.getDatabase();

    final place = <String, Object?>{
      'id': city.id,
      'name': city.name,
      'lat': city.coordinates.lat,
      'lon': city.coordinates.lon,
    };

    await db.insert('city', place,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> saveWeather(List<Weather> weathers, int cityId) async {
    final db = await DatabaseHelper.getDatabase();

    weathers.map((w) {
      return <String, Object?>{
        'dt': w.rawDate,
        'city_id': cityId,
        'temp': w.temp,
        'temp_min': w.tempMin,
        'temp_max': w.tempMax,
        'icon': w.rawIcon,
        'description': w.description,
        'speed': w.wind.speed,
        'deg': w.wind.deg,
        'humidity': w.humidity.humidity,
      };
    }).forEach((w) async {
      await db.insert('weather', w,
          conflictAlgorithm: ConflictAlgorithm.replace);
    });
  }

  Future<WeatherWithPlaceDto?> getAllByLocation(Location location) async {
    final place = await getPlaceByLocation(location);
    if (place == null) return null;

    final weathers = await getPyPlace(place.id);
    return WeatherWithPlaceDto(weathers, place);
  }

  Future<List<Weather>> getPyPlace(int placeId) async {
    final db = await DatabaseHelper.getDatabase();

    final weathersMaps = await db.query(
      'weather',
      where: 'city_id = ?',
      whereArgs: [placeId],
    );

    return weathersMaps.map((w) {
      return Weather(
        w['dt'] as int,
        w['temp'] as double,
        w['temp_min'] as double,
        w['temp_max'] as double,
        w['icon'] as String,
        w['description'] as String,
        w['speed'] as double,
        w['deg'] as int,
        w['humidity'] as int,
      );
    }).toList();
  }

  Future<Place?> getPlaceByLocation(Location location) async {
    final db = await DatabaseHelper.getDatabase();

    final allPlaces = await db.query('city');
    allPlaces.sort((a, b) {
      final ap = Point<double>(a['lat'] as double, a['lon'] as double);
      final bp = Point<double>(b['lat'] as double, b['lon'] as double);
      final cp = Point<double>(location.lat, location.lon);
      final ac = distanceBetweenTwoPoint(ap, cp);
      final bc = distanceBetweenTwoPoint(bp, cp);
      return ac.compareTo(bc);
    });

    final place = allPlaces.firstOrNull;
    if (place == null) return null;
    return Place(place['id'] as int, place['name'] as String);
  }
}

/// From https://www.kobzarev.com/programming/calculation-of-distances-between-cities-on-their-coordinates/
double distanceBetweenTwoPoint(Point<double> a, Point<double> b) {
  final lat1 = a.x * pi / 180;
  final lat2 = b.x * pi / 180;
  final long1 = a.y * pi / 180;
  final long2 = b.y * pi / 180;

  final cl1 = cos(lat1);
  final cl2 = cos(lat2);
  final sl1 = sin(lat1);
  final sl2 = sin(lat2);
  final d = long2 - long1;
  final cd = cos(d);
  final sd = sin(d);

  final y = sqrt(pow(cl1 * sd, 2) + pow(cl1 * sl2 - sl1 * cl2 * cd, 2));
  final x = sl1 * sl2 + cl1 * cl2 * cd;

  final ad = atan2(y, x);
  return ad * 6372795;
}
