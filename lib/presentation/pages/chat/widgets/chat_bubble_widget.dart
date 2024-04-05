import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/size_config.dart';
import '../../../blocs/chat/chat_bloc.dart';
import '../../../widgets/custom/custom_bordered_container.dart';
import '../../../widgets/custom/custom_html_wrapper.dart';
import '../../../widgets/custom/custom_ripple_button.dart';
import '../../../widgets/text/inter_text_view.dart';
import 'item_chat.dart';

class ChatBubbleWidget extends StatefulWidget {
  const ChatBubbleWidget({
    super.key,
    required this.chatId,
    required this.userUid,
  });

  final String chatId;
  final String userUid;

  @override
  State<ChatBubbleWidget> createState() => _ChatBubbleWidgetState();
}

class _ChatBubbleWidgetState extends State<ChatBubbleWidget> {
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Expanded(child: BlocBuilder<ChatBloc, ChatState>(
      builder: (_, ChatState state) {
        final List<QueryDocumentSnapshot<Map<String, dynamic>>> allData =
            state.messages;
        return ListView.builder(
            controller: scrollController,
            itemCount: allData.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return ResponsiveRowColumn(
                  layout: ResponsiveRowColumnType.COLUMN,
                  children: <ResponsiveRowColumnItem>[
                    ResponsiveRowColumnItem(
                      child: state.isHideAttention
                          ? CustomRippleButton(
                              onTap: () {
                                context.read<ChatBloc>().add(
                                    const GetAttention(isHideAttention: true));
                              },
                              child: CustomBorderedContainer(
                                  padding:
                                      EdgeInsets.all(SizeConfig.horizontal(2)),
                                  color: AppColors.yellow,
                                  child: CustomHtmlWrapper(
                                      data: state.warningChat)),
                            )
                          : const SizedBox.shrink(),
                    ),
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
                            isSender:
                                // ignore: avoid_bool_literals_in_conditional_expressions
                                allData[index]['pengirim'] == widget.userUid
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
                      isSender: allData[index]['pengirim'] == widget.userUid
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
                              isSender:
                              // ignore: avoid_bool_literals_in_conditional_expressions
                                  allData[index]['pengirim'] == widget.userUid
                                      ? true
                                      : false,
                              msg: '${allData[index]['msg']}',
                              time: '${allData[index]['time']}'))
                    ],
                  );
                }
              }
            });
      },
    ));
  }
}
