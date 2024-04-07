part of 'chat_bloc.dart';

enum ListChatsStatus { initial, loading, loaded, failed }

class ChatState extends Equatable {
  const ChatState({
    required this.totalUnread,
    required this.chats,
    required this.messages,
    required this.chatStatus,
    required this.targetImage,
    required this.targetUid,
    required this.targetName,
    required this.username,
    required this.warningChat,
    required this.isHideAttention,
  });

  factory ChatState.initial() => const ChatState(
      isHideAttention: false,
      targetName: '',
      targetImage: '',
      warningChat: '',
      username: '',
      targetUid: '',
      totalUnread: 0,
      chats: <QueryDocumentSnapshot<Map<String, dynamic>>>[],
      messages: <QueryDocumentSnapshot<Map<String, dynamic>>>[],
      chatStatus: ListChatsStatus.initial);
  final int totalUnread;
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> chats;
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> messages;
  final ListChatsStatus chatStatus;
  final String targetImage;
  final String targetUid;
  final String targetName;
  final String username;
  final String warningChat;
  final bool isHideAttention;

  @override
  List<Object> get props {
    return <Object>[
      totalUnread,
      chats,
      messages,
      chatStatus,
      targetImage,
      targetUid,
      targetName,
      username,
      warningChat,
      isHideAttention,
    ];
  }

  @override
  String toString() {
    return 'ChatState(totalUnread: $totalUnread, chats: $chats, messages: $messages, chatStatus: $chatStatus, targetImage: $targetImage, targetUid: $targetUid, targetName: $targetName, username: $username, warningChat: $warningChat, isHideAttention: $isHideAttention)';
  }

  ChatState copyWith({
    int? totalUnread,
    List<QueryDocumentSnapshot<Map<String, dynamic>>>? chats,
    List<QueryDocumentSnapshot<Map<String, dynamic>>>? messages,
    ListChatsStatus? chatStatus,
    String? targetImage,
    String? targetUid,
    String? targetName,
    String? username,
    String? warningChat,
    bool? isHideAttention,
  }) {
    return ChatState(
      totalUnread: totalUnread ?? this.totalUnread,
      chats: chats ?? this.chats,
      messages: messages ?? this.messages,
      chatStatus: chatStatus ?? this.chatStatus,
      targetImage: targetImage ?? this.targetImage,
      targetUid: targetUid ?? this.targetUid,
      targetName: targetName ?? this.targetName,
      username: username ?? this.username,
      warningChat: warningChat ?? this.warningChat,
      isHideAttention: isHideAttention ?? this.isHideAttention,
    );
  }
}
