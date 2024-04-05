import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/size_config.dart';
import '../../blocs/chat/chat_bloc.dart';
import '../../widgets/text/inter_text_view.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late ScrollController scrollController = ScrollController();
  late FocusNode myFocusNode = FocusNode();
  final ChatBloc _chatBloc = ChatBloc();
  @override
  void initState() {
    super.initState();
    _chatBloc.add(UserChats());
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        Future<void>.delayed(const Duration(milliseconds: 500), () {
          scrollController.animateTo(scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn);
        });
      }
    });
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveRowColumn(
      layout: ResponsiveRowColumnType.COLUMN,
      children: <ResponsiveRowColumnItem>[
        ResponsiveRowColumnItem(
          child: Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (_, ChatState listchatstate) {
                final List<QueryDocumentSnapshot<Map<String, dynamic>>> chat =
                    listchatstate.chats;
                return ListView.builder(
                    itemCount: chat.length,
                    itemBuilder: (BuildContext context, int index) {
                      return BlocProvider<ChatBloc>(
                        create: (_) => ChatBloc()
                          ..add(DirectMessage(
                              targetId: chat[index]['connection'] as String)),
                        child: BlocBuilder<ChatBloc, ChatState>(
                          builder: (_, ChatState state) {
                            return ListTile(
                              onTap: () => context.read<ChatBloc>()
                                ..add(GotoRoomChat(
                                    chatId: chat[index].id,
                                    userUidChat: state.targetUid,
                                    targetUid: state.targetUid,
                                    targetConnection:
                                        chat[index]['connection'] as String,
                                    targetName: state.targetName,
                                    targetPicture: state.targetImage)),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(SizeConfig.horizontal(20))),
                                child: state.targetImage == ''
                                    ? const CircularProgressIndicator()
                                    : CachedNetworkImage(
                                        imageUrl: state.targetImage,
                                        fit: BoxFit.fill,
                                        width: SizeConfig.horizontal(13),
                                        height: SizeConfig.horizontal(13),
                                      ),
                              ),
                              title: InterTextView(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                  size: SizeConfig.safeBlockHorizontal * 4.5,
                                  value: state.targetName),
                              subtitle: InterTextView(
                                value: state.username,
                                color: AppColors.grey,
                              ),
                              trailing: chat[index]['total_unread'] == 0
                                  ? const SizedBox.shrink()
                                  : Chip(
                                      backgroundColor: AppColors.redAlert,
                                      label: InterTextView(
                                        value: chat[index]['total_unread']
                                            .toString(),
                                        fontWeight: FontWeight.bold,
                                      )),
                            );
                          },
                        ),
                      );
                    });
              },
            ),
          ),
        )
      ],
    );
  }
}
