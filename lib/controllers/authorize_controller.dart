import 'package:get/get.dart';

class AuthorizeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _getValidateUser();
  }

  dynamic _getValidateUser() {
    Future<dynamic>.delayed(Duration.zero, () {
      Get.toNamed('/login');
    });
  }
}
