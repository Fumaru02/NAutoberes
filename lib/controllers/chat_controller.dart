import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../views/chat/chat_room_view.dart';

class ChatController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        Future<void>.delayed(
            const Duration(milliseconds: 500), () => scrollDownChat());
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    chatEditingController.dispose();
    myFocusNode.dispose();
  }

  TextEditingController chatEditingController = TextEditingController();
  late ScrollController scrollController = ScrollController();
  late FocusNode myFocusNode = FocusNode();
  final RxBool isUserTyping = RxBool(false);
  final RxString myMessage = RxString('');
  final RxString currentUserId = RxString('');
  final RxString currentUserEmail = RxString('');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int totalUnread = 0;

  Future<void> onBackReadChat(
    String chatIds,
    String mechanicUid,
  ) async {
    final CollectionReference<Map<String, dynamic>> chats =
        _firestore.collection('chats');
    final CollectionReference<Map<String, dynamic>> users =
        _firestore.collection('users');
    await _updateStatus(chatIds, mechanicUid, chats, users);
  }

  void scrollDownChat() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.fastOutSlowIn);
  }

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

  Future<void> _updateStatus(
      String chatIds,
      String mechanicUid,
      CollectionReference<Map<String, dynamic>> chats,
      CollectionReference<Map<String, dynamic>> users) async {
    final QuerySnapshot<Map<String, dynamic>> updateStatusChat = await chats
        .doc(chatIds)
        .collection('chat')
        .where('isRead', isEqualTo: false)
        .where('penerima', isEqualTo: mechanicUid)
        .get();

    updateStatusChat.docs
        // ignore: avoid_function_literals_in_foreach_calls
        .forEach((QueryDocumentSnapshot<Map<String, dynamic>> element) async {
      await chats
          .doc(chatIds)
          .collection('chat')
          .doc(element.id)
          .update(<String, dynamic>{
        'isRead': true,
      });
    });
    await users
        .doc(mechanicUid)
        .collection('chats')
        .doc(chatIds)
        .update(<Object, Object?>{
      'total_unread': 0,
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> mechanicsChat(
      String mechanicUid) {
    return _firestore.collection('users').doc(mechanicUid).snapshots();
  }

  Future<void> newChat(String mechanicUid, Map<String, dynamic> arguments,
      String chatText, String userUid) async {
    if (chatText.isNotEmpty || chatText == ''.trim()) {
      final CollectionReference<Map<String, dynamic>> chats =
          _firestore.collection('chats');
      final CollectionReference<Map<String, dynamic>> users =
          _firestore.collection('users');
      final String date = DateTime.now().toIso8601String();
      await _updateStatus(
          arguments['chat_id'] as String, mechanicUid, chats, users);
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
    await _updateStatus(chatId, mechanicUid, chats, users);

    Get.to(
      ChatRoomView(
        mechanicUid: mechanicUid,
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
