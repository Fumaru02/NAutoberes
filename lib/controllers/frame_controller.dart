import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/utils/on_tap_identifier.dart';
import '../presentation/pages/akun/akun_view.dart';
import '../presentation/pages/chat/chat_view.dart';
import '../presentation/pages/home/home_view.dart';
import '../presentation/pages/home_services/home_services_view.dart';
import '../presentation/pages/workshop/workshop_view.dart';

class FrameController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxInt defaultIndex = RxInt(0);
  RxInt unReadNotif = RxInt(0);

  final User? user = FirebaseAuth.instance.currentUser;
  RxList<OnTapIdentifier> onTapIdentifierList =
      RxList<OnTapIdentifier>(<OnTapIdentifier>[
    OnTapIdentifier(name: 'Home', index: 0, isOnTapped: true),
    OnTapIdentifier(name: 'Chat', index: 1, isOnTapped: false),
    OnTapIdentifier(name: 'Services', index: 2, isOnTapped: false),
    OnTapIdentifier(name: 'Workshop', index: 3, isOnTapped: false),
    OnTapIdentifier(name: 'Akun', index: 4, isOnTapped: false),
  ]);

  Stream<QuerySnapshot<Map<String, dynamic>>> totalUnreadChat() {
    return _firestore
        .collection('users')
        .doc(user!.uid)
        .collection('chats')
        .snapshots();
  }

  List<Widget> widgetViewList = <Widget>[
    const HomeView(),
    const ChatView(),
    const HomeServicesView(),
    const WorkshopView(),
    const AkunView(),
  ];

  void onTapNav(int index) {
    defaultIndex.value = index;

    for (final OnTapIdentifier element in onTapIdentifierList) {
      if (element.index == index) {
        onTapIdentifierList[index].isOnTapped = true;
      } else {
        onTapIdentifierList[element.index].isOnTapped = false;
      }
    }
  }
}
