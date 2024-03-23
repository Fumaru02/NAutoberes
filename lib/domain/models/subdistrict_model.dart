import 'package:json_annotation/json_annotation.dart';

part 'subdistrict_model.g.dart';

@JsonSerializable()
class SubdistrictModel {
  SubdistrictModel({
    required this.id,
    required this.regencyId,
    required this.name,
  });

  factory SubdistrictModel.fromJson(Map<String, dynamic> json) =>
      _$SubdistrictModelFromJson(json);
  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'regency_id')
  String regencyId;
  @JsonKey(name: 'name')
  String name;

  Map<String, dynamic> toJson() => _$SubdistrictModelToJson(this);
}
