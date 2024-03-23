import 'package:json_annotation/json_annotation.dart';

part 'city_model.g.dart';

@JsonSerializable()
class CityModel {

  CityModel({
    required this.id,
    required this.provinceId,
    required this.name,
  });
  factory CityModel.fromJson(Map<String, dynamic> json) =>
      _$CityModelFromJson(json);
  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'province_id')
  String provinceId;
  @JsonKey(name: 'name')
  String name;

  Map<String, dynamic> toJson() => _$CityModelToJson(this);
}
