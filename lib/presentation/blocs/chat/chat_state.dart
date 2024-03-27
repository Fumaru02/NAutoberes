part of 'chat_bloc.dart';

class ChatState extends Equatable {
  const ChatState({
    required this.totalUnread,
  });

  factory ChatState.initial() => const ChatState(totalUnread: 0);
  final int totalUnread;

  @override
  List<Object> get props => <Object>[totalUnread];

  @override
  String toString() => 'ChatState(totalUnread: $totalUnread)';

  ChatState copyWith({
    int? totalUnread,
  }) {
    return ChatState(
      totalUnread: totalUnread ?? this.totalUnread,
    );
  }
}
