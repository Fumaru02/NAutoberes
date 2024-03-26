part of 'login_cubit.dart';

class LoginCubitState extends Equatable {
  const LoginCubitState({
    required this.isObscureText,
    required this.tappedAnimation,
    required this.isChecked,
    required this.isFront,
    required this.angle,
  });

  factory LoginCubitState.initial() => const LoginCubitState(
        tappedAnimation: false,
        isChecked: false,
        isObscureText: true,
        isFront: true,
        angle: 0,
      );
  final bool isObscureText;
  final bool tappedAnimation;
  final bool isChecked;
  final bool isFront;
  final double angle;

  @override
  List<Object> get props {
    return <Object>[
      isObscureText,
      tappedAnimation,
      isChecked,
      isFront,
      angle,
    ];
  }

  LoginCubitState copyWith({
    bool? isObscureText,
    bool? tappedAnimation,
    bool? isChecked,
    bool? isFront,
    double? angle,
  }) {
    return LoginCubitState(
      isObscureText: isObscureText ?? this.isObscureText,
      tappedAnimation: tappedAnimation ?? this.tappedAnimation,
      isChecked: isChecked ?? this.isChecked,
      isFront: isFront ?? this.isFront,
      angle: angle ?? this.angle,
    );
  }

  @override
  String toString() {
    return 'LoginCubitState(isObscureText: $isObscureText, tappedAnimation: $tappedAnimation, isChecked: $isChecked, isFront: $isFront, angle: $angle)';
  }
}
