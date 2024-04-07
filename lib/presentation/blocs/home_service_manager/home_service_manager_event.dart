part of 'home_service_manager_bloc.dart';

sealed class HomeServiceManagerEvent extends Equatable {
  const HomeServiceManagerEvent();

  @override
  List<Object> get props => <Object>[];
}

class OnUploadHandledBrands extends HomeServiceManagerEvent {
  const OnUploadHandledBrands({
    required this.dataHandled,
  });
  final List<BrandsCarModel> dataHandled;
}

class OnConfirm extends HomeServiceManagerEvent {
  const OnConfirm({
    required this.lat,
    required this.long,
    required this.homeServiceName,
    required this.homeServiceSkill,
    required this.homeServiceAddress,
    required this.workshopImage,
  });
  final String lat;
  final String long;
  final String homeServiceName;
  final String homeServiceSkill;
  final String homeServiceAddress;
  final File workshopImage;
}

class OnSearchBrand extends HomeServiceManagerEvent {
  const OnSearchBrand({
    required this.query,
    required this.brandsList,
  });
  final String query;
  final List<BrandsCarModel> brandsList;
}

class GetBrands extends HomeServiceManagerEvent {
  const GetBrands({
    required this.type,
  });
  final String type;
}

class GetSpecialist extends HomeServiceManagerEvent {
  const GetSpecialist({
    required this.type,
  });
  final String type;
}
