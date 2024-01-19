import 'package:get/get.dart';

class HomeServicesController extends GetxController {
  RxBool isTapped = RxBool(false);

  dynamic showHomeServices() {
    isTapped.value = true;
  }

  dynamic hideHomeServices() {
    isTapped.value = false;
  }
}
