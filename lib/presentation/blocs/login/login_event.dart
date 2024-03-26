part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => <Object>[];
}

class SignInWithGoogle extends LoginEvent {}

class SignInWithEmailPassword extends LoginEvent {
  SignInWithEmailPassword({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;
}

class ResetPassword extends LoginEvent {
  ResetPassword({
    required this.email,
  });
  final String email;
}

class SignUpWithEmail extends LoginEvent {
  SignUpWithEmail({
    required this.email,
    required this.password,
    required this.agreeTerms,
  });
  final String email;
  final String password;
  final bool agreeTerms;
}

class GetDataTermsFireBase extends LoginEvent {}

class UserLoaded extends LoginEvent {
  UserLoaded({
    required this.usersModel,
  });
  final UsersModel usersModel;
}

class ChatsUpdatedState extends LoginState {
  const ChatsUpdatedState(this.chats)
      : super(
          status: Status.success,
        );
  final List<ChatUser> chats;
}
