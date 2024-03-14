import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/login_controller.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/size_config.dart';

class CustomBackgroundApps extends StatelessWidget {
  const CustomBackgroundApps({
    super.key,
    required this.child,
  });

  final Widget child;
  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());
    return Stack(
      children: <Widget>[
        Obx(
          () => BubbleGrey(
            onPress: () => loginController.isTapBubble1.value = true,
            seconds: 15,
            color: loginController.isTapBubble1.isTrue
                ? AppColors.blackBackground
                : AppColors.gold,
            left: SizeConfig.horizontal(45),
            bottom:
                loginController.isFloating.isTrue ? SizeConfig.vertical(82) : 0,
            loginController: loginController,
            size: 26,
          ),
        ),
        Obx(
          () => BubbleGrey(
            onPress: () => loginController.isTapBubble2.value = true,
            seconds: 12,
            color: loginController.isTapBubble2.isTrue
                ? AppColors.blackBackground
                : AppColors.greenDRT,
            left: SizeConfig.horizontal(2),
            bottom:
                loginController.isFloating.isTrue ? SizeConfig.vertical(87) : 0,
            loginController: loginController,
            size: 16,
          ),
        ),
        Obx(
          () => BubbleGrey(
            seconds: 18,
            onPress: () => loginController.isTapBubble3.value = true,
            color: loginController.isTapBubble3.isTrue
                ? AppColors.blackBackground
                : AppColors.redAlert,
            left: SizeConfig.horizontal(80),
            bottom:
                loginController.isFloating.isTrue ? SizeConfig.vertical(85) : 0,
            loginController: loginController,
            size: 20,
          ),
        ),
        Obx(
          () => BubbleGrey(
            seconds: 12,
            color: loginController.isTapBubble4.isTrue
                ? AppColors.blackBackground
                : AppColors.orangeActive,
            onPress: () => loginController.isTapBubble4.value = true,
            left: SizeConfig.horizontal(35),
            bottom:
                loginController.isFloating.isTrue ? SizeConfig.vertical(90) : 0,
            loginController: loginController,
            size: 10,
          ),
        ),
        child
      ],
    );
  }
}

class BubbleGrey extends StatelessWidget {
  const BubbleGrey({
    super.key,
    required this.loginController,
    this.left,
    this.right,
    this.top,
    this.bottom,
    this.size,
    required this.color,
    required this.seconds,
    required this.onPress,
  });

  final LoginController loginController;
  final double? left;
  final double? right;
  final double? top;
  final double? bottom;
  final double? size;
  final Color color;
  final int seconds;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      left: left,
      right: right,
      bottom: bottom,
      top: top,
      duration: Duration(seconds: seconds),
      child: GestureDetector(
        onTap: onPress,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          height: SizeConfig.horizontal(size!),
          width: SizeConfig.horizontal(size!),
        ),
      ),
    );
  }
}
