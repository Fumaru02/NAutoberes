import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

part 'home_cubit_state.dart';

class HomeCubit extends Cubit<HomeCubitState> {
  HomeCubit() : super(HomeCubitState.initial());

  void updateGreating() {
    final int hour = DateTime.now().hour;
    if (hour >= 5 && hour < 10) {
      emit(state.copyWith(greetings: 'Selamat Pagi'));
    } else if (hour >= 10 && hour < 15) {
      emit(state.copyWith(greetings: 'Selamat Siang'));
    } else if (hour >= 15 && hour < 18) {
      emit(state.copyWith(greetings: 'Selamat Sore'));
    } else {
      emit(state.copyWith(greetings: 'Selamat Malam'));
    }
  }

  void listen(ScrollController scrollController) {
    final ScrollDirection direction =
        scrollController.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      emit(state.copyWith(isVisible: false));
    } else if (direction == ScrollDirection.reverse) {
      emit(state.copyWith(isVisible: true));
    } else {}
  }
}
