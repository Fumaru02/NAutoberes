import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/brands_car/brands_car_model.dart';
import '../models/list_mechanics/list_mechanics_model.dart';
import '../models/users/users_model.dart';
import '../views/chat/chat_room_view.dart';

class HomeServicesController extends GetxController
    with GetTickerProviderStateMixin {
  @override
  void onInit() {
    super.onInit();
    getMechanics();
    getBrands();
  }

  late TabController tabController = TabController(length: 2, vsync: this);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxBool flagNewConnection = RxBool(false);
  RxBool isLoading = RxBool(false);
  RxString userImage = RxString('');
  RxString userAlias = RxString('');
  RxString userName = RxString('');
  RxString userRating = RxString('');
  RxString userLevel = RxString('');
  RxString mechanicEmail = RxString('');
  RxString mechanicId = RxString('');
  RxList<BrandsCarModel> brandsCarList =
      RxList<BrandsCarModel>(<BrandsCarModel>[]);
  RxList<ListMechanicsModel> listMechanicsModel =
      RxList<ListMechanicsModel>(<ListMechanicsModel>[]);
  Rx<UsersModel> usersModel = UsersModel().obs;
  final User? user = FirebaseAuth.instance.currentUser;

  Future<void> getBrands() async {
    isLoading.value = true;
    try {
      await _firestore
          .collection('data')
          .doc('brands')
          .get()
          .then((DocumentSnapshot<dynamic> documentSnapshot) {
        final Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        final List<dynamic> carBrands = data['brands_car'] as List<dynamic>;
        brandsCarList.value = carBrands
            .map((dynamic e) =>
                BrandsCarModel.fromJson(e as Map<String, dynamic>))
            .toList();
        log(data.toString());
      });
      update();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }

  Future<void> addConncectionChat(
      String mechanicName, String mechanicUid, String receiverImage) async {
    isLoading.value = true;
    dynamic chatId;
    bool flagNewConnection = false;
    final String date = DateTime.now().toIso8601String();
    final CollectionReference<Map<String, dynamic>> chats =
        _firestore.collection('chats');

    final CollectionReference<Map<String, dynamic>> users =
        _firestore.collection('users');

    final QuerySnapshot<Map<String, dynamic>> docChats =
        await users.doc(user!.uid).collection('chats').get();

    // ignore: prefer_is_empty
    if (docChats.docs.length != 0) {
      // user sudah pernah chat
      final QuerySnapshot<Map<String, dynamic>> checkConnection = await users
          .doc(user!.uid)
          .collection('chats')
          .where('connection', isEqualTo: mechanicId.value)
          .get();

      // ignore: prefer_is_empty
      if (checkConnection.docs.length != 0) {
        // sudah pernah buat koneksi dengan receiver
        flagNewConnection = false;
        //chat_id from chats collection
        chatId = checkConnection.docs[0].id;
        isLoading.value = false;
      } else {
        flagNewConnection = true;

        //belum pernah buat koneksi
        //buat koneksi
        isLoading.value = false;
      }
    } else {
      flagNewConnection = true;
      isLoading.value = false;
      //belum pernah buat koneksi
      //buat koneksi
    }
    if (flagNewConnection == true) {
      //check dari chats collection apakah ada document yang koneksi antar ke 2 user
      //1. jika ada ....
      final QuerySnapshot<Map<String, dynamic>> chatDocs = await chats.where(
        'connections',
        whereIn: <Object?>[
          <String>[
            user!.uid,
            mechanicId.value,
          ],
          <String>[
            mechanicId.value,
            user!.uid,
          ],
        ],
      ).get();
      // ignore: prefer_is_empty
      if (chatDocs.docs.length != 0) {
        //terdapat data chats
        //do not replace data if there is new chat

        final String chatDataId = chatDocs.docs[0].id;
        final Map<String, dynamic> chatsData = chatDocs.docs[0].data();

        await users
            .doc(user!.uid)
            .collection('chats')
            .doc(chatDataId)
            .set(<String, dynamic>{
          'connection': mechanicUid,
          'last_time': chatsData['last_time'],
          'total_unread': 0,
        });

        await users.doc(user!.uid).update(
          <Object, Object?>{
            'chats': docChats,
          },
        );

        final QuerySnapshot<Map<String, dynamic>> listChats =
            await users.doc(user!.uid).collection('chats').get();

        // ignore: prefer_is_empty
        if (listChats.docs.length != 0) {
          final List<ChatUser> dataListChat = List<ChatUser>.empty();
          // ignore: avoid_function_literals_in_foreach_calls
          listChats.docs.forEach(
            (QueryDocumentSnapshot<Map<String, dynamic>> element) {
              final Map<String, dynamic> dataDocChat = element.data();
              final String dataDocChatId = element.id;
              dataListChat.add(ChatUser(
                  chatId: dataDocChatId,
                  connection: dataDocChat['connection'] as String?,
                  lastTime: dataDocChat['last_time'] as String?,
                  totalUnread: dataDocChat['total_unread'] as int?));
            },
          );
          usersModel.update((UsersModel? user) {
            user!.chats = dataListChat;
          });
          isLoading.value = false;
        } else {
          usersModel.update((UsersModel? user) {
            user!.chats = <ChatUser>[];
          });
        }
        usersModel.update((UsersModel? user) {
          user!.chats = <ChatUser>[
            ChatUser(
              chatId: chatDataId,
              connection: mechanicUid,
              lastTime: date,
            )
          ];
        });

        chatId = chatDataId;

        usersModel.refresh();
        isLoading.value = false;
      } else {
        //tidak dapat data chats
        //create new
        final DocumentReference<Map<String, dynamic>> newChatDoc =
            await chats.add(<String, dynamic>{
          'connections': <String>[
            user!.uid,
            mechanicUid,
          ],
        });

        chats.doc(newChatDoc.id).collection('chat');

        await users
            .doc(user!.uid)
            .collection('chats')
            .doc(newChatDoc.id)
            .set(<String, dynamic>{
          'connection': mechanicUid,
          'last_time': date,
          'total_unread': 0,
        });

        final QuerySnapshot<Map<String, dynamic>> listChats =
            await users.doc(user!.uid).collection('chats').get();

        // ignore: prefer_is_empty
        if (listChats.docs.length != 0) {
          // ignore: always_specify_types
          final List<ChatUser> dataListChat =
              List<ChatUser>.empty(growable: true);
          // ignore: avoid_function_literals_in_foreach_calls
          listChats.docs.forEach(
            (QueryDocumentSnapshot<Map<String, dynamic>> element) {
              final Map<String, dynamic> dataDocChat = element.data();
              final String dataDocChatId = element.id;
              dataListChat.add(ChatUser(
                  chatId: dataDocChatId,
                  connection: dataDocChat['connection'] as String?,
                  lastTime: dataDocChat['last_time'] as String?,
                  totalUnread: dataDocChat['total_unread'] as int?));
            },
          );
          usersModel.update((UsersModel? user) {
            user!.chats = dataListChat;
          });
          isLoading.value = false;
        } else {
          usersModel.update((UsersModel? user) {
            user!.chats = <ChatUser>[];
          });
        }

        chatId = newChatDoc.id;

        usersModel.refresh();
      }
    }
    final QuerySnapshot<Map<String, dynamic>> updateStatusChat = await chats
        .doc(chatId as String)
        .collection('chat')
        .where('isRead', isEqualTo: false)
        .where('penerima', isEqualTo: mechanicUid)
        .get();

    updateStatusChat.docs
        // ignore: avoid_function_literals_in_foreach_calls
        .forEach((QueryDocumentSnapshot<Map<String, dynamic>> element) async {
      element.id;

      await chats
          .doc(chatId as String)
          .collection('chat')
          .doc(element.id)
          .update(<Object, Object?>{
        'isRead': true,
      });
    });

    await users
        .doc(user!.uid)
        .collection('chats')
        .doc(chatId)
        .update(<Object, Object?>{
      'total_unread': 0,
    });
    isLoading.value = false;
    Get.to(
      ChatRoomView(
        mechanicUid: mechanicId.value,
        userUid: mechanicId.value,
        receiverName: mechanicName,
        receiverPic: receiverImage,
        chatId: chatId,
      ),
      arguments: <String, dynamic>{
        'chat_id': chatId,
        'mechanicUid': mechanicUid
      },
    );
  }

  Future<void> onRefreshPage() async {
    getMechanics();
  }

  Future<void> getMechanics() async {
    isLoading.value = true;

    try {
      final QuerySnapshot<Map<String, dynamic>> collectionSnapshot =
          await _firestore.collection('mechanic').get();
      listMechanicsModel.value = collectionSnapshot.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
              ListMechanicsModel.fromJson(doc.data()))
          .toList();
      update();
      isLoading.value = false;
    } catch (e) {
      log(e.toString());
      isLoading.value = false;
    }
  }
}
