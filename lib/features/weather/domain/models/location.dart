import 'package:flutter/foundation.dart';

@immutable
class Location {
  const Location(this.lat, this.lon);

  final double lat;
  final double lon;

  @override
  String toString() {
    return 'Coordinates: {$lat, $lon}';
  }
}
