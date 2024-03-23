// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specialist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpecialistModel _$SpecialistModelFromJson(Map<String, dynamic> json) =>
    SpecialistModel(
      id: json['id'] as int,
      brand: json['title'] as String,
      isSelected: json['is_selected'] as bool,
    );

Map<String, dynamic> _$SpecialistModelToJson(SpecialistModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.brand,
      'is_selected': instance.isSelected,
    };
