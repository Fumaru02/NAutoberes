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
}
