import 'package:gazprom_test/features/weather/domain/dto/city_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'city_dto_remote.g.dart';

@JsonSerializable(createToJson: false)
class CityDtoRemote implements CityDto {
  const CityDtoRemote(this.id, this.name, this.coordinates);

  @override
  final int id;
  @override
  final String name;
  @override
  @JsonKey(name: 'coord')
  final CoordinatesDtoRemote coordinates;

  factory CityDtoRemote.fromJson(Map<String, dynamic> json) =>
      _$CityDtoRemoteFromJson(json);
}

@JsonSerializable(createToJson: false)
class CoordinatesDtoRemote implements CoordinatesDto {
  const CoordinatesDtoRemote(this.lat, this.lon);

  @override
  final double lat;
  @override
  final double lon;

  factory CoordinatesDtoRemote.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesDtoRemoteFromJson(json);
}
