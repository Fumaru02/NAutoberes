import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/users_model.dart';

abstract class IChatRepository {
  Future<List<ChatUser>> onCheckCollectionChat();
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> totalUnreadChat();
  Future<DocumentSnapshot<Map<String, dynamic>>> getAttention();
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> chatMessages(
      String chatId);
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> userChats();
  Future<void> updateChatStatus(String chatId, String targetUid);
  Future<Stream<DocumentSnapshot<Map<String, dynamic>>>> directChat(
      String targetId);
}
