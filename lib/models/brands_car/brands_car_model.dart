import 'package:json_annotation/json_annotation.dart';

part 'brands_car_model.g.dart';

@JsonSerializable()
class BrandsCarModel {
  BrandsCarModel({
    required this.id,
    required this.brand,
    required this.brandImage,
  });
  factory BrandsCarModel.fromJson(Map<String, dynamic> json) =>
      _$BrandsCarModelFromJson(json);
  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'brand')
  String brand;
  @JsonKey(name: 'brand_image')
  String brandImage;

  Map<String, dynamic> toJson() => _$BrandsCarModelToJson(this);
}
