import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getWarning();
  }

  @override
  void onClose() {
    super.onClose();
    chatEditingController.dispose();
  }

  TextEditingController chatEditingController = TextEditingController();
  final RxBool isUserTyping = RxBool(false);
  final RxBool isHideWarning = RxBool(false);
  final RxString myMessage = RxString('');
  final RxString warningChat = RxString('');
  final RxString currentUserId = RxString('');
  final RxString currentUserEmail = RxString('');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int totalUnread = 0;

  Future<void> getWarning() async {
    try {
      await _firestore
          .collection('data')
          .doc('text')
          .get()
          .then((DocumentSnapshot<dynamic> documentSnapshot) {
        final Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        warningChat.value = data['warning_chat'] as String;
      });

      update();
    } catch (e) {
      log(e.toString());
    }
  }

  // Future<void> onBackReadChat(
  //   String chatIds,
  //   String mechanicUid,
  // ) async {
  //   final CollectionReference<Map<String, dynamic>> chats =
  //       _firestore.collection('chats');
  //   final CollectionReference<Map<String, dynamic>> users =
  //       _firestore.collection('users');
  //   await _updateStatus(chatIds, mechanicUid, chats, users);
  // }

  // Future<void> _updateStatus(
  //     String chatIds,
  //     String mechanicUid,
  //     CollectionReference<Map<String, dynamic>> chats,
  //     CollectionReference<Map<String, dynamic>> users) async {
  //   final QuerySnapshot<Map<String, dynamic>> updateStatusChat = await chats
  //       .doc(chatIds)
  //       .collection('chat')
  //       .where('isRead', isEqualTo: false)
  //       .where('penerima', isEqualTo: mechanicUid)
  //       .get();

  //   updateStatusChat.docs
  //       // ignore: avoid_function_literals_in_foreach_calls
  //       .forEach((QueryDocumentSnapshot<Map<String, dynamic>> element) async {
  //     await chats
  //         .doc(chatIds)
  //         .collection('chat')
  //         .doc(element.id)
  //         .update(<String, dynamic>{
  //       'isRead': true,
  //     });
  //   });
  //   await users
  //       .doc(mechanicUid)
  //       .collection('chats')
  //       .doc(chatIds)
  //       .update(<Object, Object?>{
  //     'total_unread': 0,
  //   });
  // }

  // Future<void> newChat(String mechanicUid, Map<String, dynamic> arguments,
  //     String chatText, String userUid) async {
  //   if (chatText.isNotEmpty || chatText == ''.trim()) {
  //     final CollectionReference<Map<String, dynamic>> chats =
  //         _firestore.collection('chats');
  //     final CollectionReference<Map<String, dynamic>> users =
  //         _firestore.collection('users');
  //     final String date = DateTime.now().toIso8601String();
  //     await _updateStatus(
  //         arguments['chat_id'] as String, mechanicUid, chats, users);
  //     await chats.doc(arguments['chat_id'] as String).collection('chat').add(
  //       <String, dynamic>{
  //         'pengirim': mechanicUid,
  //         'penerima': userUid,
  //         'msg': chatText,
  //         'time': date,
  //         'isRead': false,
  //         'group_time': DateFormat.yMMMMd('en_US').format(DateTime.parse(date)),
  //       },
  //     );
  //     chatEditingController.clear();

  //     await users
  //         .doc(mechanicUid)
  //         .collection('chats')
  //         .doc(arguments['chat_id'] as String)
  //         .update(<String, dynamic>{
  //       'last_time': date,
  //     });
  //     final DocumentSnapshot<Map<String, dynamic>> checkChatMechanic =
  //         await users
  //             .doc(userUid)
  //             .collection('chats')
  //             .doc(arguments['chat_id'] as String)
  //             .get();

  //     if (checkChatMechanic.exists) {
  //       //exists on Friend DB
  //       //first check total unread

  //       final QuerySnapshot<Map<String, dynamic>> checkTotalUnread = await chats
  //           .doc(arguments['chat_id'].toString())
  //           .collection('chat')
  //           .where('isRead', isEqualTo: false)
  //           .where('pengirim', isEqualTo: mechanicUid)
  //           .get();

  //       //totalUnread => user
  //       totalUnread = checkTotalUnread.docs.length;
  //       await users
  //           .doc(userUid)
  //           .collection('chats')
  //           .doc(arguments['chat_id'] as String)
  //           .update(<Object, Object?>{
  //         'last_time': date,
  //         'total_unread': totalUnread,
  //       });
  //     } else {
  //       //new
  //       await users
  //           .doc(userUid)
  //           .collection('chats')
  //           .doc(arguments['chat_id'] as String)
  //           .set(<String, dynamic>{
  //         'connection': mechanicUid,
  //         'last_time': date,
  //         'total_unread': 1,
  //       });
  //     }
  //   }
  // }

  // Future<void> goToChatRoom(
  //   String userUidChat,
  //   String chatId,
  //   String mechanicUid,
  //   String mechanicConnection,
  //   String receiverName,
  //   String receiverPic,
  // ) async {
  //   final CollectionReference<Map<String, dynamic>> chats =
  //       _firestore.collection('chats');
  //   final CollectionReference<Map<String, dynamic>> users =
  //       _firestore.collection('users');
  //   await _updateStatus(chatId, mechanicUid, chats, users);

  // Get.to(
  //   ChatRoomView(
  //     mechanicUid: mechanicUid,
  //     chatId: chatId,
  //     userUid: userUidChat,
  //     receiverName: receiverName,
  //     receiverPic: receiverPic,
  //   ),
  //   arguments: <String, dynamic>{
  //     'chat_id': chatId,
  //     'mechanic_uid': mechanicUid
  //   },
  // );
}
// }
