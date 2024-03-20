import 'package:json_annotation/json_annotation.dart';

part 'specialist_model.g.dart';

@JsonSerializable()
class SpecialistModel {
  SpecialistModel({
    required this.id,
    required this.brand,
    required this.isSelected,
  });
  factory SpecialistModel.fromJson(Map<String, dynamic> json) =>
      _$SpecialistModelFromJson(json);
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'title')
  String brand;
  @JsonKey(name: 'is_selected')
  bool isSelected;

  Map<String, dynamic> toJson() => _$SpecialistModelToJson(this);
}
