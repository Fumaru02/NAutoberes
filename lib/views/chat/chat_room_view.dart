import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_row_column.dart';

import '../../controllers/chat_controller.dart';
import '../../controllers/home_services_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/size_config.dart';
import '../widgets/custom/custom_text_field.dart';
import '../widgets/layouts/space_sizer.dart';
import '../widgets/text/inter_text_view.dart';

class ChatRoomView extends StatelessWidget {
  const ChatRoomView({
    super.key,
    required this.receiverName,
    required this.receiverPic,
    required this.userUid,
    required this.chatId,
  });
  final String receiverName;
  final String receiverPic;
  final String userUid;
  final String chatId;
  @override
  Widget build(BuildContext context) {
    final HomeServicesController homeServicesController = Get.find();

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: AppColors.blackBackground,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: GetBuilder<ChatController>(
            init: ChatController(),
            builder: (ChatController chatController) => Scaffold(
                  appBar: AppBar(
                      leadingWidth: SizeConfig.horizontal(22),
                      leading: ResponsiveRowColumn(
                        layout: ResponsiveRowColumnType.ROW,
                        children: <ResponsiveRowColumnItem>[
                          ResponsiveRowColumnItem(
                            child: IconButton(
                                onPressed: () => Get.back(),
                                icon: const Icon(Icons.arrow_back),
                                color: AppColors.white),
                          ),
                          ResponsiveRowColumnItem(
                              child: SizedBox(
                            height: SizeConfig.horizontal(10),
                            width: SizeConfig.horizontal(10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(SizeConfig.horizontal(8))),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: receiverPic,
                              ),
                            ),
                          )),
                        ],
                      ),
                      backgroundColor: AppColors.blackBackground,
                      title: InterTextView(value: receiverName)),
                  body: ResponsiveRowColumn(
                    layout: ResponsiveRowColumnType.COLUMN,
                    children: <ResponsiveRowColumnItem>[
                      ResponsiveRowColumnItem(
                          child: StreamBuilder<
                                  QuerySnapshot<Map<String, dynamic>>>(
                              stream: chatController.streamChats(chatId),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                Timer(
                                    Duration.zero,
                                    () => chatController.scrollController
                                        .jumpTo(chatController.scrollController
                                            .position.maxScrollExtent));
                                if (snapshot.connectionState ==
                                    ConnectionState.active) {
                                  final dynamic allData = snapshot.data!.docs;
                                  return Expanded(
                                      child: ListView.builder(
                                          controller:
                                              chatController.scrollController,
                                          itemCount: allData.length as int,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            if (index == 0) {
                                              return ResponsiveRowColumn(
                                                layout: ResponsiveRowColumnType
                                                    .COLUMN,
                                                children: <ResponsiveRowColumnItem>[
                                                  ResponsiveRowColumnItem(
                                                      child: Padding(
                                                    padding: EdgeInsets.all(
                                                        SizeConfig.horizontal(
                                                            2)),
                                                    child: InterTextView(
                                                      value:
                                                          '${allData[index]['group_time']}',
                                                      color: AppColors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      size: SizeConfig
                                                              .safeBlockHorizontal *
                                                          3.5,
                                                    ),
                                                  )),
                                                  ResponsiveRowColumnItem(
                                                      child: ItemChat(
                                                          // ignore: avoid_bool_literals_in_conditional_expressions
                                                          isSender: allData[
                                                                          index]
                                                                      [
                                                                      'pengirim'] ==
                                                                  homeServicesController
                                                                      .user!.uid
                                                              ? true
                                                              : false,
                                                          msg:
                                                              '${allData[index]['msg']}',
                                                          time:
                                                              '${allData[index]['time']}'))
                                                ],
                                              );
                                            } else {
                                              if (allData[index]
                                                      ['group_time'] ==
                                                  allData[index - 1]
                                                      ['group_time']) {
                                                return ItemChat(
                                                    // ignore: avoid_bool_literals_in_conditional_expressions
                                                    isSender: allData[index]
                                                                ['pengirim'] ==
                                                            homeServicesController
                                                                .user!.uid
                                                        ? true
                                                        : false,
                                                    msg:
                                                        '${allData[index]['msg']}',
                                                    time:
                                                        '${allData[index]['time']}');
                                              } else {
                                                return ResponsiveRowColumn(
                                                  layout:
                                                      ResponsiveRowColumnType
                                                          .COLUMN,
                                                  children: <ResponsiveRowColumnItem>[
                                                    ResponsiveRowColumnItem(
                                                        child: Padding(
                                                      padding: EdgeInsets.all(
                                                          SizeConfig.horizontal(
                                                              2)),
                                                      child: InterTextView(
                                                        value:
                                                            '${allData[index]['group_time']}',
                                                        color: AppColors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        size: SizeConfig
                                                                .safeBlockHorizontal *
                                                            3.5,
                                                      ),
                                                    )),
                                                    ResponsiveRowColumnItem(
                                                        child: ItemChat(
                                                            // ignore: avoid_bool_literals_in_conditional_expressions
                                                            isSender: allData[
                                                                            index]
                                                                        [
                                                                        'pengirim'] ==
                                                                    homeServicesController
                                                                        .user!
                                                                        .uid
                                                                ? true
                                                                : false,
                                                            msg:
                                                                '${allData[index]['msg']}',
                                                            time:
                                                                '${allData[index]['time']}'))
                                                  ],
                                                );
                                              }
                                            }
                                          }));
                                }
                                return const Center(
                                    child: CircularProgressIndicator());
                              })),
                      ResponsiveRowColumnItem(
                          child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.blackBackground,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      blurRadius: 4,
                                      spreadRadius: 2,
                                      offset: const Offset(0, 3),
                                      color: AppColors.greyDisabled)
                                ],
                              ),
                              height: SizeConfig.horizontal(15),
                              child: ResponsiveRowColumn(
                                layout: ResponsiveRowColumnType.ROW,
                                rowMainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <ResponsiveRowColumnItem>[
                                  ResponsiveRowColumnItem(
                                      child: CustomTextField(
                                    title: '',
                                    hintText: 'Enter Message...',
                                    controller:
                                        chatController.chatEditingController,
                                    onFieldSubmitted: (String value) {
                                      chatController.myMessage.value = value;
                                      chatController.focusNode.unfocus();
                                    },
                                  )),
                                  ResponsiveRowColumnItem(
                                      child: CircleAvatar(
                                    backgroundColor: AppColors.white,
                                    radius: SizeConfig.horizontal(6),
                                    child: IconButton(
                                        onPressed: () {
                                          chatController.newChat(
                                              homeServicesController.user!.uid,
                                              Get.arguments
                                                  as Map<String, dynamic>,
                                              chatController
                                                  .chatEditingController.text,
                                              userUid);
                                          FocusScope.of(context).unfocus();
                                        },
                                        icon: Icon(
                                          Icons.send,
                                          size: SizeConfig.horizontal(6),
                                          color: AppColors.blackBackground,
                                        )),
                                  ))
                                ],
                              ))),
                    ],
                  ),
                )));
  }
}

