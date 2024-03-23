import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/home/home_controller.dart';

class ScrollToHideWidget extends StatelessWidget {
  const ScrollToHideWidget({
    super.key,
    required this.child,
    required this.controller,
    this.duration = const Duration(milliseconds: 200),
    required this.homeController,
  });

  final Widget child;
  final ScrollController controller;
  final Duration duration;
  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_final_locals
    return Obx(
      () => AnimatedContainer(
        height:
            homeController.isVisible.isFalse ? kBottomNavigationBarHeight : 0,
        duration: duration,
        child: child,
      ),
    );
  }
}
