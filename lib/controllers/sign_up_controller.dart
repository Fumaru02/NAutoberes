import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helpers/snackbar.dart';
import '../utils/enums.dart';

class SignUpController extends GetxController {
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  dynamic clearTextController() {
    emailController.clear();
    fullnameController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  Future<bool> signUpWithEmailAndPassword() async {
    if (confirmPasswordController.text != passwordController.text) {
      Snack.show(SnackbarType.error, 'Information',
          'Your password is not matched try again');
      return false;
    } else if (passwordController.text.length < 6) {
      Snack.show(SnackbarType.error, 'Information',
          'Your password too weak try again');
      return false;
    }
    try {
      final UserCredential credential =
          await _auth.createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      await credential.user?.sendEmailVerification();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .set(
        <String, dynamic>{
          'username': fullnameController.text,
          'email': emailController.text,
          'status': 'User'
        },
      );

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Snack.show(SnackbarType.error, 'Error', 'weak password try again');
      } else if (e.code == 'email-already-in-use') {
        Snack.show(SnackbarType.info, 'Information',
            '${emailController.text} is already exists');
      } else if (e.code == 'invalid-email') {
        Snack.show(
            SnackbarType.error, 'Information', 'Your email id is invalid');
      }
    }
    return false;
  }
}
