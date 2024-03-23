import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../domain/models/users_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initial()) {
    on<SignInWithGoogle>(_signInWithGoogle);
  }

  Future<void> _signInWithGoogle(
    SignInWithGoogle event,
    Emitter<LoginState> emit,
  ) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      emit(state.copyWith(loginStatus: LoginStatus.loading));
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
      final UserCredential userCreds =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCreds.user;
      if (userCreds.user != null) {
        final CollectionReference<dynamic> users =
            firestore.collection('users');
        if (userCreds.additionalUserInfo!.isNewUser) {
          await users.doc(user!.uid).set(<String, dynamic>{
            'user_uid': user.uid,
            'update_time': DateTime.now().toIso8601String(),
            'creation_time': user.metadata.creationTime!.toIso8601String(),
            'last_sign_in_time':
                user.metadata.lastSignInTime!.toIso8601String(),
            'email': user.email,
            'status': 'User',
            'key_name': user.displayName!.substring(0, 1).toUpperCase(),
            'username': user.displayName,
            'user_image': user.photoURL,
            'description': '',
            'gender': '',
            'profiency': '',
            'city': '',
            'subdistrict': '',
          });

          users.doc(user.uid).collection('chats');
        } else {
          await users.doc(user!.uid).update(<Object, Object?>{
            'last_sign_in_time':
                user.metadata.lastSignInTime!.toIso8601String(),
          });
        }

        //
      } else {
        // Snack.show(SnackbarType.error, 'invalid email',
        //     'Email tidak dapat ditemukan coba lagi');
      }
    } catch (e) {}
  }
}
