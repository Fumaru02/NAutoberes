part of 'authorize_bloc.dart';

abstract class AuthorizeEvent extends Equatable {}

class GetValidateUser extends AuthorizeEvent {
  @override
  List<Object?> get props => <Object?>[];
}
