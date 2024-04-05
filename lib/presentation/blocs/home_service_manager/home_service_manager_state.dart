part of 'home_service_manager_bloc.dart';

enum HomeServiceStatus { loading, success, failed, initial }

class HomeServiceManagerState extends Equatable {
  const HomeServiceManagerState({
    required this.homeServiceStatus,
    required this.brandsList,
    required this.foundedBrand,
    required this.specialistList,
    required this.selectedDropDownMenu,
  });

  factory HomeServiceManagerState.initial() => const HomeServiceManagerState(
      homeServiceStatus: HomeServiceStatus.initial,
      brandsList: <BrandsCarModel>[],
      specialistList: <SpecialistModel>[],
      foundedBrand: <BrandsCarModel>[],
      selectedDropDownMenu: '');

  final HomeServiceStatus homeServiceStatus;
  final List<BrandsCarModel> brandsList;
  final List<BrandsCarModel> foundedBrand;
  final List<SpecialistModel> specialistList;
  final String selectedDropDownMenu;

  @override
  List<Object> get props {
    return <Object>[
      homeServiceStatus,
      brandsList,
      foundedBrand,
      specialistList,
      selectedDropDownMenu,
    ];
  }

  HomeServiceManagerState copyWith({
    HomeServiceStatus? homeServiceStatus,
    List<BrandsCarModel>? brandsList,
    List<BrandsCarModel>? foundedBrand,
    List<SpecialistModel>? specialistList,
    String? selectedDropDownMenu,
  }) {
    return HomeServiceManagerState(
      homeServiceStatus: homeServiceStatus ?? this.homeServiceStatus,
      brandsList: brandsList ?? this.brandsList,
      foundedBrand: foundedBrand ?? this.foundedBrand,
      specialistList: specialistList ?? this.specialistList,
      selectedDropDownMenu: selectedDropDownMenu ?? this.selectedDropDownMenu,
    );
  }

  @override
  String toString() {
    return 'HomeServiceManagerState(homeServiceStatus: $homeServiceStatus, brandsList: $brandsList, foundedBrand: $foundedBrand, specialistList: $specialistList, selectedDropDownMenu: $selectedDropDownMenu)';
  }
}
