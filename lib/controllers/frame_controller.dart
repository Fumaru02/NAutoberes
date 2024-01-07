import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/on_tap_identifier.dart';
import '../views/akun/akun_view.dart';
import '../views/chat/chat_view.dart';
import '../views/home/home_view.dart';
import '../views/outlets/outlets_view.dart';
import '../views/services/services_view.dart';

class FrameController extends GetxController {
  RxInt defaultIndex = RxInt(0);

  RxList<OnTapIdentifier> onTapIdentifierList =
      RxList<OnTapIdentifier>(<OnTapIdentifier>[
    OnTapIdentifier(name: 'Home', index: 0, isOnTapped: true),
    OnTapIdentifier(name: 'Chat', index: 1, isOnTapped: false),
    OnTapIdentifier(name: 'Services', index: 2, isOnTapped: false),
    OnTapIdentifier(name: 'Outlets', index: 3, isOnTapped: false),
    OnTapIdentifier(name: 'Akun', index: 4, isOnTapped: false),
  ]);

  List<Widget> widgetViewList = [
    const HomeView(),
    const ChatView(),
    const ServicesView(),
    const OutletsView(),
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
