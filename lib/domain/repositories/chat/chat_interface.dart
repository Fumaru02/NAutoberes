import '../../models/users_model.dart';

abstract class IChatRepository {
  Future<List<ChatUser>> onCheckCollectionChat();
}
