import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_row_column.dart';

import '../../controllers/chat_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/enums.dart';
import '../../utils/size_config.dart';
import '../widgets/custom/custom_ripple_button.dart';
import '../widgets/text/roboto_text_view.dart';
import 'chat_room_view.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
        init: ChatController(),
        builder: (ChatController chatController) => ListView.builder(
              itemCount: 2,
              itemBuilder: (BuildContext context, int index) =>
                  CustomRippleButton(
                onTap: () => Get.to(const ChatRoomView()),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: AppColors.black,
                              width: SizeConfig.horizontal(0.2)))),
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.horizontal(4)),
                  height: SizeConfig.horizontal(20),
                  child: ResponsiveRowColumn(
                    layout: ResponsiveRowColumnType.ROW,
                    columnMainAxisAlignment: MainAxisAlignment.center,
                    rowSpacing: 8,
                    children: <ResponsiveRowColumnItem>[
                      const ResponsiveRowColumnItem(
                          child: CircleAvatar(
                        minRadius: 28,
                      )),
                      ResponsiveRowColumnItem(
                          child: ResponsiveRowColumn(
                        layout: ResponsiveRowColumnType.COLUMN,
                        columnMainAxisAlignment: MainAxisAlignment.center,
                        columnCrossAxisAlignment: CrossAxisAlignment.start,
                        children: <ResponsiveRowColumnItem>[
                          ResponsiveRowColumnItem(
                            child: ResponsiveRowColumn(
                              layout: ResponsiveRowColumnType.ROW,
                              rowSpacing: 4,
                              children: <ResponsiveRowColumnItem>[
                                ResponsiveRowColumnItem(
                                  child: RobotoTextView(
                                    value: 'Fumaru',
                                    color: AppColors.black,
                                  ),
                                ),
                                ResponsiveRowColumnItem(
                                    child: Container(
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.horizontal(2)),
                                  padding: EdgeInsets.symmetric(
                                      vertical: SizeConfig.horizontal(0.5),
                                      horizontal: SizeConfig.horizontal(2)),
                                  decoration: BoxDecoration(
                                      color: AppColors.goldButton,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              SizeConfig.horizontal(1)))),
                                  child: Center(
                                    child: RobotoTextView(
                                      color: AppColors.black,
                                      value: 'Founder',
                                      size: SizeConfig.safeBlockHorizontal * 3,
                                      alignText: AlignTextType.left,
                                    ),
                                  ),
                                ))
                              ],
                            ),
                          ),
                          ResponsiveRowColumnItem(
                            child: SizedBox(
                              width: SizeConfig.horizontal(70),
                              child: RobotoTextView(
                                value:
                                    'baru aja wloakwoda wokoakdokwa owdkoakdoasdaowmdoamwod',
                                size: SizeConfig.safeBlockHorizontal * 3.5,
                                overFlow: TextOverflow.ellipsis,
                                color: AppColors.greyButton,
                              ),
                            ),
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ));
  }
}
