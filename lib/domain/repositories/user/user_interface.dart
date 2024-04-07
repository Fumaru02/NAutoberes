import '../../models/brands_car_model.dart';

abstract class IUserRepository {
  Future<void> onSubmittedForm(String lat, String long, String homeServiceName,
      String homeServiceAddress, String homeServiceSkill);
  Future<void> onSubmitBrands(List<BrandsCarModel> handledBrands);
}
