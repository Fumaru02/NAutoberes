import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../controllers/chat_controller.dart';
import '../../../controllers/home_services_controller.dart';
import 'widgets/chats_list_widget.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeServicesController homeServicesController =
        Get.put(HomeServicesController());
    return GetBuilder<ChatController>(
        init: ChatController(),
        builder: (ChatController chatController) => ResponsiveRowColumn(
              layout: ResponsiveRowColumnType.COLUMN,
              children: <ResponsiveRowColumnItem>[
                ResponsiveRowColumnItem(
                    child: Expanded(
                        child:
                            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                stream: chatController.chatsStream(
                                    homeServicesController.user!.uid),
                                builder: (_,
                                    AsyncSnapshot<
                                            QuerySnapshot<Map<String, dynamic>>>
                                        snapshot1) {
                                  if (snapshot1.hasData) {
                                    final List<
                                            QueryDocumentSnapshot<
                                                Map<String, dynamic>>>
                                        listDocsChats = snapshot1.data!.docs;
                                    if (snapshot1.connectionState ==
                                            ConnectionState.active ||
                                        listDocsChats != null) {
                                      return ChatsListWidget(
                                          chatController: chatController,
                                          listDocsChats: listDocsChats,
                                          homeServicesController:
                                              homeServicesController);
                                    }
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (snapshot1.hasError) {
                                    log(snapshot1.toString());
                                    return const CircularProgressIndicator();
                                  } else {
                                    log('loading');
                                    return const CircularProgressIndicator();
                                  }
                                })))
              ],
            ));
  }
}
