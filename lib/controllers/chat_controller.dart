import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  TextEditingController chatEditingController = TextEditingController();
  final RxBool isUserTyping = RxBool(false);
  final RxString myMessage = RxString('');
  final RxString currentUserId = RxString('');
  final RxString currentUserEmail = RxString('');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> chatsStream(
      String mechanicUid) {
    return _firestore.collection('users').doc(mechanicUid).snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> mechanicsChat(
      String mechanicUid) {
    return _firestore.collection('users').doc(mechanicUid).snapshots();
  }
}
