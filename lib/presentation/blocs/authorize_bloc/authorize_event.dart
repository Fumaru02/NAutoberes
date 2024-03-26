part of 'authorize_bloc.dart';

abstract class AuthorizeEvent extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class GetValidateUser extends AuthorizeEvent {}
