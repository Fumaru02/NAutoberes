import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../../core/routes/app_routes.dart';
import '../../../domain/models/users_model.dart';
import '../../../domain/repositories/apps_info/apps_info_interface.dart';
import '../../../domain/repositories/apps_info/apps_info_repository.dart';
import '../../../domain/repositories/chat/chat_interface.dart';
import '../../../domain/repositories/chat/chat_repository.dart';
import '../../../domain/repositories/firebase/firebase_interface.dart';
import '../../../domain/repositories/firebase/firebase_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initial()) {
    on<GetDataTermsFireBase>(_getTermsAndCondition);
    on<SignInWithGoogle>(_tapSignInWithGoogle);
    on<SignInWithEmailPassword>(_tapSignInWithEmailPassword);
    on<SignUpWithEmail>(_tapSignUpWithEmail);
    on<ResetPassword>(_tapResetPassword);
  }

  //defined
  final IFirebaseRepository _firebaseRepository = FirebaseRepository();
  final IAppsInfoRepository _appsInfoRepository = AppsInfoRepository();
  final IChatRepository _chatRepository = ChatRepository();

  Future<void> _tapSignInWithGoogle(
    SignInWithGoogle event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final UsersModel? userModel =
          await _firebaseRepository.signInWithGoogle();
      final List<ChatUser> chatList =
          await _chatRepository.onCheckCollectionChat();
      emit(ChatsUpdatedState(chatList));
      final bool isAgree = await _firebaseRepository.isUserAgreeTerms();
      emit(state.copyWith(
          status: Status.success, usersModel: userModel, isAgree: isAgree));
      if (isAgree == true) {
        router.replace('/frame');
      } else {
        return;
      }
    } catch (e) {
      emit(state.copyWith(status: Status.error));
      log(e.toString());
    }
  }

  Future<void> _getTermsAndCondition(
    GetDataTermsFireBase event,
    Emitter<LoginState> emit,
  ) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> data =
          await _appsInfoRepository.termsAndConditions();
      emit(state.copyWith(
        status: Status.success,
        termsAndcondition: data['data']['termsOfUse'] as String,
        privacyPolicy: data['data']['privacy_policy'] as String,
      ));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> _tapSignUpWithEmail(
      SignUpWithEmail event, Emitter<LoginState> emit) async {
    try {
      final dynamic validate =
          await _firebaseRepository.signUpWithEmailAndPassword(
              event.email, event.password, event.agreeTerms);
      log(validate.toString());
      if (validate == true) {
        emit(state.copyWith(status: Status.success));
      } else {
        emit(state.copyWith(
            status: Status.error, errorMessage: validate as String));
      }
    } catch (e) {
      e.toString();
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> _tapResetPassword(
      ResetPassword event, Emitter<LoginState> emit) async {
    try {
      final dynamic isReset =
          await _firebaseRepository.forgotPassword(event.email);
      if (isReset == true) {
        emit(state.copyWith(status: Status.success, isReset: isReset as bool));
      } else {
        emit(state.copyWith(
            status: Status.error, errorMessage: isReset as String));
      }
    } catch (e) {
      e.toString();
    }
  }

  Future<void> _tapSignInWithEmailPassword(
      SignInWithEmailPassword event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final dynamic loggedIn = await _firebaseRepository
          .signInWithEmailPassword(event.email, event.password);
      if (loggedIn == true) {
        router.replace('/frame');
        emit(state.copyWith(status: Status.success));
      } else {
        emit(state.copyWith(
            status: Status.error, errorMessage: loggedIn as String));
      }
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMessage: e.toString()));
    }
  }
}
