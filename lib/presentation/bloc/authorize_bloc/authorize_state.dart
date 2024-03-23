part of 'authorize_bloc.dart';

enum AuthenticatedStatus { initial, authenticated, unauthenticated }

class AuthorizeState extends Equatable {
  const AuthorizeState({
    required this.hasToken,
    required this.authenticatedStatus,
  });
  factory AuthorizeState.inital() => const AuthorizeState(
      hasToken: false, authenticatedStatus: AuthenticatedStatus.initial);

  final bool hasToken;
  final AuthenticatedStatus authenticatedStatus;

  @override
  List<Object> get props => <Object>[hasToken, authenticatedStatus];

  AuthorizeState copyWith({
    bool? hasToken,
    AuthenticatedStatus? authenticatedStatus,
  }) {
    return AuthorizeState(
      hasToken: hasToken ?? this.hasToken,
      authenticatedStatus: authenticatedStatus ?? this.authenticatedStatus,
    );
  }

  @override
  String toString() =>
      'AuthorizeState(hasToken: $hasToken, authenticatedStatus: $authenticatedStatus)';
}
