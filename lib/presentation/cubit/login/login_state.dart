part of 'login_cubit.dart';

class LoginCubitState extends Equatable {
  const LoginCubitState({
    required this.tappedAnimation,
    required this.isFront,
    required this.angle,
  });

  factory LoginCubitState.initial() => const LoginCubitState(
        tappedAnimation: false,
        isFront: false,
        angle: 0,
      );

  final bool tappedAnimation;
  final bool isFront;
  final double angle;

  @override
  List<Object> get props => <Object>[
        tappedAnimation,
        angle,
        isFront,
      ];

  LoginCubitState copyWith({
    bool? tappedAnimation,
    bool? isFront,
    double? angle,
  }) {
    return LoginCubitState(
      tappedAnimation: tappedAnimation ?? this.tappedAnimation,
      isFront: isFront ?? this.isFront,
      angle: angle ?? this.angle,
    );
  }
}
