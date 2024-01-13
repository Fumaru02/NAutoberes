import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_row_column.dart';

import '../../controllers/chat_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/size_config.dart';
import '../widgets/text/roboto_text_view.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      init: ChatController(),
      builder: (ChatController chatController) => ResponsiveRowColumn(
        layout: ResponsiveRowColumnType.COLUMN,
        children: <ResponsiveRowColumnItem>[
          ResponsiveRowColumnItem(
              child: Obx(
            () => chatController.myMessage.value.isNotEmpty
                ? ResponsiveRowColumn(
                    layout: ResponsiveRowColumnType.COLUMN,
                    columnCrossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ResponsiveRowColumnItem(
                          child: Container(
                        margin: EdgeInsets.only(
                            right: SizeConfig.horizontal(12),
                            top: SizeConfig.horizontal(3)),
                        padding: EdgeInsets.all(SizeConfig.horizontal(2)),
                        width: SizeConfig.horizontal(60),
                        decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  blurRadius: 4,
                                  spreadRadius: 2,
                                  offset: const Offset(-1, 3),
                                  color: AppColors.greyDisabled)
                            ],
                            color: AppColors.white,
                            borderRadius: BorderRadius.only(
                              topLeft:
                                  Radius.circular(SizeConfig.horizontal(2)),
                              topRight:
                                  Radius.circular(SizeConfig.horizontal(2)),
                              bottomLeft:
                                  Radius.circular(SizeConfig.horizontal(2)),
                            )),
                        child: RobotoTextView(
                          value: chatController.myMessage.value,
                          size: SizeConfig.safeBlockHorizontal * 4,
                          color: AppColors.black,
                        ),
                      )),
                      const ResponsiveRowColumnItem(
                        child: ResponsiveRowColumn(
                          layout: ResponsiveRowColumnType.ROW,
                          children: [
                            ResponsiveRowColumnItem(child: Spacer()),
                            ResponsiveRowColumnItem(
                              child: CircleAvatar(
                                minRadius: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          )),
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
                            decoration: BoxDecoration(color: AppColors.white),
                            width: SizeConfig.horizontal(88),
                            child: SizedBox(
                                child: TextFormField(
                              onFieldSubmitted: (String value) {
                                chatController.myMessage.value = value;
                                chatController.chatEditingController.clear();
                              },
                              textInputAction: TextInputAction.send,
                              decoration: InputDecoration(
                                  suffixIcon:
                                      const Icon(Icons.control_point_outlined),
                                  hintText: 'Enter Message...',
                                  contentPadding: EdgeInsets.only(
                                      top: SizeConfig.horizontal(2),
                                      left: SizeConfig.horizontal(4))),
                              controller: chatController.chatEditingController,
                            )))),
                    ResponsiveRowColumnItem(
                        child: Container(
                      color: AppColors.redAlert,
                      width: SizeConfig.horizontal(12),
                      height: SizeConfig.horizontal(12),
                      child: Icon(
                        Icons.mic,
                        size: SizeConfig.horizontal(8),
                      ),
                    ))
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
