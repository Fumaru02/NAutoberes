import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../controllers/chat_controller.dart';
import '../../../controllers/home_services_controller.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/size_config.dart';
import '../../widgets/custom/custom_text_field.dart';

class KeyboardWidget extends StatelessWidget {
  const KeyboardWidget({
    super.key,
    required this.homeServicesController,
    required this.userUid,
    required this.chatController,
  });

  final HomeServicesController homeServicesController;
  final String userUid;
  final ChatController chatController;
  @override
  Widget build(BuildContext context) {
    return Container(
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
        height: SizeConfig.horizontal(17),
        child: ResponsiveRowColumn(
          layout: ResponsiveRowColumnType.ROW,
          rowMainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <ResponsiveRowColumnItem>[
            ResponsiveRowColumnItem(
                child: CustomTextField(
              textInputAction: TextInputAction.newline,
              maxLines: 20,
              title: '',
              hintText: 'Enter Message...',
              focusNode: chatController.myFocusNode,
              keyboardType: TextInputType.multiline,
              controller: chatController.chatEditingController,
              onFieldSubmitted: (String value) {
                chatController.myMessage.value = value;
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
                        Get.arguments as Map<String, dynamic>,
                        chatController.chatEditingController.text,
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
        ));
  }
}
