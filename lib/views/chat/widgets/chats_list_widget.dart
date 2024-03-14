import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../controllers/chat_controller.dart';
import '../../../controllers/home_services_controller.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/size_config.dart';
import '../../widgets/text/inter_text_view.dart';

class ChatsListWidget extends StatelessWidget {
  const ChatsListWidget({
    super.key,
    required this.listDocsChats,
    required this.homeServicesController,
    required this.chatController,
  });

  final List<QueryDocumentSnapshot<Map<String, dynamic>>> listDocsChats;
  final HomeServicesController homeServicesController;
  final ChatController chatController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listDocsChats.length,
        itemBuilder: (_, int index) {
          return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: chatController
                .mechanicsChat(listDocsChats[index]['connection'] as String),
            builder: (_, AsyncSnapshot<dynamic> snapshot2) {
              if (snapshot2.connectionState == ConnectionState.active) {
          
                final dynamic mechanicsData = snapshot2.data!.data();
                return ListTile(
                  onTap: () {
                    chatController.goToChatRoom(
                        mechanicsData['user_uid'] as String,
                        listDocsChats[index].id,
                        homeServicesController.user!.uid,
                        listDocsChats[index]['connection'] as String,
                        mechanicsData['username'] as String,
                        mechanicsData['user_image'] as String);
                  },
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.blackBackground,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                          Radius.circular(SizeConfig.horizontal(20))),
                      child: CachedNetworkImage(
                          imageUrl: mechanicsData['user_image'] as String),
                    ),
                  ),
                  title: InterTextView(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                      size: SizeConfig.safeBlockHorizontal * 4.5,
                      value: '${mechanicsData['username']}'),
                  subtitle: InterTextView(
                    value: '${mechanicsData['username']}',
                    color: AppColors.grey,
                  ),
                  trailing: listDocsChats[index]['total_unread'] == 0
                      ? const SizedBox.shrink()
                      : Chip(
                          backgroundColor: AppColors.redAlert,
                          label: InterTextView(
                            value: '${listDocsChats[index]['total_unread']}',
                            fontWeight: FontWeight.bold,
                          )),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          );
        });
  }
}
