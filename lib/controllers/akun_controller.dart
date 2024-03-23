import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../core/services/shared_pref.dart';

class AkunController extends GetxController {
  @override
  void onInit() {
    getDataUser();
    super.onInit();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final SharedPref sharedPref = SharedPref();
  RxString username = RxString('');
  RxString userEmail = RxString('');
  RxString userStatus = RxString('');
  RxString userImage = RxString('');
  RxString userDescription = RxString('');
  RxString userGender = RxString('');
  RxString userProfiency = RxString('');
  RxString userCity = RxString('');
  RxString userSubdistrict = RxString('');
  RxBool isLoading = RxBool(false);

  final TextEditingController usernameTextEditingController =
      TextEditingController();

  Future<void> signOut() async {
    await GoogleSignIn().disconnect();
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    sharedPref.removeAccessToken();
    Get.offAllNamed('/login');
  }

  dynamic getDataUser() async {
    isLoading.value = true;
    await _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot<dynamic> documentSnapshot) {
      username.value = documentSnapshot.data()['username'] as String;
      userEmail.value = documentSnapshot.data()['email'] as String;
      userDescription.value = documentSnapshot.data()['description'] as String;
      userStatus.value = documentSnapshot.data()['status'] as String;
      userImage.value = documentSnapshot.data()['user_image'] as String;
      userProfiency.value = documentSnapshot.data()['profiency'] as String;
      userCity.value = documentSnapshot.data()['city'] as String;
      userSubdistrict.value = documentSnapshot.data()['subdistrict'] as String;
    });
    isLoading.value = false;
  }
}
