import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../views/chat/chat_room_view.dart';

class ChatController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    focusNode = FocusNode();
  }

  @override
  void onClose() {
    super.onClose();
    chatEditingController.dispose();
    focusNode.dispose();
  }

  TextEditingController chatEditingController = TextEditingController();
  late ScrollController scrollController = ScrollController();
  late FocusNode focusNode;
  final RxBool isUserTyping = RxBool(false);
  final RxString myMessage = RxString('');
  final RxString currentUserId = RxString('');
  final RxString currentUserEmail = RxString('');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int totalUnread = 0;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamChats(String chatId) {
    final CollectionReference<Map<String, dynamic>> chats =
        _firestore.collection('chats');
    return chats.doc(chatId).collection('chat').orderBy('time').snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> chatsStream(String mechanicUid) {
    return _firestore
        .collection('users')
        .doc(mechanicUid)
        .collection('chats')
        .orderBy('last_time', descending: true)
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> mechanicsChat(
      String mechanicUid) {
    return _firestore.collection('users').doc(mechanicUid).snapshots();
  }

  Future<void> newChat(String mechanicUid, Map<String, dynamic> arguments,
      String chatText, String userUid) async {
    if (chatText != '' || chatText == ''.trim()) {
      log('$userUid mekanikuid');
      final CollectionReference<Map<String, dynamic>> chats =
          _firestore.collection('chats');
      final CollectionReference<Map<String, dynamic>> users =
          _firestore.collection('users');
      final String date = DateTime.now().toIso8601String();

      await chats.doc(arguments['chat_id'] as String).collection('chat').add(
        <String, dynamic>{
          'pengirim': mechanicUid,
          'penerima': userUid,
          'msg': chatText,
          'time': date,
          'isRead': false,
          'group_time': DateFormat.yMMMMd('en_US').format(DateTime.parse(date)),
        },
      );

      Timer(
          Duration.zero,
          () => scrollController
              .jumpTo(scrollController.position.maxScrollExtent));
      chatEditingController.clear();

      await users
          .doc(mechanicUid)
          .collection('chats')
          .doc(arguments['chat_id'] as String)
          .update(<String, dynamic>{
        'last_time': date,
      });
      final DocumentSnapshot<Map<String, dynamic>> checkChatMechanic =
          await users
              .doc(userUid)
              .collection('chats')
              .doc(arguments['chat_id'] as String)
              .get();

      if (checkChatMechanic.exists) {
        //exists on Friend DB
        //first check total unread

        final QuerySnapshot<Map<String, dynamic>> checkTotalUnread = await chats
            .doc(arguments['chat_id'].toString())
            .collection('chat')
            .where('isRead', isEqualTo: false)
            .where('pengirim', isEqualTo: mechanicUid)
            .get();

        //totalUnread => user
        totalUnread = checkTotalUnread.docs.length;
        await users
            .doc(userUid)
            .collection('chats')
            .doc(arguments['chat_id'] as String)
            .update(<Object, Object?>{
          'last_time': date,
          'total_unread': totalUnread,
        });
      } else {
        //new
        await users
            .doc(userUid)
            .collection('chats')
            .doc(arguments['chat_id'] as String)
            .set(<String, dynamic>{
          'connection': mechanicUid,
          'last_time': date,
          'total_unread': 1,
        });
      }
    }
  }

  Future<void> goToChatRoom(
    String userUidChat,
    String chatId,
    String mechanicUid,
    String mechanicConnection,
    String receiverName,
    String receiverPic,
  ) async {
    final CollectionReference<Map<String, dynamic>> chats =
        _firestore.collection('chats');
    final CollectionReference<Map<String, dynamic>> users =
        _firestore.collection('users');
    final QuerySnapshot<Map<String, dynamic>> updateStatusChat = await chats
        .doc(chatId)
        .collection('chat')
        .where('isRead', isEqualTo: false)
        .where('penerima', isEqualTo: mechanicUid)
        .get();

    updateStatusChat.docs
        // ignore: avoid_function_literals_in_foreach_calls
        .forEach((QueryDocumentSnapshot<Map<String, dynamic>> element) async {
      element.id;

      await chats
          .doc(chatId)
          .collection('chat')
          .doc(element.id)
          .update(<Object, Object?>{
        'isRead': true,
      });
    });

    await users
        .doc(mechanicUid)
        .collection('chats')
        .doc(chatId)
        .update(<Object, Object?>{
      'total_unread': 0,
    });
    Get.to(
      ChatRoomView(
        chatId: chatId,
        userUid: userUidChat,
        receiverName: receiverName,
        receiverPic: receiverPic,
      ),
      arguments: <String, dynamic>{
        'chat_id': chatId,
        'mechanic_uid': mechanicUid
      },
    );
  }
}
