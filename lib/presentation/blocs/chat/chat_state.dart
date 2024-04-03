part of 'chat_bloc.dart';

enum ListChatsStatus { initial, loading, loaded, failed }

class ChatState extends Equatable {
  const ChatState({
    required this.totalUnread,
    required this.chats,
    required this.chatStatus,
    required this.targetImage,
    required this.targetUid,
    required this.targetName,
    required this.username,
  });

  factory ChatState.initial() => const ChatState(
      targetName: '',
      targetImage: '',
      username: '',
      targetUid: '',
      totalUnread: 0,
      chats: <dynamic>[],
      chatStatus: ListChatsStatus.initial);
  final int totalUnread;
  final List<dynamic> chats;
  final ListChatsStatus chatStatus;
  final String targetImage;
  final String targetUid;
  final String targetName;
  final String username;

  @override
  List<Object> get props {
    return <Object>[
      totalUnread,
      chats,
      chatStatus,
      targetImage,
      targetUid,
      targetName,
      username,
    ];
  }

  @override
  String toString() {
    return 'ChatState(totalUnread: $totalUnread, chats: $chats, chatStatus: $chatStatus, targetImage: $targetImage, targetUid: $targetUid, targetName: $targetName, username: $username)';
  }

  ChatState copyWith({
    int? totalUnread,
    List<dynamic>? chats,
    ListChatsStatus? chatStatus,
    String? targetImage,
    String? targetUid,
    String? targetName,
    String? username,
  }) {
    return ChatState(
      totalUnread: totalUnread ?? this.totalUnread,
      chats: chats ?? this.chats,
      chatStatus: chatStatus ?? this.chatStatus,
      targetImage: targetImage ?? this.targetImage,
      targetUid: targetUid ?? this.targetUid,
      targetName: targetName ?? this.targetName,
      username: username ?? this.username,
    );
  }
}
