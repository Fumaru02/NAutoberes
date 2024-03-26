import 'dart:math' as math;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_cubit_state.dart';

class LoginCubit extends Cubit<LoginCubitState> {
  LoginCubit() : super(LoginCubitState.initial());

  void isTappedAnimation() {
    emit(state.copyWith(tappedAnimation: !state.tappedAnimation));
  }

  void isObscurePasswordText() {
    emit(state.copyWith(isObscureText: !state.isObscureText));
  }

  void isFrontCard(double value) {
    if (value >= (math.pi / 2)) {
      emit(state.copyWith(isFront: false));
    } else {
      emit(state.copyWith(isFront: true));
    }
  }

  void isCheckedBox() {
    emit(state.copyWith(isChecked: !state.isChecked));
  }

  void flipped(double newAngle) {
    newAngle = (newAngle + math.pi) % (2 * math.pi);
    emit(state.copyWith(angle: newAngle));
  }
}
