import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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
    on<OnInitBottomNavBar>(_onTapBottomNavBar);
    on<OnTapBottomNav>(_onChangeIndex);
    on<OnCheckUserNavigate>(_checkUserNavigate);
  }

  void _onTapBottomNavBar(FrameEvent event, Emitter<FrameState> emit) {
    emit(state.copyWith(
      identifierList: <OnTapIdentifier>[
        OnTapIdentifier(name: 'Home', index: 0, isOnTapped: true),
        OnTapIdentifier(name: 'Chat', index: 1, isOnTapped: false),
        OnTapIdentifier(name: 'Services', index: 2, isOnTapped: false),
        OnTapIdentifier(name: 'Workshop', index: 3, isOnTapped: false),
        OnTapIdentifier(name: 'Akun', index: 4, isOnTapped: false),
      ],
      widgetViewList: <Widget>[
        const HomeView(),
        const ChatView(),
        const HomeServicesView(),
        const WorkshopView(),
        const AkunView(),
      ],
      defaultIndex: 0,
    ));
    log(state.identifierList.length.toString());
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
