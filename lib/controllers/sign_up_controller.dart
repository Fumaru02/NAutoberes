import 'dart:developer';

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

  dynamic signUpWithEmailAndPassword() async {
    try {
      final UserCredential credential =
          await _auth.createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      await credential.user?.sendEmailVerification();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .set(
        {
          'username': fullnameController.text,
          'email': emailController.text,
          'status': 'User'
        },
      );
      log('MASUK');
      return credential.user;
    } catch (e) {
      log('$e');
    }

    return null;
  }
}
