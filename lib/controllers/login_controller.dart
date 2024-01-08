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
      if (e.code == 'user-not-found') {
        Snack.show(SnackbarType.error, 'Unknown email',
            'Akun tidak dapat ditemukan coba lagi/password salah');
      } else if (e.code == 'wrong-password') {
        Snack.show(
            SnackbarType.error, 'Wrong password', 'Password salah coba lagi');
      } else if (e.code == 'invalid-email') {
        Snack.show(SnackbarType.error, 'invalid email',
            'Email tidak dapat ditemukan coba lagi');
      } else if (e.code == 'error-user-not-found') {
        Snack.show(
            SnackbarType.error, 'Wrong password', 'Password salah coba lagi');
      }
      return null;
    }
  }
}
