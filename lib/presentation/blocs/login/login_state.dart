part of 'login_bloc.dart';

enum Status { initial, loading, success, error }

class LoginState extends Equatable {
  const LoginState({
    this.termsAndcondition = '',
    this.status = Status.initial,
    this.isAgree = false,
    this.privacyPolicy = '',
    this.errorMessage = '',
    this.usersModel,
    this.isReset = false,
  });

  factory LoginState.initial() => const LoginState();

  final String termsAndcondition;
  final Status status;
  final bool isAgree;
  final String privacyPolicy;
  final String errorMessage;
  final UsersModel? usersModel;
  final bool isReset;

  @override
  List<Object?> get props {
    return <Object?>[
      termsAndcondition,
      status,
      isAgree,
      privacyPolicy,
      errorMessage,
      usersModel,
      isReset,
    ];
  }

  LoginState copyWith({
    String? termsAndcondition,
    Status? status,
    bool? isAgree,
    String? privacyPolicy,
    String? errorMessage,
    UsersModel? usersModel,
    bool? isReset,
  }) {
    return LoginState(
      termsAndcondition: termsAndcondition ?? this.termsAndcondition,
      status: status ?? this.status,
      isAgree: isAgree ?? this.isAgree,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
      errorMessage: errorMessage ?? this.errorMessage,
      usersModel: usersModel ?? this.usersModel,
      isReset: isReset ?? this.isReset,
    );
  }

  @override
  String toString() {
    return 'LoginState(termsAndcondition: $termsAndcondition, status: $status, isAgree: $isAgree, privacyPolicy: $privacyPolicy, errorMessage: $errorMessage, usersModel: $usersModel, isReset: $isReset)';
  }
}
