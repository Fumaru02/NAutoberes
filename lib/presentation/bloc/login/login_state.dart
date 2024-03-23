part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, error }

class LoginState extends Equatable {
  const LoginState({
    this.loginStatus = LoginStatus.initial,
    this.usersModel,
  });

  factory LoginState.initial() => const LoginState();

  final LoginStatus loginStatus;
  final UsersModel? usersModel;

  @override
  List<Object?> get props => <Object?>[loginStatus, usersModel];

  LoginState copyWith({
    LoginStatus? loginStatus,
    UsersModel? usersModel,
  }) {
    return LoginState(
      loginStatus: loginStatus ?? this.loginStatus,
      usersModel: usersModel ?? this.usersModel,
    );
  }

  @override
  String toString() =>
      'LoginState(loginStatus: $loginStatus, usersModel: $usersModel)';
}
