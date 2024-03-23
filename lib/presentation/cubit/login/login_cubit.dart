import 'dart:math' as math;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginCubitState> {
  LoginCubit() : super(LoginCubitState.initial());

  void isTappedAnimation() {
    emit(state.copyWith(tappedAnimation: !state.tappedAnimation));
  }

  void isFrontCard(double value) {
    if (value >= (math.pi / 2)) {
      emit(state.copyWith(isFront: false));
    } else {
      emit(state.copyWith(isFront: true));
    }
  }
}
