import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../services/shared_pref.dart';

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
  RxString userStatus = RxString('');
  RxString userImage = RxString('');
  RxBool isLoading = RxBool(false);

  Future<void> signOut() async {
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
      userStatus.value = documentSnapshot.data()['status'] as String;
      userImage.value = documentSnapshot.data()['user_image'] as String;
      log(username.value);
      log(userStatus.value);
    });
    isLoading.value = false;
  }
}
