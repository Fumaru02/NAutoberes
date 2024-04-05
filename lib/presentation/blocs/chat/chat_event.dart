part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => <Object>[];
}

class TotalUnreadChat extends ChatEvent {}

class UserChats extends ChatEvent {}

class GetAttention extends ChatEvent {
  const GetAttention({
    required this.isHideAttention,
  });
  final bool isHideAttention;
}

class GetMessage extends ChatEvent {
  const GetMessage({
    required this.messages,
  });
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> messages;
}

class ChatMessages extends ChatEvent {
  const ChatMessages({
    required this.chatId,
  });
  final String chatId;
}

class BacktoChatView extends ChatEvent {
  const BacktoChatView({
    required this.chatId,
    required this.targetUid,
  });
  final String chatId;
  final String targetUid;
}

class GotoRoomChat extends ChatEvent {
  const GotoRoomChat({
    required this.chatId,
    required this.userUidChat,
    required this.targetUid,
    required this.targetConnection,
    required this.targetName,
    required this.targetPicture,
  });
  final String chatId;
  final String userUidChat;
  final String targetUid;
  final String targetConnection;
  final String targetName;
  final String targetPicture;
}

class ChatUpdated extends ChatEvent {
  const ChatUpdated({
    required this.chats,
  });
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> chats;
}

class TargetInfo extends ChatEvent {
  const TargetInfo({
    required this.targetInfo,
  });
  final Map<String, dynamic> targetInfo;
}

class DirectMessage extends ChatEvent {
  const DirectMessage({
    required this.targetId,
  });
  final String targetId;
}
