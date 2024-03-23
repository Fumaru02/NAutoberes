// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'about_automotive_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AboutAutomotiveModel _$AboutAutomotiveModelFromJson(
        Map<String, dynamic> json) =>
    AboutAutomotiveModel(
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['image_url'] as String,
      source: json['source'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$AboutAutomotiveModelToJson(
        AboutAutomotiveModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image_url': instance.imageUrl,
      'description': instance.description,
      'source': instance.source,
    };
