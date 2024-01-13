import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  final RxBool isUserTyping = RxBool(false);
  TextEditingController chatEditingController = TextEditingController();
  final RxString myMessage = RxString('');
}
