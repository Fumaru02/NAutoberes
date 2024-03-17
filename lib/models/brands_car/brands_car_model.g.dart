// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brands_car_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandsCarModel _$BrandsCarModelFromJson(Map<String, dynamic> json) =>
    BrandsCarModel(
      id: json['id'] as String,
      brand: json['brand'] as String,
      brandImage: json['brand_image'] as String,
      isSelected: json['is_selected'] as bool,
    );

Map<String, dynamic> _$BrandsCarModelToJson(BrandsCarModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'brand': instance.brand,
      'brand_image': instance.brandImage,
      'is_selected': instance.isSelected,
    };
