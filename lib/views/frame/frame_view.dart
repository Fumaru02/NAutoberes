import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controllers/frame_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/size_config.dart';
import '../widgets/frame/frame_bottom_nav_bar.dart';

class FrameView extends StatefulWidget {
  const FrameView({super.key});

  @override
  State<FrameView> createState() => _FrameViewState();
}

class _FrameViewState extends State<FrameView> {
  final FrameController _controller = Get.put(
    FrameController(),
  );

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.blackBackground,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Obx(() => FrameBottomNav(
            onBack: () => _controller.onTapNav(0),
            isUseLeading: _useBackButton(),
            isImplyLeading: false,
            elevation: 0,
            heightBar: _whenUseHeightBar(),
            isCenter: false,
            statusBarColor: _colorStatusBar(),
            titleScreen: _useTitleAppBar(),
            statusBarBrightness: Brightness.light,
          )),
    );
  }

  //need maintenance
  Color _colorStatusBar() {
    if (_controller.defaultIndex.value == 1 ||
        _controller.defaultIndex.value == 2) {
      return AppColors.black;
    } else {
      return AppColors.black;
    }
  }

  double _whenUseHeightBar() {
    if (_controller.defaultIndex.value == 1) {
      return SizeConfig.horizontal(12);
    } else {
      return 0;
    }
  }

  String _useTitleAppBar() {
    if (_controller.defaultIndex.value == 1) {
      return 'Chat Room';
    } else {
      return '';
    }
  }

  bool _useBackButton() {
    if (_controller.defaultIndex.value == 1) {
      return true;
    } else {
      return false;
    }
  }
}
