part of 'home_service_manager_cubit.dart';

enum ImageStatus { initial, loading, success, failed }

class HomeServiceManagerStateCubit extends Equatable {
  const HomeServiceManagerStateCubit({
    required this.imageStatus,
    this.workshopImage,
    required this.selectedBrand,
    required this.getDataValue,
    required this.selectedSpecialist,
  });

  factory HomeServiceManagerStateCubit.initial() =>
      const HomeServiceManagerStateCubit(
        selectedSpecialist: <SpecialistModel>[],
        getDataValue: <BrandsCarModel>[],
        imageStatus: ImageStatus.initial,
        selectedBrand: <BrandsCarModel>[],
      );

  final ImageStatus imageStatus;
  final File? workshopImage;
  final List<BrandsCarModel> selectedBrand;
  final List<BrandsCarModel> getDataValue;
  final List<SpecialistModel> selectedSpecialist;

  @override
  List<Object?> get props {
    return <Object?>[
      imageStatus,
      workshopImage,
      selectedBrand,
      getDataValue,
      selectedSpecialist,
    ];
  }

  HomeServiceManagerStateCubit copyWith({
    ImageStatus? imageStatus,
    File? workshopImage,
    List<BrandsCarModel>? selectedBrand,
    List<BrandsCarModel>? getDataValue,
    List<SpecialistModel>? selectedSpecialist,
  }) {
    return HomeServiceManagerStateCubit(
      imageStatus: imageStatus ?? this.imageStatus,
      workshopImage: workshopImage ?? this.workshopImage,
      selectedBrand: selectedBrand ?? this.selectedBrand,
      getDataValue: getDataValue ?? this.getDataValue,
      selectedSpecialist: selectedSpecialist ?? this.selectedSpecialist,
    );
  }

  @override
  String toString() {
    return 'HomeServiceManagerStateCubit(imageStatus: $imageStatus, workshopImage: $workshopImage, selectedBrand: $selectedBrand, getDataValue: $getDataValue, selectedSpecialist: $selectedSpecialist)';
  }
}
