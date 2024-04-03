import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/models/about_automotive_model.dart';
import '../../../domain/models/beresin_menu_model.dart';
import '../../../domain/repositories/apps_info/apps_info_interface.dart';
import '../../../domain/repositories/apps_info/apps_info_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<GetDataHome>(_getContent);
    on<OnSlideChange>(_onPageChange);
    on<GetPromo>(_onGetPromo);
  }
  final IAppsInfoRepository _appsInfoRepository = AppsInfoRepository();

  Future<void> _getContent(HomeEvent event, Emitter<HomeState> emit) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await _appsInfoRepository.getContentHome();
      final Map<String, dynamic> data = documentSnapshot.data()!;
      final List<dynamic> beresinMenuData =
          data['beresin_menu'] as List<dynamic>;
      final List<dynamic> aboutAutomotiveData =
          data['about_automotive'] as List<dynamic>;
      emit(
        state.copyWith(
            aboutAutomotiveTitle: data['title'] as String,
            gridMenuTitle: data['beresin_title'] as String,
            aboutAutomotiveList: aboutAutomotiveData
                .map((dynamic e) =>
                    AboutAutomotiveModel.fromJson(e as Map<String, dynamic>))
                .toList(),
            beresinMenuList: beresinMenuData
                .map((dynamic e) =>
                    BeresinMenuModel.fromJson(e as Map<String, dynamic>))
                .toList()),
      );
    } catch (e) {
      log(e.toString());
    }
  }

  void _onPageChange(OnSlideChange event, Emitter<HomeState> emit) {
    emit(state.copyWith(currentDot: event.activeIndex));
  }

  Future<void> _onGetPromo(GetPromo event, Emitter<HomeState> emit) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await _appsInfoRepository.getPromo();
      final Map<String, dynamic> data = documentSnapshot.data()!;
      emit(
        state.copyWith(
            promoTitle: data['promo']['promo_title'] as String,
            promoImage: List<String>.from(
                data['promo']['promo_image'] as List<dynamic>)),
      );
    } catch (e) {
      log(e.toString());
    }
  }
}
