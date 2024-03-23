part of 'login_cubit.dart';

class LoginCubitState extends Equatable {
  const LoginCubitState({
    required this.tappedAnimation,
    required this.isChecked,
    required this.isFront,
    required this.angle,
  });

  factory LoginCubitState.initial() => const LoginCubitState(
        tappedAnimation: false,
        isChecked: false,
        isFront: true,
        angle: 0,
      );

  final bool tappedAnimation;
  final bool isChecked;
  final bool isFront;
  final double angle;

  @override
  List<Object> get props =>
      <Object>[tappedAnimation, angle, isFront, isChecked];

  LoginCubitState copyWith({
    bool? tappedAnimation,
    bool? isChecked,
    bool? isFront,
    double? angle,
  }) {
    return LoginCubitState(
      tappedAnimation: tappedAnimation ?? this.tappedAnimation,
      isChecked: isChecked ?? this.isChecked,
      isFront: isFront ?? this.isFront,
      angle: angle ?? this.angle,
    );
  }
}
