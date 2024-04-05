import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/users_model.dart';
import 'chat_interface.dart';

class ChatRepository implements IChatRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Future<List<ChatUser>> onCheckCollectionChat() async {
    final QuerySnapshot<Map<String, dynamic>> listChats =
        await _firestore.collection('chats').get();
    if (listChats.docs.isNotEmpty) {
      final List<ChatUser> dataListChat = <ChatUser>[];
      for (final QueryDocumentSnapshot<Map<String, dynamic>> element
          in listChats.docs) {
        final Map<String, dynamic> dataDocChat = element.data();
        final String dataDocChatId = element.id;
        dataListChat.add(
          ChatUser(
            chatId: dataDocChatId,
            connection: dataDocChat['connection'] as String?,
            lastTime: dataDocChat['last_time'] as String?,
            totalUnread: dataDocChat['total_unread'] as int?,
          ),
        );
      }
      return dataListChat;
    } else {
      return <ChatUser>[];
    }
  }

  @override
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> totalUnreadChat() async {
    return _firestore
        .collection('users')
        .doc(user!.uid)
        .collection('chats')
        .snapshots();
  }

  @override
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> userChats() async {
    return _firestore
        .collection('users')
        .doc(user!.uid)
        .collection('chats')
        .orderBy('last_time', descending: true)
        .snapshots();
  }

  @override
  Future<Stream<DocumentSnapshot<Map<String, dynamic>>>> directChat(
      String targetId) async {
    return _firestore.collection('users').doc(targetId).snapshots();
  }

  @override
  Future<void> updateChatStatus(String chatId, String targetUid) async {
    final CollectionReference<Map<String, dynamic>> chats =
        _firestore.collection('chats');
    final CollectionReference<Map<String, dynamic>> users =
        _firestore.collection('users');
    final QuerySnapshot<Map<String, dynamic>> updateStatusChat = await chats
        .doc(chatId)
        .collection('chat')
        .where('isRead', isEqualTo: false)
        .where('penerima', isEqualTo: targetUid)
        .get();
    updateStatusChat.docs
        // ignore: avoid_function_literals_in_foreach_calls
        .forEach((QueryDocumentSnapshot<Map<String, dynamic>> element) async {
      await chats
          .doc(chatId)
          .collection('chat')
          .doc(element.id)
          .update(<String, dynamic>{
        'isRead': true,
      });
      await users
          .doc(targetUid)
          .collection('chats')
          .doc(chatId)
          .update(<Object, Object?>{
        'total_unread': 0,
      });
    });
  }

  @override
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> chatMessages(
      String chatId) async {
    final CollectionReference<Map<String, dynamic>> chats =
        _firestore.collection('chats');
    return chats.doc(chatId).collection('chat').orderBy('time').snapshots();
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getAttention() async {
    final DocumentSnapshot<Map<String, dynamic>> data =
        await _firestore.collection('data').doc('text').get();
    return data;
  }
}
