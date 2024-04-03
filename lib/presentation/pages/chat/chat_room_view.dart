import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../controllers/chat_controller.dart';
import '../../../controllers/home_services_controller.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/size_config.dart';
import '../../widgets/custom/custom_background_apps.dart';
import '../../widgets/text/inter_text_view.dart';
import 'widgets/keyboard_widget.dart';

class ChatRoomView extends StatelessWidget {
  const ChatRoomView({
    super.key,
    required this.targetName,
    required this.targetPic,
    required this.userUid,
    required this.chatId,
    required this.targetUid,
  });
  final String targetName;
  final String targetPic;
  final String userUid;
  final String chatId;
  final String targetUid;
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
                                onPressed: () {
                                  chatController.onBackReadChat(
                                      chatId, targetUid);
                                  Get.back();
                                },
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
                                imageUrl: targetPic,
                                memCacheWidth: 100,
                                memCacheHeight: 100,
                              ),
                            ),
                          )),
                        ],
                      ),
                      backgroundColor: AppColors.blackBackground,
                      title: InterTextView(value: targetName)),
                  body: CustomBackgroundApp(
                    child: ResponsiveRowColumn(
                      layout: ResponsiveRowColumnType.COLUMN,
                      children: <ResponsiveRowColumnItem>[
                        // ResponsiveRowColumnItem(
                        //     child: ChatBubbleWidget(
                        //   chatController: chatController,
                        //   chatId: chatId,
                        //   homeServicesController: homeServicesController,
                        // )),
                        ResponsiveRowColumnItem(
                            child: KeyboardWidget(
                          chatController: chatController,
                          homeServicesController: homeServicesController,
                          userUid: userUid,
                        )),
                      ],
                    ),
                  ),
                )));
  }
}
