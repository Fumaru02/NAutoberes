import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_row_column.dart';

import '../../controllers/chat_controller.dart';
import '../../controllers/home_services_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/size_config.dart';
import '../widgets/text/inter_text_view.dart';
import 'chat_room_view.dart';

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
                        child: StreamBuilder<
                                DocumentSnapshot<Map<String, dynamic>>>(
                            stream: chatController
                                .chatsStream(homeServicesController.user!.uid),
                            builder: (_, AsyncSnapshot<dynamic> snapshot1) {
                              if (snapshot1.connectionState ==
                                  ConnectionState.active) {
                                final List<dynamic> myChats = snapshot1.data
                                    .data()['chats'] as List<dynamic>;
                                return ListView.builder(
                                    itemCount: myChats.length,
                                    itemBuilder: (_, int index) {
                                      return StreamBuilder<
                                          DocumentSnapshot<
                                              Map<String, dynamic>>>(
                                        stream: chatController.mechanicsChat(
                                            myChats[index]['connection']
                                                as String),
                                        builder: (_,
                                            AsyncSnapshot<dynamic> snapshot2) {
                                          if (snapshot2.connectionState ==
                                              ConnectionState.active) {
                                            final dynamic mechanicsData =
                                                snapshot2.data!.data();
                                            log(mechanicsData['home_service']
                                                    ['home_service_name']
                                                .toString());
                                            return ListTile(
                                              onTap: () => Get.to(ChatRoomView(
                                                  receiverName: mechanicsData[
                                                              'home_service']
                                                          ['home_service_name']
                                                      as String,
                                                  receiverPic: mechanicsData[
                                                      'user_image'] as String)),
                                              leading: CircleAvatar(
                                                radius: 30,
                                                backgroundColor:
                                                    AppColors.blackBackground,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius
                                                      .all(Radius.circular(
                                                          SizeConfig.horizontal(
                                                              20))),
                                                  child: CachedNetworkImage(
                                                      imageUrl: mechanicsData[
                                                              'user_image']
                                                          as String),
                                                ),
                                              ),
                                              title: InterTextView(
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.bold,
                                                  size: SizeConfig
                                                          .safeBlockHorizontal *
                                                      4.5,
                                                  value:
                                                      '${mechanicsData['home_service']['home_service_name']}'),
                                              subtitle: InterTextView(
                                                value:
                                                    '${mechanicsData['username']}',
                                                color: AppColors.grey,
                                              ),
                                              trailing: myChats[index]
                                                          ['total_unread'] ==
                                                      0
                                                  ? const SizedBox.shrink()
                                                  : const Chip(
                                                      label: InterTextView(
                                                          value: '0')),
                                            );
                                          } else {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }
                                        },
                                      );
                                    });
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            })))
              ],
            ));
  }
}
