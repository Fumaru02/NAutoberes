import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../helpers/snackbar.dart';
import '../utils/enums.dart';

class LoginController extends GetxController {
  
  final RxBool isObscurePassword = true.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  dynamic signInWithEmailAndPassword() async {
    try {
      final UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      if (!credential.user!.emailVerified) {
        log('GAK BISA MASUK');
        Snack.show(SnackbarType.error, 'Email Verification',
            'Email kamu belum terverifikasi mohon check inbox/spam');
        return;
      }
      Get.offAllNamed('/frame');
      return credential.user;
    } catch (e) {
      log('$e');
    }
    return null;
  }
}
