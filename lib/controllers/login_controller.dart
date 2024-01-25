import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../helpers/snackbar.dart';
import '../services/shared_pref.dart';
import '../utils/enums.dart';

class LoginController extends GetxController {
  final SharedPref sharedPref = SharedPref();
  final RxBool isObscurePassword = true.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool isTapped = false.obs;

  dynamic getUserToken() async {
    final String? token = await _auth.currentUser?.getIdToken();
    sharedPref.writeAccessToken(token!);
  }

  Future<void> signInWithGoogle() async {
    Future<dynamic>.delayed(const Duration(milliseconds: 200));
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
      final UserCredential userCreds =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCreds.user;
      if (userCreds.user != null) {
        isTapped.value = true;
        if (userCreds.additionalUserInfo!.isNewUser) {
          await _firestore
              .collection('users')
              .doc(user!.uid)
              .set(<String, dynamic>{
            'email': user.email,
            'status': 'User',
            'username': user.displayName,
            'user_image': user.photoURL,
            'description': '',
            'gender': '',
            'profiency': '',
            'city': '',
            'subdistrict': ''
          });
        }
        isTapped.value = false;
        Get.offAllNamed('/frame');
      } else {
        Snack.show(SnackbarType.error, 'invalid email',
            'Email tidak dapat ditemukan coba lagi');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<bool> resetPassword() async {
    try {
      await _auth.sendPasswordResetEmail(email: emailController.text.trim());
      return true;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          Snack.show(SnackbarType.error, 'invalid email',
              'Email tidak dapat ditemukan coba lagi');
          break;
        case 'user-not-found':
          Snack.show(SnackbarType.error, 'Unknown email',
              'Akun tidak dapat ditemukan coba lagi/password salah');
          break;
        default:
          Snack.show(SnackbarType.error, 'Error',
              'Something error please try again later');
      }
      return false;
    }
  }

  dynamic signInWithEmailAndPassword() async {
    try {
      isTapped.value = true;
      final UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      if (!credential.user!.emailVerified) {
        Snack.show(SnackbarType.error, 'Email Verification',
            'Email kamu belum terverifikasi mohon check inbox/spam');
        isTapped.value = false;
        return;
      }
      if (credential.user == null) {
        Snack.show(SnackbarType.error, 'Email Verification',
            'Email kamu belum terverifikasi mohon check inbox/spam');
        isTapped.value = false;
        return;
      }
      getUserToken();
      Get.offAllNamed('/frame');
      isTapped.value = false;

      return credential.user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          Snack.show(SnackbarType.error, 'invalid email',
              'Email tidak dapat ditemukan coba lagi');
          isTapped.value = false;
          break;
        case 'invalid-credential':
          Snack.show(SnackbarType.error, 'wrong email/password',
              'Email/Password salah coba lagi');
          isTapped.value = false;
          break;
        case 'user-not-found':
          Snack.show(SnackbarType.error, 'Unknown email',
              'Akun tidak dapat ditemukan coba lagi/password salah');
          isTapped.value = false;
          break;
        case 'ERROR_USER_DISABLED':
          Snack.show(SnackbarType.error, 'Error User',
              'Akunmu dihentikan untuk sementara waktu');
          isTapped.value = false;
          break;
        case 'ERROR_TOO_MANY_REQUESTS':
          Snack.show(
              SnackbarType.error, 'Error', 'Too many request try again later');
          isTapped.value = false;
          break;
        case 'ERROR_OPERATION_NOT_ALLOWED':
          Snack.show(SnackbarType.error, 'Unknown user', 'Operasi dihentikan');
          isTapped.value = false;
          break;
        default:
          Snack.show(SnackbarType.error, 'Error',
              'Something error please try again later');
          isTapped.value = false;
          return null;
      }
    }
  }
}
