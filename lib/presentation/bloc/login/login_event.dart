part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  @override
  List<Object> get props => <Object>[];
}

class SignInWithGoogle extends LoginEvent {}
