import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../models/users_model.dart';
import 'firebase_interface.dart';

class FirebaseRepository implements IFirebaseRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<UsersModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final UserCredential userCreds =
          await _auth.signInWithCredential(credential);
      final User? user = userCreds.user;

      if (user != null) {
        final CollectionReference<Map<String, dynamic>> users =
            _firestore.collection('users');
        if (userCreds.additionalUserInfo!.isNewUser) {
          await users.doc(user.uid).set(<String, dynamic>{
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
            'agree_terms_and_condition': true,
            'description': '',
            'gender': '',
            'profiency': '',
            'city': '',
            'subdistrict': '',
          });
          users.doc(user.uid).collection('chats');
        } else {
          await users.doc(user.uid).update(<Object, Object?>{
            'last_sign_in_time':
                user.metadata.lastSignInTime!.toIso8601String(),
          });
        }

        final DocumentSnapshot<Map<String, dynamic>> currUser =
            await _firestore.collection('users').doc(user.uid).get();
        final Map<String, dynamic> currUserData = currUser.data()!;
        final UsersModel userModel = UsersModel.fromJson(currUserData);
        return userModel;
      }

      throw FirebaseAuthException(
          code: 'user-not-found', message: 'User not found');
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<dynamic> signUpWithEmailAndPassword(
      String email, String password, bool agreeTerms) async {
    log(email);
    if (email.trim().isEmpty && password.trim().isEmpty) {
      return 'error';
    }
    try {
      final UserCredential credential =
          await _auth.createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim());
      await credential.user?.sendEmailVerification();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .set(
        <String, dynamic>{
          'user_uid': credential.user!.uid,
          'username': email,
          'email': email,
          'status': 'User',
          'user_image': '',
          'last_sign_in_time':
              credential.user!.metadata.lastSignInTime!.toIso8601String(),
          'key_name': email.substring(0, 1).toUpperCase(),
          'creation_time':
              credential.user!.metadata.creationTime!.toIso8601String(),
          'description': '',
          'agree_terms_and_condition': agreeTerms,
          'gender': '',
          'profiency': '',
          'city': '',
          'subdistrict': '',
        },
      );
      return true;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          return 'invalid email check again';
        case 'email-already-in-use':
          return 'email sudah terpakai';
        case 'weak-password':
          return 'password terlalu lemah';
      }
    }
  }

  @override
  Future<bool> isUserAgreeTerms() async {
    final DocumentSnapshot<Map<String, dynamic>> data = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get();
    final bool isAgree = data.data()!['agree_terms_and_condition'] as bool;
    return isAgree;
  }

  @override
  Future<dynamic> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      return true;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          return 'Email belum terdaftar';
        case 'user-not-found':
          return 'Akun tidak dapat ditemukan coba lagi/password salah';
        default:
          return 'Something error please try again later';
      }
    }
  }

  @override
  Future<dynamic> signInWithEmailPassword(String email, String password) async {
    try {
      final UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      if (!credential.user!.emailVerified) {
        return 'Email kamu belum terverifikasi mohon check inbox/spam';
      }
      if (credential.user == null) {
        return 'Email belum terdaftar';
      }
      // getUserToken();
      return true;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          return 'email tidak dapat di temukan';
        case 'invalid-credential':
          return 'Password salah';
        case 'user-not-found':
          return 'Akun tidak dapat ditemukan';
        case 'ERROR_USER_DISABLED':
          return 'Maaf akun anda di tangguhkan';
        case 'ERROR_TOO_MANY_REQUESTS':
          return 'Terlalu banyak permintaan coba lagi';
        case 'ERROR_OPERATION_NOT_ALLOWED':
          return 'Something error please try again later';
        default:
          return 'Something error please try again later';
      }
    }
  }
}