class ItemChat extends StatelessWidget {
  const ItemChat({
    super.key,
    required this.isSender,
    required this.msg,
    required this.time,
  });

  final bool isSender;
  final String msg;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: SizeConfig.horizontal(1),
          horizontal: SizeConfig.horizontal(1)),
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                color: AppColors.blackBackground,
                borderRadius: isSender
                    ? BorderRadius.only(
                        topLeft: Radius.circular(SizeConfig.horizontal(3.5)),
                        topRight: Radius.circular(SizeConfig.horizontal(3.5)),
                        bottomLeft: Radius.circular(SizeConfig.horizontal(3.5)),
                      )
                    : BorderRadius.only(
                        topLeft: Radius.circular(SizeConfig.horizontal(3.5)),
                        topRight: Radius.circular(SizeConfig.horizontal(3.5)),
                        bottomRight:
                            Radius.circular(SizeConfig.horizontal(3.5)),
                      ),
              ),
              padding: EdgeInsets.all(SizeConfig.horizontal(3.5)),
              child: InterTextView(
                  value: msg,
                  size: SizeConfig.safeBlockHorizontal * 4,
                  fontWeight: FontWeight.w500)),
          const SpaceSizer(vertical: 0.5),
          InterTextView(
            value: DateFormat.jm().format(DateTime.parse(time)),
            color: AppColors.black,
            size: SizeConfig.safeBlockHorizontal * 3,
          ),
        ],
      ),
    );
  }
}
