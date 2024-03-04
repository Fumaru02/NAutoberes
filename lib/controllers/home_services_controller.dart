import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/list_mechanics/list_mechanics_model.dart';
import '../models/users/users_model.dart';
import '../views/chat/chat_room_view.dart';

class HomeServicesController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getMechanics();
  }

  RxBool flagNewConnection = RxBool(false);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxString userImage = RxString('');
  RxString userAlias = RxString('');
  RxString userName = RxString('');
  RxString userRating = RxString('');
  RxString userLevel = RxString('');
  RxString mechanicEmail = RxString('');
  RxString mechanicId = RxString('');
  RxList<ListMechanicsModel> listMechanicsModel =
      RxList<ListMechanicsModel>(<ListMechanicsModel>[]);
  final User? user = FirebaseAuth.instance.currentUser;
  Rx<UsersModel> usersModel = UsersModel().obs;

  Future<void> addConncectionChat(
      String mechanicUid, String receiverImage) async {
    dynamic chatId;

    bool flagNewConnection = false;
    final String date = DateTime.now().toIso8601String();
    final CollectionReference<Map<String, dynamic>> chats =
        _firestore.collection('chats');
    final CollectionReference<Map<String, dynamic>> users =
        _firestore.collection('users');

    final DocumentSnapshot<Map<String, dynamic>> docUser =
        await users.doc(user!.uid).get();
    final List<dynamic> docChats = (docUser.data()!)['chats'] as List<dynamic>;

    // ignore: prefer_is_empty
    if (docChats.length != 0) {
      // user sudah pernah chat

      for (final dynamic singleChat in docChats) {
        if (singleChat['connection'] == mechanicId.value) {
          chatId = singleChat['chat_id'];
        }
      }
      if (chatId != null) {
        // sudah pernah buat koneksi dengan receiver
        flagNewConnection = false;
      } else {
        flagNewConnection = true;

        //belum pernah buat koneksi
        //buat koneksi
      }
    } else {
      flagNewConnection = true;

      //belum pernah chat dengan seseorang
      //buat connection
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

        users.doc(user!.uid).update(<Object, Object?>{
          'chats': <Map<String, dynamic>>[
            <String, dynamic>{
              'connection': mechanicUid,
              'chat_id': chatDataId,
              'last_time': chatsData['last_time'],
            }
          ]
        });
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
      } else {
        //tidak dapat data chats
        //create new
        final DocumentReference<Map<String, dynamic>> newChatDoc =
            await chats.add(<String, dynamic>{
          'connections': <String>[
            user!.uid,
            mechanicUid,
          ],
          'total_chats': 0,
          'total_read': 0,
          'total_unread': 0,
          'chat': <dynamic>[],
          'last_time': date
        });

        users.doc(user!.uid).update(<Object, Object?>{
          'chats': <Map<String, dynamic>>[
            <String, dynamic>{
              'connection': mechanicUid,
              'chat_id': newChatDoc.id,
              'last_time': date,
            }
          ]
        });
        usersModel.update((UsersModel? user) {
          user!.chats = <ChatUser>[
            ChatUser(
              chatId: newChatDoc.id,
              connection: mechanicUid,
              lastTime: date,
            )
          ];
        });

        chatId = newChatDoc.id;

        usersModel.refresh();
      }
    }
    log(chatId.toString());

    Get.to(
        ChatRoomView(
          receiverName: mechanicUid,
          receiverPic: receiverImage,
        ),
        arguments: chatId);
  }

  Future<void> onRefreshPage() async {
    getMechanics();
  }

  Future<void> getMechanics() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> collectionSnapshot =
          await _firestore.collection('mechanic').get();
      listMechanicsModel.value = collectionSnapshot.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
              ListMechanicsModel.fromJson(doc.data()))
          .toList();
      update();
    } catch (e) {
      log(e.toString());
    }
  }
}
