import 'package:json_annotation/json_annotation.dart';

import '../brands_car/brands_car_model.dart';
import '../specialist/specialist_model.dart';

part 'list_mechanics_model.g.dart';

@JsonSerializable()
class ListMechanicsModel {
  ListMechanicsModel({
    required this.id,
    required this.name,
    required this.userRating,
    required this.homeServiceAddress,
    required this.homeServiceImage,
    required this.homeServiceName,
    required this.homeServiceSkill,
    required this.homeServiceLat,
    required this.homeServiceLong,
    required this.homeServiceCity,
    required this.homeServiceProfince,
    required this.homeServiceSubdistrict,
    required this.userEmail,
    required this.userLevel,
    required this.userUid,
    required this.handledBrands,
    required this.homeMechanicDescription,
    required this.handledSpecialist,
  });
  factory ListMechanicsModel.fromJson(Map<String, dynamic> json) =>
      _$ListMechanicsModelFromJson(json);
  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'user_uid')
  String userUid;
  @JsonKey(name: 'user_rating')
  double userRating;
  @JsonKey(name: 'user_level')
  String userLevel;
  @JsonKey(name: 'user_email')
  String userEmail;
  @JsonKey(name: 'home_service_skill')
  String homeServiceSkill;
  @JsonKey(name: 'home_service_name')
  String homeServiceName;
  @JsonKey(name: 'home_service_image')
  String homeServiceImage;
  @JsonKey(name: 'home_service_address')
  String homeServiceAddress;
  @JsonKey(name: 'home_service_lat')
  String homeServiceLat;
  @JsonKey(name: 'home_service_long')
  String homeServiceLong;
  @JsonKey(name: 'home_mechanic_description')
  String homeMechanicDescription;
  @JsonKey(name: 'home_service_profince')
  String homeServiceProfince;
  @JsonKey(name: 'home_service_city')
  String homeServiceCity;
  @JsonKey(name: 'home_service_subdistrict')
  String homeServiceSubdistrict;
  @JsonKey(name: 'handled_brands')
  List<BrandsCarModel> handledBrands;
  @JsonKey(name: 'handled_specialist')
  List<SpecialistModel> handledSpecialist;

  Map<String, dynamic> toJson() => _$ListMechanicsModelToJson(this);
}
