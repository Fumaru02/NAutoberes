import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../helpers/device_indo.dart';
import '../services/shared_pref.dart';
import '../utils/preferences_key.dart';

class AuthorizeController extends GetxController {
  final SharedPref sharedPref = SharedPref();

  Rx<String?> versionApp = Rx<String>('');
  Rx<String?> appName = Rx<String>('');
  RxInt appYear = DateTime.now().year.obs;
  @override
  void onInit() {
    super.onInit();
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
        Get.offNamedUntil('/login', (Route<dynamic> route) => false);
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
