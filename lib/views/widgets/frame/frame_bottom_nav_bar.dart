import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_row_column.dart';

import '../../../controllers/frame_controller.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/asset_list.dart';
import '../../../utils/size_config.dart';
import '../custom/custom_image_asset.dart';
import '../layouts/space_sizer.dart';
import '../text/roboto_text_view.dart';
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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.blackBackground,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: DefaultTabController(
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
            body: SafeArea(
              bottom: false,
              child: Obx(
                () => IndexedStack(
                  index: frameController.defaultIndex.toInt(),
                  children: frameController.widgetViewList,
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: _CenterFloatingButton(
              frameController: frameController,
              onTap: () {
                frameController.onTapNav(2);
              },
            ),
            bottomNavigationBar: _bottomAppBar(
                context: context, frameController: frameController)),
      ),
    );
  }

  BottomAppBar _bottomAppBar(
      {required BuildContext context,
      required FrameController frameController}) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: AppColors.blackBackground,
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: BottomNavigationBar(
        onTap: (int index) {
          return frameController.onTapNav(index);
        },
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        backgroundColor: Colors.transparent,
        selectedLabelStyle: const TextStyle(fontSize: 0),
        unselectedLabelStyle: const TextStyle(fontSize: 0),
        iconSize: 0,
        items: menuLIst(frameController),
      ),
    );
  }

  List<BottomNavigationBarItem> menuLIst(FrameController frameController) {
    return <BottomNavigationBarItem>[
      _bottomNavigationBarItemDefault(
        frameController: frameController,
        asset: AssetList.homeIcon,
        label: 'Home',
        index: 0,
      ),
      _bottomNavigationBarItemDefault(
        frameController: frameController,
        asset: AssetList.chatIcon,
        label: 'Chat',
        index: 1,
      ),
      BottomNavigationBarItem(
        icon: ResponsiveRowColumn(
          layout: ResponsiveRowColumnType.COLUMN,
          columnMainAxisAlignment: MainAxisAlignment.end,
          children: <ResponsiveRowColumnItem>[
            const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 4)),
            ResponsiveRowColumnItem(
              child: RobotoTextView(
                value: 'Services',
                size: SizeConfig.safeBlockHorizontal * 2.9,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        label: '',
      ),
      _bottomNavigationBarItemDefault(
        frameController: frameController,
        asset: AssetList.outletsIcon,
        label: 'Outlets',
        index: 3,
      ),
      _bottomNavigationBarItemDefault(
        frameController: frameController,
        asset: AssetList.akunIcon,
        label: 'Akun',
        index: 4,
      ),
    ];
  }

  BottomNavigationBarItem _bottomNavigationBarItemDefault({
    required String asset,
    required String label,
    required int index,
    required FrameController frameController,
    double? widthIcon,
    double? heightIcon,
  }) {
    return BottomNavigationBarItem(
      icon: _MenuItemWrapper(
        frameController: frameController,
        asset: asset,
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
    Key? key,
    required this.onTap,
    required this.frameController,
  }) : super(key: key);

  final Function() onTap;
  final FrameController frameController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.all(Radius.circular(SizeConfig.horizontal(4))),
          boxShadow: [
            BoxShadow(
                blurRadius: 0.2,
                color: AppColors.black,
                offset: const Offset(0, 3))
          ]),
      height: SizeConfig.horizontal(20),
      width: SizeConfig.horizontal(22),
      child: FloatingActionButton(
        backgroundColor: frameController.defaultIndex.value == 2
            ? AppColors.goldButton
            : AppColors.blackBackground,
        elevation: 0,
        onPressed: onTap,
        child: Image.asset(
          AssetList.servicesIcon,
          color: AppColors.white,
        ),
      ),
    );
  }
}

class _MenuItemWrapper extends StatelessWidget {
  const _MenuItemWrapper({
    Key? key,
    required this.asset,
    required this.label,
    required this.index,
    this.widthIcon,
    this.heightIcon,
    required this.frameController,
  }) : super(key: key);

  final String asset;
  final String label;
  final int index;
  final double? widthIcon;
  final double? heightIcon;
  final FrameController frameController;

  @override
  Widget build(BuildContext context) {
    return ResponsiveRowColumn(
      layout: ResponsiveRowColumnType.COLUMN,
      columnMainAxisSize: MainAxisSize.min,
      children: <ResponsiveRowColumnItem>[
        ResponsiveRowColumnItem(
          child: Obx(
            () => CustomImageAsset(
              decoration: frameController.onTapIdentifierList[index].isOnTapped
                  ? BoxDecoration(
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(SizeConfig.horizontal(6)),
                        right: Radius.circular(SizeConfig.horizontal(6)),
                      ),
                    )
                  : null,
              asset: asset,
              width: widthIcon ?? 6,
              height: heightIcon ?? 6,
              color: frameController.onTapIdentifierList[index].isOnTapped
                  ? AppColors.goldButton
                  : AppColors.white,
            ),
          ),
        ),
        const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 1)),
        ResponsiveRowColumnItem(
          child: RobotoTextView(
            value: label,
            color: frameController.onTapIdentifierList[index].isOnTapped
                ? AppColors.goldButton
                : AppColors.white,
            size: widthIcon == null && heightIcon == null
                ? SizeConfig.safeBlockHorizontal * 2.9
                : SizeConfig.safeBlockHorizontal * 2.8,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
