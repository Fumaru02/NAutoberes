import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../services/shared_pref.dart';

class AkunController extends GetxController {
  final SharedPref sharedPref = SharedPref();
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    sharedPref.removeAccessToken();
    Get.deleteAll();
    Get.offAllNamed('/login');
  }
}
