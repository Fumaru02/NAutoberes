import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../controllers/chat_controller.dart';
import '../../../controllers/home_services_controller.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/size_config.dart';
import '../../widgets/layouts/space_sizer.dart';
import '../../widgets/text/inter_text_view.dart';
import 'item_chat.dart';

class ChatBubbleWidget extends StatelessWidget {
  const ChatBubbleWidget({
    super.key,
    required this.chatId,
    required this.homeServicesController,
    required this.chatController,
  });

  final String chatId;
  final HomeServicesController homeServicesController;
  final ChatController chatController;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: chatController.streamChats(chatId),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final dynamic allData = snapshot.data!.docs;
            return Expanded(
                child: ListView.builder(
                    controller: chatController.scrollController,
                    itemCount: allData.length as int,
                    itemBuilder: (BuildContext context, int index) {
                      // allData.forEach((dynamic doc) {
                      //   if (doc['isRead'] == false) {
                      //     doc.reference.update(
                      //       <String, bool>{
                      //         'isRead': true,
                      //       },
                      //     );
                      //   }
                      // });

                      if (index == 0) {
                        return ResponsiveRowColumn(
                          layout: ResponsiveRowColumnType.COLUMN,
                          children: <ResponsiveRowColumnItem>[
                            ResponsiveRowColumnItem(
                                child: Padding(
                              padding: EdgeInsets.all(SizeConfig.horizontal(2)),
                              child: InterTextView(
                                value: '${allData[index]['group_time']}',
                                color: AppColors.black,
                                fontWeight: FontWeight.bold,
                                size: SizeConfig.safeBlockHorizontal * 3.5,
                              ),
                            )),
                            ResponsiveRowColumnItem(
                                child: ItemChat(
                                    isRead: allData[index]['isRead'] as bool,

                                    // ignore: avoid_bool_literals_in_conditional_expressions
                                    isSender: allData[index]['pengirim'] ==
                                            homeServicesController.user!.uid
                                        ? true
                                        : false,
                                    msg: '${allData[index]['msg']}',
                                    time: '${allData[index]['time']}'))
                          ],
                        );
                      } else {
                        if (allData[index]['group_time'] ==
                            allData[index - 1]['group_time']) {
                          return ItemChat(
                              isRead: allData[index]['isRead'] as bool,

                              // ignore: avoid_bool_literals_in_conditional_expressions
                              isSender: allData[index]['pengirim'] ==
                                      homeServicesController.user!.uid
                                  ? true
                                  : false,
                              msg: '${allData[index]['msg']}',
                              time: '${allData[index]['time']}');
                        } else {
                          return ResponsiveRowColumn(
                            layout: ResponsiveRowColumnType.COLUMN,
                            children: <ResponsiveRowColumnItem>[
                              ResponsiveRowColumnItem(
                                  child: Padding(
                                padding:
                                    EdgeInsets.all(SizeConfig.horizontal(2)),
                                child: InterTextView(
                                  value: '${allData[index]['group_time']}',
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                  size: SizeConfig.safeBlockHorizontal * 3.5,
                                ),
                              )),
                              ResponsiveRowColumnItem(
                                  child: ItemChat(
                                      isRead: allData[index]['isRead'] as bool,
                                      // ignore: avoid_bool_literals_in_conditional_expressions
                                      isSender: allData[index]['pengirim'] ==
                                              homeServicesController.user!.uid
                                          ? true
                                          : false,
                                      msg: '${allData[index]['msg']}',
                                      time: '${allData[index]['time']}'))
                            ],
                          );
                        }
                      }
                    }));
          }
          return const SpaceSizer(
            vertical: 45,
          );
        });
  }
}
