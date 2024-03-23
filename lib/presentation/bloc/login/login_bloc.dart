import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/routes/app_routes.dart';
import '../../../domain/models/users_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initial()) {
    on<GetDataTermsFireBase>(_getTermsAndCondition);
    on<SignInWithGoogle>(_signInWithGoogle);
  }
  Future<void> _signInWithGoogle(
    SignInWithGoogle event,
    Emitter<LoginState> emit,
  ) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      emit(state.copyWith(status: Status.loading));
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
        final DocumentSnapshot<Object?> currUser = await FirebaseFirestore
            .instance
            .collection('users')
            .doc(user.uid)
            .get();
        final Map<String, dynamic> currUserData =
            currUser.data()! as Map<String, dynamic>;
        final UsersModel userModel = UsersModel.fromJson(currUserData);
        emit(state.copyWith(status: Status.success, usersModel: userModel));
        final QuerySnapshot<Map<String, dynamic>> listChats =
            await FirebaseFirestore.instance.collection('chats').get();
        if (listChats.docs.isNotEmpty) {
          final List<ChatUser> dataListChat = <ChatUser>[];
          for (final QueryDocumentSnapshot<Map<String, dynamic>> element
              in listChats.docs) {
            final Map<String, dynamic> dataDocChat = element.data();
            final String dataDocChatId = element.id;
            dataListChat.add(
              ChatUser(
                chatId: dataDocChatId,
                connection: dataDocChat['connection'] as String?,
                lastTime: dataDocChat['last_time'] as String?,
                totalUnread: dataDocChat['total_unread'] as int?,
              ),
            );
          }
          emit(ChatsUpdatedState(dataListChat));
        } else {
          emit(const ChatsUpdatedState(<ChatUser>[]));
        }
        emit(state.copyWith(status: Status.success));
        router.replace('/frame');
      } else {
        emit(state.copyWith(status: Status.error));
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
      emit(state.copyWith(status: Status.loading));
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      final DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await firestore.collection('auth').doc('newUser').get();

      final Map<String, dynamic>? data = docSnapshot.data();

      if (data != null) {
        final String termsAndCondition = data['data']['termsOfUse'] as String;
        final String privacyPolicy = data['data']['privacy_policy'] as String;
        emit(state.copyWith(
          status: Status.success,
          termsAndcondition: termsAndCondition,
          privacyPolicy: privacyPolicy,
        ));
        log(state.termsAndcondition);
      } else {
        emit(state.copyWith(
          status: Status.error,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: Status.error,
      ));
    } finally {}
  }
}
