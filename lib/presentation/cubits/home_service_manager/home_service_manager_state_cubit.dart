part of 'home_service_manager_cubit.dart';

enum ImageStatus { initial, loading, success, failed }

class HomeServiceManagerStateCubit extends Equatable {
  const HomeServiceManagerStateCubit({
    required this.imageStatus,
    this.workshopImage,
    required this.foundedSpecialist,
    required this.selectedBrand,
    required this.selectedSpecialist,
  });

  factory HomeServiceManagerStateCubit.initial() =>
      const HomeServiceManagerStateCubit(
        selectedSpecialist: <SpecialistModel>[],
        imageStatus: ImageStatus.initial,
        foundedSpecialist: <SpecialistModel>[],
        selectedBrand: <BrandsCarModel>[],
      );

  final ImageStatus imageStatus;
  final File? workshopImage;
  final List<BrandsCarModel> selectedBrand;
  final List<SpecialistModel> foundedSpecialist;
  final List<SpecialistModel> selectedSpecialist;

  @override
  List<Object?> get props {
    return <Object?>[
      imageStatus,
      workshopImage,
      foundedSpecialist,
      selectedBrand,
      selectedSpecialist
    ];
  }

  HomeServiceManagerStateCubit copyWith({
    ImageStatus? imageStatus,
    File? workshopImage,
    List<BrandsCarModel>? selectedBrand,
    List<SpecialistModel>? foundedSpecialist,
    List<SpecialistModel>? selectedSpecialist,
  }) {
    return HomeServiceManagerStateCubit(
      imageStatus: imageStatus ?? this.imageStatus,
      foundedSpecialist: foundedSpecialist ?? this.foundedSpecialist,
      selectedSpecialist: selectedSpecialist ?? this.selectedSpecialist,
      selectedBrand: selectedBrand ?? this.selectedBrand,
      workshopImage: workshopImage ?? this.workshopImage,
    );
  }

  @override
  String toString() {
    return 'HomeServiceManagerStateCubit(imageStatus: $imageStatus, workshopImage: $workshopImage, selectedBrand: $selectedBrand, foundedSpecialist: $foundedSpecialist, selectedSpecialist: $selectedSpecialist)';
  }
}
