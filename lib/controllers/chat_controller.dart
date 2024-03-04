import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  TextEditingController chatEditingController = TextEditingController();
  final RxBool isUserTyping = RxBool(false);
  final RxString myMessage = RxString('');
  final RxString currentUserId = RxString('');
  final RxString currentUserEmail = RxString('');
}
