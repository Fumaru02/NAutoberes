import 'dart:developer';

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
  RxInt appYear = DateTime.now().year.obs;
  RxString tagHero = RxString('auth');
  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
    animationController.repeat();
    _getVersionApplicationInfo();
    _getValidateUser();
  }

  dynamic _getValidateUser() async {
    final bool hasToken =
        await sharedPref.hasData(PreferencesKey.keyAccessToken);
    log(hasToken.toString());
    Future<void>.delayed(const Duration(milliseconds: 1000), () async {
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
