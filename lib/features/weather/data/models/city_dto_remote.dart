import 'package:gazprom_test/features/weather/domain/models/place.dart';
import 'package:json_annotation/json_annotation.dart';

part 'city_dto_remote.g.dart';

@JsonSerializable(createToJson: false)
class CityRemote {
  const CityRemote(this.id, this.name, this.coordinates);

  final int id;
  final String name;
  @JsonKey(name: 'coord')
  final CoordinatesRemote coordinates;

  factory CityRemote.fromJson(Map<String, dynamic> json) =>
      _$CityRemoteFromJson(json);

  Place toPlace() => Place(id, name);
}

@JsonSerializable(createToJson: false)
class CoordinatesRemote {
  const CoordinatesRemote(this.lat, this.lon);

  final double lat;
  final double lon;

  factory CoordinatesRemote.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesRemoteFromJson(json);
}
