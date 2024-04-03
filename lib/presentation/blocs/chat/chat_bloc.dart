import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../../core/routes/app_routes.dart';
import '../../../domain/repositories/chat/chat_interface.dart';
import '../../../domain/repositories/chat/chat_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatState.initial()) {
    on<ChatEvent>(_totalUnReadChat);
    on<UserChats>(_listChat);
    on<DirectMessage>(_directMessage);
    on<ChatUpdated>(_onUpdatedChat);
    on<TargetInfo>(_onGetTargetInfo);
    on<GotoRoomChat>(_onGotoChatRoom);
  }
  final IChatRepository _chatRepository = ChatRepository();
  StreamSubscription<dynamic>? _chatSubscription;

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

  Future<void> _listChat(UserChats event, Emitter<ChatState> emit) async {
    try {
      final Stream<QuerySnapshot<Map<String, dynamic>>> userListChat =
          await _chatRepository.userChats();
      // Membatalkan subscription sebelumnya (jika ada)
      await _chatSubscription?.cancel();

      // Membuat subscription baru
      _chatSubscription = userListChat.listen(
        (QuerySnapshot<Map<String, dynamic>> querySnapshot) {
          final List<Map<String, dynamic>> chats = querySnapshot.docs
              .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
                  doc.data())
              .toList();
          add(ChatUpdated(chats: chats));
          // Memastikan event handler belum selesai sebelum memanggil emit
        },
      );
    } catch (e) {
      log(e.toString());
      // Memastikan event handler belum selesai sebelum memanggil emit
      await _chatSubscription?.cancel();
    }
  }

  Future<void> _directMessage(
      DirectMessage event, Emitter<ChatState> emit) async {
    emit(state.copyWith(chatStatus: ListChatsStatus.loading));

    try {
      final Stream<DocumentSnapshot<Map<String, dynamic>>> targetDoc =
          await _chatRepository.directChat(event.targetId);
      // Membatalkan subscription sebelumnya (jika ada)
      await _chatSubscription?.cancel();

      // Membuat subscription baru
      _chatSubscription = targetDoc.listen(
        (DocumentSnapshot<Map<String, dynamic>> querySnapshot) {
          final Map<String, dynamic>? targetInfo = querySnapshot.data();
          // Memastikan event handler belum selesai sebelum memanggil emit
          add(TargetInfo(targetInfo: targetInfo!));
        },
      );
      emit(state.copyWith(chatStatus: ListChatsStatus.loaded));
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> close() {
    _chatSubscription?.cancel();
    return super.close();
  }

  void _onUpdatedChat(ChatUpdated event, Emitter<ChatState> emit) {
    emit(state.copyWith(chats: event.chats));
  }

  void _onGetTargetInfo(TargetInfo event, Emitter<ChatState> emit) {
    emit(state.copyWith(
        targetImage: event.targetInfo['home_service_image'] as String,
        username: event.targetInfo['username'] as String,
        targetUid: event.targetInfo['user_uid'] as String,
        targetName:
            event.targetInfo['home_service']['home_service_name'] as String));
  }

  Future<void> _onGotoChatRoom(
      GotoRoomChat event, Emitter<ChatState> emit) async {
    await _chatRepository.updateChatStatus(event.chatId, event.targetUid);
    router.go('/chatroom', extra: <String, dynamic>{
      'targetName': event.targetName,
      'chatId': event.chatId,
      'targetPic': event.targetPicture,
      'targetUid': event.targetUid,
      'userUid': event.targetUid,
    });
  }
}
