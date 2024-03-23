part of 'login_bloc.dart';

enum Status { initial, loading, success, error }

class LoginState extends Equatable {
  const LoginState({
    this.termsAndcondition = '',
    this.privacyPolicy = '',
    this.status = Status.initial,
    this.usersModel,
  });

  factory LoginState.initial() => const LoginState();

  final String termsAndcondition;
  final String privacyPolicy;
  final Status status;
  final UsersModel? usersModel;

  @override
  List<Object?> get props =>
      <Object?>[termsAndcondition, privacyPolicy, status, usersModel];

  LoginState copyWith({
    String? termsAndcondition,
    String? privacyPolicy,
    Status? status,
    UsersModel? usersModel,
  }) {
    return LoginState(
        termsAndcondition: termsAndcondition ?? this.termsAndcondition,
        privacyPolicy: privacyPolicy ?? this.privacyPolicy,
        usersModel: usersModel ?? this.usersModel,
        status: status ?? this.status);
  }

  @override
  String toString() {
    return 'LoginState(termsAndcondition: $termsAndcondition, privacyPolicy: $privacyPolicy, status: $status, usersModel: $usersModel)';
  }
}
