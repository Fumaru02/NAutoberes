import 'package:json_annotation/json_annotation.dart';

part 'beresin_menu_model.g.dart';

@JsonSerializable()
class BeresinMenuModel {
  BeresinMenuModel({
    required this.id,
    required this.title,
    required this.imageUrl,

  });
  factory BeresinMenuModel.fromJson(Map<String, dynamic> json) =>
      _$BeresinMenuModelFromJson(json);
  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'title')
  String title;
  @JsonKey(name: 'image_url')
  String imageUrl;

  Map<String, dynamic> toJson() => _$BeresinMenuModelToJson(this);
}
