import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../services/shared_pref.dart';
import '../utils/preferences_key.dart';

class AuthorizeController extends GetxController {
  final SharedPref sharedPref = SharedPref();
  @override
  void onInit() {
    super.onInit();
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
}
