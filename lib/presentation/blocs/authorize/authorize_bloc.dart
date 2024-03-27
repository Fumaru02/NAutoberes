import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'authorize_event.dart';
part 'authorize_state.dart';

class AuthorizeBloc extends Bloc<AuthorizeEvent, AuthorizeState> {
  AuthorizeBloc() : super(AuthorizeState.inital()) {
    on<GetValidateUser>(_getValidateUser);
  }
  Future<void> _getValidateUser(
    GetValidateUser event,
    Emitter<AuthorizeState> emit,
  ) async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    final bool hasToken = sharedPref.getBool('keyAccessToken') ?? false;
    emit(state.copyWith(authenticatedStatus: AuthenticatedStatus.initial));
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    if (hasToken) {
      emit(state.copyWith(
          authenticatedStatus: AuthenticatedStatus.authenticated));
    } else {
      emit(state.copyWith(
          authenticatedStatus: AuthenticatedStatus.unauthenticated));
    }
  }
}
