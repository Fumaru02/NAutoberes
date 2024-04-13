import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../helpers/device_info.dart';
import '../services/shared_pref.dart';
import '../utils/preferences_key.dart';

class AuthorizeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final PageController pageController = PageController();

  final SharedPref sharedPref = SharedPref();
  late AnimationController animationController;
  Rx<String?> versionApp = Rx<String>('');
  Rx<String?> appName = Rx<String>('');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxInt appYear = DateTime.now().year.obs;
  final RxString termsOfUse = RxString('');
  final RxString privacyPolicy = RxString('');
  RxString tagHero = RxString('auth');

  @override
  void onInit() {
    super.onInit();
    getAuthData();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
    animationController.repeat();
    _getVersionApplicationInfo();
    _getValidateUser();
  }

  Future<void> getAuthData() async {
    try {
      await _firestore
          .collection('auth')
          .doc('newUser')
          .get()
          .then((DocumentSnapshot<dynamic> docSnapshot) {
        final Map<String, dynamic> data =
            docSnapshot.data() as Map<String, dynamic>;
        termsOfUse.value = data['data']['termsOfUse'] as String;
        privacyPolicy.value = data['data']['privacy_policy'] as String;
        update();
      });
    } catch (e) {
      log(e.toString());
    }
  }

  dynamic _getValidateUser() async {
    final bool hasToken =
        await sharedPref.hasData(PreferencesKey.keyAccessToken);
    log(hasToken.toString());
    Future<void>.delayed(const Duration(milliseconds: 200), () async {
      if (hasToken == true) {
        Get.offAllNamed('/frame');
      } else {
        Get.offAllNamed('/login');
      }
    });
  }

  Future<void> _getVersionApplicationInfo() async {
    final String? packageInfoVersion = await DeviceInfo().getVersionApp();
    final String? packageInfoName = await DeviceInfo().getAppName();
    versionApp.value = packageInfoVersion;
    appName.value = packageInfoName;
  }
}
