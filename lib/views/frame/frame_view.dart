import 'package:flutter/material.dart';
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
    return Obx(() => FrameBottomNav(
          onBack: () => _controller.onTapNav(0),
          isUseLeading: _useBackButton(),
          isImplyLeading: false,
          elevation: 0,
          heightBar: _whenUseHeightBar(),
          isCenter: _isCenterTitle(),
          statusBarColor: _colorStatusBar(),
          titleScreen: _useTitleAppBar(),
          color: AppColors.blackBackground,
        ));
  }

  //need maintenance
  Color _colorStatusBar() {
    if (_controller.defaultIndex.value == 1) {
      return Colors.white;
    } else {
      return AppColors.blackBackground;
    }
  }

  bool _isCenterTitle() {
    if (_controller.defaultIndex.value == 2 ||
        _controller.defaultIndex.value == 3 ||
        _controller.defaultIndex.value == 4) {
      return true;
    } else {
      return false;
    }
  }

  double _whenUseHeightBar() {
    if (_controller.defaultIndex.value == 1 ||
        _controller.defaultIndex.value == 2 ||
        _controller.defaultIndex.value == 3 ||
        _controller.defaultIndex.value == 4) {
      return SizeConfig.horizontal(14);
    } else {
      return 0;
    }
  }

  String _useTitleAppBar() {
    if (_controller.defaultIndex.value == 1) {
      return 'Chat Room';
    } else if (_controller.defaultIndex.value == 2) {
      return 'Home Services';
    } else if (_controller.defaultIndex.value == 3) {
      return 'Workshop';
    } else if (_controller.defaultIndex.value == 4) {
      return 'My Profile';
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
