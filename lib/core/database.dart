import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class DatabaseHelper {
  static Future<Database> getDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'weather.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE city (id INTEGER PRIMARY KEY, name TEXT, lat REAL, lon REAL)');

        await db.execute(
            'CREATE TABLE weather (dt INTEGER, city_id INTEGER, temp REAL, temp_min REAL, temp_max REAL, humidity INTEGER, description TEXT, icon TEXT, speed REAL, deg INTEGER, PRIMARY KEY (dt, city_id), FOREIGN KEY (city_id) REFERENCES city(id))');
      },
    );
  }
}
