import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/routes/app_routes.dart';
import '../../../domain/models/brands_car_model.dart';
import '../../../domain/models/specialist_model.dart';
import '../../../domain/repositories/firebase/firebase_interface.dart';
import '../../../domain/repositories/firebase/firebase_repository.dart';

part 'home_service_manager_state_cubit.dart';

class HomeServiceManagerCubit extends Cubit<HomeServiceManagerStateCubit> {
  HomeServiceManagerCubit() : super(HomeServiceManagerStateCubit.initial());

  final List<SpecialistModel> specialistList = <SpecialistModel>[];
  final List<SpecialistModel> selectedSpecialist = <SpecialistModel>[];

  Future<dynamic> pickImage(ImageSource source) async {
    final IFirebaseRepository firebaseRepository = FirebaseRepository();
    try {
      emit(state.copyWith(imageStatus: ImageStatus.loading));
      final XFile? image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        emit(state.copyWith(imageStatus: ImageStatus.failed));
      }
      final File imageTemp = File(image!.path);
      firebaseRepository.uploadImage(imageTemp);
      router.pop();
      emit(state.copyWith(
          imageStatus: ImageStatus.success, workshopImage: imageTemp));
    } on PlatformException catch (e) {
      if (e.code != null) {
        log(e.toString());
        emit(state.copyWith(imageStatus: ImageStatus.failed));
      }
    }
  }

  void getValue(List<BrandsCarModel> data) {
    emit(state.copyWith(selectedBrand: data));
  }

  void toggleSelectionBrand(BrandsCarModel item) {
    final List<BrandsCarModel> updatedSelectedBrand =
        List<BrandsCarModel>.from(state.selectedBrand);
    if (updatedSelectedBrand.contains(item)) {
      updatedSelectedBrand.remove(item);
    } else {
      updatedSelectedBrand.add(item);
    }
    emit(state.copyWith(selectedBrand: updatedSelectedBrand));
  }

  void searchSpecialist(String query) {
    final List<SpecialistModel> suggestions =
        specialistList.where((SpecialistModel brandKey) {
      final String brandName = brandKey.brand.toLowerCase();
      final String input = query.toLowerCase();
      return brandName.contains(input);
    }).toList();

    emit(state.copyWith(selectedSpecialist: suggestions));
  }

  void toggleSelectionSpecialist(SpecialistModel item) {
    final List<SpecialistModel> updatedSelectedSpecialist =
        List<SpecialistModel>.from(state.selectedSpecialist);
    if (updatedSelectedSpecialist.contains(item)) {
      updatedSelectedSpecialist.remove(item);
    } else {
      updatedSelectedSpecialist.add(item);
    }
    emit(state.copyWith(selectedSpecialist: updatedSelectedSpecialist));
  }
}
