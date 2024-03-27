import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/repositories/chat/chat_interface.dart';
import '../../../domain/repositories/chat/chat_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatState.initial()) {
    on<ChatEvent>(_totalUnReadChat);
  }
  final IChatRepository _chatRepository = ChatRepository();
  Future<void> _totalUnReadChat(
      ChatEvent event, Emitter<ChatState> emit) async {
    final Stream<QuerySnapshot<Map<String, dynamic>>> unReadChat =
        await _chatRepository.totalUnreadChat();
    unReadChat.map((QuerySnapshot<Map<String, dynamic>> snapshot) {
      final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
          snapshot.docs;
      final List<int> totalUnreadList = <int>[];
      for (final QueryDocumentSnapshot<Map<String, dynamic>> document
          in documents) {
        final int totalUnread = document['total_unread'] as int;
        totalUnreadList.add(totalUnread);
      }
      final int unReadNotif = totalUnreadList.fold(
          0, (int previousValue, int element) => previousValue + element);
      emit(state.copyWith(totalUnread: unReadNotif));
    });
  }
}
