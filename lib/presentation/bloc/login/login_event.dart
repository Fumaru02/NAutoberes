part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => <Object>[];
}

class SignInWithGoogle extends LoginEvent {}

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
