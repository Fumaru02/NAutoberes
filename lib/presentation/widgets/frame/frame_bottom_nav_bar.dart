import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../controllers/frame_controller.dart';
import '../../../controllers/home/home_controller.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/size_config.dart';
import '../custom/custom_scroll_to_hide_widget.dart';
import '../text/inter_text_view.dart';
import '../user/user_info.dart';
import 'frame_appbar.dart';

class FrameBottomNav extends FrameAppBar {
  const FrameBottomNav({
    super.titleScreen,
    super.heightBar,
    super.color,
    super.isCenter,
    super.elevation,
    super.isUseLeading,
    super.onBack,
    super.customLeading,
    super.action,
    super.isImplyLeading,
    super.customTitle,
    // status bar
    super.statusBarColor,
    super.statusBarIconBrightness,
    super.statusBarBrightness,
    // scaffold
    this.colorScaffold,
    super.key,
  });

  final Color? colorScaffold;

  @override
  Widget build(BuildContext context) {
    final FrameController frameController = Get.put(FrameController());
    return DefaultTabController(
        length: frameController.widgetViewList.length,
        child: Scaffold(
            backgroundColor: colorScaffold,
            extendBody: true,
            appBar: FrameAppBar(
              titleScreen: titleScreen,
              heightBar: heightBar,
              color: color,
              elevation: elevation,
              isCenter: isCenter,
              isUseLeading: isUseLeading,
              onBack: onBack,
              customLeading: customLeading,
              action: action,
              isImplyLeading: isImplyLeading,
              customTitle: customTitle,
              statusBarColor: statusBarColor,
              statusBarIconBrightness: statusBarIconBrightness,
              statusBarBrightness: statusBarBrightness,
            ),
            body: Obx(
              () => IndexedStack(
                index: frameController.defaultIndex.toInt(),
                children: frameController.widgetViewList,
              ),
            ),
            floatingActionButtonLocation:
                frameController.defaultIndex.value == 0
                    ? FloatingActionButtonLocation.miniEndFloat
                    : null,
            floatingActionButton: frameController.defaultIndex.value == 0
                ? _CenterFloatingButton(
                    frameController: frameController,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) => Container(),
                      );
                    },
                  )
                : null,
            bottomNavigationBar: frameController.defaultIndex.value != 1
                ? _bottomAppBar(
                    context: context, frameController: frameController)
                : null));
  }

  BottomAppBar _bottomAppBar(
      {required BuildContext context,
      required FrameController frameController}) {
    final HomeController homeController = Get.put(HomeController());
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: AppColors.white,
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: ScrollToHideWidget(
        homeController: homeController,
        controller: homeController.scrollController,
        child: SingleChildScrollView(
          child: BottomNavigationBar(
            onTap: (int index) {
              return frameController.onTapNav(index);
            },
            type: BottomNavigationBarType.fixed,
            elevation: 8.0,
            backgroundColor: const Color.fromARGB(255, 247, 247, 247),
            selectedLabelStyle: const TextStyle(fontSize: 0),
            unselectedLabelStyle: const TextStyle(fontSize: 0),
            iconSize: 0,
            items: menuLIst(frameController),
          ),
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> menuLIst(FrameController frameController) {
    return <BottomNavigationBarItem>[
      _bottomNavigationBarItemDefault(
        frameController: frameController,
        icon: Icons.home,
        label: 'Home',
        index: 0,
      ),
      _chatBottomNavBar(
        icon: Icons.chat,
        label: 'Chat',
        index: 1,
        frameController: frameController,
      ),
      _bottomNavigationBarItemDefault(
        frameController: frameController,
        icon: Icons.home_repair_service,
        label: 'Home Service',
        index: 2,
      ),
      _bottomNavigationBarItemDefault(
        frameController: frameController,
        icon: Icons.store_mall_directory_sharp,
        label: 'Workshop',
        index: 3,
      ),
      _akunBottomNavBar(
        frameController: frameController,
        icon: Icons.person_2_outlined,
        label: 'Akun',
        index: 4,
      ),
    ];
  }

  BottomNavigationBarItem _akunBottomNavBar({
    required IconData icon,
    required String label,
    required int index,
    required FrameController frameController,
    double? widthIcon,
    double? heightIcon,
  }) {
    return BottomNavigationBarItem(
      icon: _AkunWrapper(
        frameController: frameController,
        icon: icon,
        label: label,
        index: index,
        widthIcon: widthIcon,
        heightIcon: heightIcon,
      ),
      label: '',
    );
  }

  BottomNavigationBarItem _chatBottomNavBar({
    required IconData icon,
    required String label,
    required int index,
    required FrameController frameController,
    double? widthIcon,
    double? heightIcon,
  }) {
    return BottomNavigationBarItem(
      icon: _ChatMenuItemWrapper(
        frameController: frameController,
        icon: icon,
        label: label,
        index: index,
        widthIcon: widthIcon,
        heightIcon: heightIcon,
      ),
      label: '',
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItemDefault({
    required IconData icon,
    required String label,
    required int index,
    required FrameController frameController,
    double? widthIcon,
    double? heightIcon,
  }) {
    return BottomNavigationBarItem(
      icon: _MenuItemWrapper(
        frameController: frameController,
        icon: icon,
        label: label,
        index: index,
        widthIcon: widthIcon,
        heightIcon: heightIcon,
      ),
      label: '',
    );
  }
}

class _CenterFloatingButton extends StatelessWidget {
  const _CenterFloatingButton({
    required this.onTap,
    required this.frameController,
  });

  final Function() onTap;
  final FrameController frameController;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: frameController.defaultIndex.value == 5
          ? AppColors.grey
          : AppColors.redAlert,
      elevation: 0,
      onPressed: onTap,
      child: ResponsiveRowColumnItem(
          child: Icon(Icons.phone,
              color: AppColors.white, size: SizeConfig.horizontal(8))),
    );
  }
}

class _AkunWrapper extends StatelessWidget {
  const _AkunWrapper({
    required this.icon,
    required this.label,
    required this.index,
    this.widthIcon,
    this.heightIcon,
    required this.frameController,
  });

  final IconData icon;
  final String label;
  final int index;
  final double? widthIcon;
  final double? heightIcon;
  final FrameController frameController;

  @override
  Widget build(BuildContext context) {
    return ResponsiveRowColumn(
      layout: ResponsiveRowColumnType.COLUMN,
      children: <ResponsiveRowColumnItem>[
        ResponsiveRowColumnItem(
            child: Obx(() =>
                frameController.onTapIdentifierList[index].isOnTapped
                    ? Icon(icon,
                        size: heightIcon ?? SizeConfig.safeBlockHorizontal * 8,
                        color: AppColors.blackBackground)
                    : const UserPicture(
                        width: 7,
                        height: 7,
                      ))),
        ResponsiveRowColumnItem(
            child: InterTextView(
                value: label,
                color: frameController.onTapIdentifierList[index].isOnTapped
                    ? AppColors.blackBackground
                    : AppColors.greyDisabled,
                size: widthIcon == null && heightIcon == null
                    ? SizeConfig.safeBlockHorizontal * 2.7
                    : SizeConfig.safeBlockHorizontal * 2.8,
                fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class _MenuItemWrapper extends StatelessWidget {
  const _MenuItemWrapper({
    required this.icon,
    required this.label,
    required this.index,
    this.widthIcon,
    this.heightIcon,
    required this.frameController,
  });

  final IconData icon;
  final String label;
  final int index;
  final double? widthIcon;
  final double? heightIcon;
  final FrameController frameController;

  @override
  Widget build(BuildContext context) {
    return ResponsiveRowColumn(
      layout: ResponsiveRowColumnType.COLUMN,
      children: <ResponsiveRowColumnItem>[
        ResponsiveRowColumnItem(
          child: Obx(
            () => Icon(
              icon,
              size: heightIcon ?? SizeConfig.safeBlockHorizontal * 8,
              color: frameController.onTapIdentifierList[index].isOnTapped
                  ? AppColors.blackBackground
                  : AppColors.greyDisabled,
            ),
          ),
        ),
        ResponsiveRowColumnItem(
            child: InterTextView(
                value: label,
                color: frameController.onTapIdentifierList[index].isOnTapped
                    ? AppColors.blackBackground
                    : AppColors.greyDisabled,
                size: widthIcon == null && heightIcon == null
                    ? SizeConfig.safeBlockHorizontal * 2.7
                    : SizeConfig.safeBlockHorizontal * 2.8,
                fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class _ChatMenuItemWrapper extends StatelessWidget {
  const _ChatMenuItemWrapper({
    required this.icon,
    required this.label,
    required this.index,
    this.widthIcon,
    this.heightIcon,
    required this.frameController,
  });

  final IconData icon;
  final String label;
  final int index;
  final double? widthIcon;
  final double? heightIcon;
  final FrameController frameController;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: frameController.totalUnreadChat(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
                snapshot.data!.docs;
            final List<int> totalUnreadList = <int>[];

            for (final QueryDocumentSnapshot<Map<String, dynamic>> document
                in documents) {
              // Ambil nilai dari field total_unread
              final int totalUnread = document['total_unread'] as int;
              totalUnreadList.add(totalUnread);
              frameController.unReadNotif.value = totalUnreadList.fold(0,
                  (int previousValue, int element) => previousValue + element);
            }
            return ResponsiveRowColumn(
              layout: ResponsiveRowColumnType.COLUMN,
              children: <ResponsiveRowColumnItem>[
                ResponsiveRowColumnItem(
                    child: Obx(() => Stack(
                          children: <Widget>[
                            Icon(icon,
                                size: heightIcon ??
                                    SizeConfig.safeBlockHorizontal * 8,
                                color: AppColors.greyDisabled),
                            // ignore: prefer_if_elements_to_conditional_expressions
                            frameController.unReadNotif.value == 0
                                ? const SizedBox.shrink()
                                : Padding(
                                    padding: EdgeInsets.only(
                                        bottom: SizeConfig.horizontal(1),
                                        left: SizeConfig.horizontal(3)),
                                    child: CircleAvatar(
                                      radius: SizeConfig.horizontal(2),
                                      backgroundColor: AppColors.redAlert,
                                      child: InterTextView(
                                        value:
                                            '${frameController.unReadNotif.value}',
                                        size:
                                            SizeConfig.safeBlockHorizontal * 3,
                                      ),
                                    ),
                                  )
                          ],
                        ))),
                ResponsiveRowColumnItem(
                    child: InterTextView(
                        value: label,
                        color: frameController
                                .onTapIdentifierList[index].isOnTapped
                            ? AppColors.blackBackground
                            : AppColors.greyDisabled,
                        size: widthIcon == null && heightIcon == null
                            ? SizeConfig.safeBlockHorizontal * 2.7
                            : SizeConfig.safeBlockHorizontal * 2.8,
                        fontWeight: FontWeight.w500)),
              ],
            );
          }
          return const SizedBox.shrink();
        });
  }
}
