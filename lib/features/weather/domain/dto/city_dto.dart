import 'package:flutter/foundation.dart';

@immutable
class CityDto {
  const CityDto(this.id, this.name, this.coordinates);

  final int id;
  final String name;
  final CoordinatesDto coordinates;
}

@immutable
class CoordinatesDto {
  const CoordinatesDto(this.lat, this.lon);

  final double lat;
  final double lon;
}
