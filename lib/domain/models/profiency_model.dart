import 'package:json_annotation/json_annotation.dart';

part 'profiency_model.g.dart';

@JsonSerializable()
class ProfiencyModel {
  ProfiencyModel({
    required this.id,
    required this.name,
  });
  factory ProfiencyModel.fromJson(Map<String, dynamic> json) =>
      _$ProfiencyModelFromJson(json);
  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'name')
  String name;
  Map<String, dynamic> toJson() => _$ProfiencyModelToJson(this);
}
