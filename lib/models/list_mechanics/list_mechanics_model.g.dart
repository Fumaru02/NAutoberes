// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_mechanics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListMechanicsModel _$ListMechanicsModelFromJson(Map<String, dynamic> json) =>
    ListMechanicsModel(
      id: json['id'] as String,
      name: json['name'] as String,
      userRating: (json['user_rating'] as num).toDouble(),
      homeServiceAddress: json['home_service_address'] as String,
      homeServiceImage: json['home_service_image'] as String,
      homeServiceName: json['home_service_name'] as String,
      homeServiceSkill: json['home_service_skill'] as String,
      homeServiceLat: json['home_service_lat'] as String,
      homeServiceLong: json['home_service_long'] as String,
      userEmail: json['user_email'] as String,
      userLevel: json['user_level'] as String,
      userUid: json['user_uid'] as String,
    );

Map<String, dynamic> _$ListMechanicsModelToJson(ListMechanicsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'user_uid': instance.userUid,
      'user_rating': instance.userRating,
      'user_level': instance.userLevel,
      'user_email': instance.userEmail,
      'home_service_skill': instance.homeServiceSkill,
      'home_service_name': instance.homeServiceName,
      'home_service_image': instance.homeServiceImage,
      'home_service_address': instance.homeServiceAddress,
      'home_service_lat': instance.homeServiceLat,
      'home_service_long': instance.homeServiceLong,
    };
