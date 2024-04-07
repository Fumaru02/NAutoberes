import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../../core/routes/app_routes.dart';
import '../../../domain/models/brands_car_model.dart';
import '../../../domain/models/specialist_model.dart';
import '../../../domain/repositories/apps_info/apps_info_interface.dart';
import '../../../domain/repositories/apps_info/apps_info_repository.dart';
import '../../../domain/repositories/user/user_interface.dart';
import '../../../domain/repositories/user/user_repository.dart';

part 'home_service_manager_event.dart';
part 'home_service_manager_state.dart';

class HomeServiceManagerBloc
    extends Bloc<HomeServiceManagerEvent, HomeServiceManagerState> {
  HomeServiceManagerBloc() : super(HomeServiceManagerState.initial()) {
    on<GetBrands>(_onGetBrands);
    on<GetSpecialist>(_onGetSpecialist);
    on<OnConfirm>(_onConfirm);
    on<OnSearchBrand>(_onSearchBrand);
    on<OnUploadHandledBrands>(_onUploadBrands);
  }

  final IAppsInfoRepository _appsInfoRepository = AppsInfoRepository();
  final IUserRepository _userRepository = UserRepository();

  Future<void> _onGetBrands(
      GetBrands event, Emitter<HomeServiceManagerState> emit) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> dataBrands =
          await _appsInfoRepository.getBrands();
      final Map<String, dynamic>? brandsData = dataBrands.data();
      final List<dynamic> brands = brandsData![event.type] as List<dynamic>;
      final List<BrandsCarModel> data = brands
          .map(
              (dynamic e) => BrandsCarModel.fromJson(e as Map<String, dynamic>))
          .toList();
      if (event.type == 'brands_bike') {
        emit(state.copyWith(selectedDropDownMenu: 'Motor'));
      } else {
        emit(state.copyWith(selectedDropDownMenu: 'Mobil'));
      }
      emit(state.copyWith(
          homeServiceStatus: HomeServiceStatus.success, brandsList: data));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> _onGetSpecialist(
      GetSpecialist event, Emitter<HomeServiceManagerState> emit) async {
    emit(state.copyWith(homeServiceStatus: HomeServiceStatus.loading));
    try {
      final DocumentSnapshot<Map<String, dynamic>> dataBrands =
          await _appsInfoRepository.getSpecialist();
      final Map<String, dynamic>? specialistData = dataBrands.data();
      final List<dynamic> specialist =
          specialistData![event.type] as List<dynamic>;
      final List<SpecialistModel> data = specialist
          .map((dynamic e) =>
              SpecialistModel.fromJson(e as Map<String, dynamic>))
          .toList();
      emit(state.copyWith(
          homeServiceStatus: HomeServiceStatus.success, specialistList: data));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> _onConfirm(
      OnConfirm event, Emitter<HomeServiceManagerState> emit) async {
    if (event.lat == ''.trim() &&
        event.long == ''.trim() &&
        event.workshopImage == null &&
        event.homeServiceName.trim() == null &&
        event.homeServiceAddress == null &&
        event.homeServiceSkill == null) {
      emit(state.copyWith(homeServiceStatus: HomeServiceStatus.failed));
      return;
      // Snack.show(SnackbarType.error, 'ERROR Upload Data',
      //     'Pastikan kamu sudah mengisi form pendaftaran');
    } else {
      router.pop();
    }
    await _userRepository.onSubmittedForm(
        event.lat,
        event.long,
        event.homeServiceName,
        event.homeServiceAddress,
        event.homeServiceSkill);
  }

  void _onSearchBrand(
      OnSearchBrand event, Emitter<HomeServiceManagerState> emit) {
    final List<BrandsCarModel> suggestions =
        event.brandsList.where((BrandsCarModel brandKey) {
      final String brandName = brandKey.brand.toLowerCase();
      final String input = event.query.toLowerCase();
      return brandName.contains(input);
    }).toList();
    emit(state.copyWith(foundedBrand: suggestions));
  }

  Future<void> _onUploadBrands(OnUploadHandledBrands event,
      Emitter<HomeServiceManagerState> emit) async {
    await _userRepository.onSubmitBrands(event.dataHandled);
    //TODO: add brands
  }
}
