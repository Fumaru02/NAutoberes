import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../helpers/snackbar.dart';
import '../services/shared_pref.dart';
import '../utils/enums.dart';

class LoginController extends GetxController {
  final SharedPref sharedPref = SharedPref();
  final RxBool isObscurePassword = true.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  dynamic signInWithEmailAndPassword() async {
    try {
      final UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      if (!credential.user!.emailVerified) {
        Snack.show(SnackbarType.error, 'Email Verification',
            'Email kamu belum terverifikasi mohon check inbox/spam');
        return;
      }
      if (credential.user == null) {
        Snack.show(SnackbarType.error, 'Email Verification',
            'Email kamu belum terverifikasi mohon check inbox/spam');
        return;
      }
      final String? token = await _auth.currentUser?.getIdToken();
      sharedPref.writeAccessToken(token!);
      Get.offAllNamed('/frame');
      return credential.user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'ERROR_INVALID_EMAIL':
          Snack.show(SnackbarType.error, 'invalid email',
              'Email tidak dapat ditemukan coba lagi');
          break;
        case 'ERROR_WRONG_PASSWORD':
          Snack.show(
              SnackbarType.error, 'Wrong password', 'Password salah coba lagi');
          break;
        case 'ERROR_USER_NOT_FOUND':
          Snack.show(SnackbarType.error, 'Unknown email',
              'Akun tidak dapat ditemukan coba lagi/password salah');
          break;
        case 'ERROR_USER_DISABLED':
          Snack.show(SnackbarType.error, 'Error User',
              'Akunmu dihentikan untuk sementara waktu');
          break;
        case 'ERROR_TOO_MANY_REQUESTS':
          Snack.show(
              SnackbarType.error, 'Error', 'Too many request try again later');
          break;
        case 'ERROR_OPERATION_NOT_ALLOWED':
          Snack.show(SnackbarType.error, 'Unknown user', 'Operasi dihentikan');
          break;
        default:
          Snack.show(SnackbarType.error, 'Error',
              'Something error please try again later');

          return null;
      }
    }
  }
}
