import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../core/constant/enums.dart';
import '../../../core/utils/on_tap_identifier.dart';
import '../../pages/akun/akun_view.dart';
import '../../pages/chat/chat_view.dart';
import '../../pages/home/home_view.dart';
import '../../pages/home_services/home_services_view.dart';
import '../../pages/workshop/workshop_view.dart';

part 'frame_event.dart';
part 'frame_state.dart';

class FrameBloc extends Bloc<FrameEvent, FrameState> {
  FrameBloc() : super(FrameState.initial()) {
    on<OnTapBottomNav>(_onChangeIndex);
    on<OnCheckUserNavigate>(_checkUserNavigate);
  }

  void _onChangeIndex(
    OnTapBottomNav event,
    Emitter<FrameState> emit,
  ) {
    final List<OnTapIdentifier> tempList = state.identifierList;
    for (final OnTapIdentifier element in tempList) {
      if (element.index == event.index) {
        tempList[event.index].isOnTapped = true;
      } else {
        tempList[element.index].isOnTapped = false;
      }
    }
    emit(
      state.copyWith(
        defaultIndex: event.index,
        identifierList: tempList,
      ),
    );
  }

  void _checkUserNavigate(
    OnCheckUserNavigate event,
    Emitter<FrameState> emit,
  ) {
    emit(state.copyWith(
      isOutsideFrame: event.status,
      currentRoute: event.route,
    ));
  }
}
