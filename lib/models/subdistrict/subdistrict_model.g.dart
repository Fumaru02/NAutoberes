// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subdistrict_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubdistrictModel _$SubdistrictModelFromJson(Map<String, dynamic> json) =>
    SubdistrictModel(
      id: json['id'] as String,
      regencyId: json['regency_id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$SubdistrictModelToJson(SubdistrictModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'regency_id': instance.regencyId,
      'name': instance.name,
    };
