import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_row_column.dart';

import '../../controllers/chat_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/size_config.dart';
import '../widgets/text/inter_text_view.dart';

class ChatRoomView extends StatelessWidget {
  const ChatRoomView({
    super.key,
    required this.receiverName,
    required this.receiverPic,
  });
  final String receiverName;
  final String receiverPic;

  @override
  Widget build(BuildContext context) {
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
                                  Radius.circular(SizeConfig.horizontal(4))),
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
                          child: Obx(() => chatController
                                  .myMessage.value.isNotEmpty
                              ? ResponsiveRowColumn(
                                  layout: ResponsiveRowColumnType.COLUMN,
                                  columnPadding: EdgeInsets.symmetric(
                                      horizontal: SizeConfig.horizontal(1)),
                                  columnCrossAxisAlignment:
                                      CrossAxisAlignment.end,
                                  children: <ResponsiveRowColumnItem>[
                                    ResponsiveRowColumnItem(
                                        child: Container(
                                            margin: EdgeInsets.only(
                                                right:
                                                    SizeConfig.horizontal(12),
                                                top: SizeConfig.horizontal(3)),
                                            padding: EdgeInsets.all(
                                                SizeConfig.horizontal(2)),
                                            width: SizeConfig.horizontal(60),
                                            decoration: BoxDecoration(
                                                boxShadow: <BoxShadow>[
                                                  BoxShadow(
                                                      blurRadius: 4,
                                                      spreadRadius: 2,
                                                      offset:
                                                          const Offset(-1, 3),
                                                      color: AppColors
                                                          .greyDisabled)
                                                ],
                                                color: AppColors.white,
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(
                                                        SizeConfig.horizontal(
                                                            2)),
                                                    topRight: Radius.circular(
                                                        SizeConfig.horizontal(
                                                            2)),
                                                    bottomLeft:
                                                        Radius.circular(SizeConfig.horizontal(2)))),
                                            child: InterTextView(value: chatController.myMessage.value, size: SizeConfig.safeBlockHorizontal * 4, color: AppColors.black))),
                                    const ResponsiveRowColumnItem(
                                        child: ResponsiveRowColumn(
                                      layout: ResponsiveRowColumnType.ROW,
                                      children: <ResponsiveRowColumnItem>[
                                        ResponsiveRowColumnItem(
                                            child: Spacer()),
                                        ResponsiveRowColumnItem(
                                            child: CircleAvatar(minRadius: 25)),
                                      ],
                                    ))
                                  ],
                                )
                              : const SizedBox.shrink())),
                      const ResponsiveRowColumnItem(child: Spacer()),
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
                              height: SizeConfig.horizontal(12),
                              child: ResponsiveRowColumn(
                                layout: ResponsiveRowColumnType.ROW,
                                children: <ResponsiveRowColumnItem>[
                                  ResponsiveRowColumnItem(
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: AppColors.white),
                                          width: SizeConfig.horizontal(88),
                                          child: SizedBox(
                                              child: TextFormField(
                                            onFieldSubmitted: (String value) {
                                              chatController.myMessage.value =
                                                  value;
                                              chatController
                                                  .chatEditingController
                                                  .clear();
                                            },
                                            textInputAction:
                                                TextInputAction.send,
                                            decoration: InputDecoration(
                                                suffixIcon: const Icon(Icons
                                                    .control_point_outlined),
                                                hintText: 'Enter Message...',
                                                contentPadding: EdgeInsets.only(
                                                    top: SizeConfig.horizontal(
                                                        2),
                                                    left: SizeConfig.horizontal(
                                                        4))),
                                            controller: chatController
                                                .chatEditingController,
                                          )))),
                                  ResponsiveRowColumnItem(
                                      child: Container(
                                    color: AppColors.redAlert,
                                    width: SizeConfig.horizontal(12),
                                    height: SizeConfig.horizontal(12),
                                    child: Icon(Icons.mic,
                                        size: SizeConfig.horizontal(8)),
                                  ))
                                ],
                              ))),
                    ],
                  ),
                )));
  }
}
