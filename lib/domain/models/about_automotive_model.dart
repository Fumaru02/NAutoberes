import 'package:json_annotation/json_annotation.dart';

part 'about_automotive_model.g.dart';

@JsonSerializable()
class AboutAutomotiveModel {
  AboutAutomotiveModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.source,
    required this.description,
  });
  factory AboutAutomotiveModel.fromJson(Map<String, dynamic> json) =>
      _$AboutAutomotiveModelFromJson(json);
  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'title')
  String title;
  @JsonKey(name: 'image_url')
  String imageUrl;
  @JsonKey(name: 'description')
  String description;
  @JsonKey(name: 'source')
  String source;

  Map<String, dynamic> toJson() => _$AboutAutomotiveModelToJson(this);
}
