import 'dart:developer';

import 'package:get/get.dart';

class WorkshopController extends GetxController {
  RxBool isTapped = RxBool(false);

  dynamic showWorkshop() {
    isTapped.value = true;
    log(isTapped.string);
  }

  dynamic hideWorkshop() {
    isTapped.value = false;
    log(isTapped.string);
  }
}
