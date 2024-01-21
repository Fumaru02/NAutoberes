import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/akun_controller.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/enums.dart';
import '../../../utils/size_config.dart';
import '../text/roboto_text_view.dart';

class Username extends StatelessWidget {
  const Username({
    super.key,
    this.size,
  });
  final double? size;

  @override
  Widget build(BuildContext context) {
    final AkunController akunController = Get.put(AkunController());

    return Obx(
      () => RobotoTextView(
          value: akunController.username.value,
          size: SizeConfig.safeBlockHorizontal * (size ?? 3.5),
          fontWeight: FontWeight.bold,
          alignText: AlignTextType.left),
    );
  }
}

class UserPicture extends StatelessWidget {
  const UserPicture({
    super.key,
    this.size,
  });
  final double? size;

  @override
  Widget build(BuildContext context) {
    final AkunController akunController = Get.put(AkunController());

    return Obx(() => akunController.isLoading.isTrue
        ? const Center(child: CircularProgressIndicator())
        : akunController.userImage.value == ''
            ? CircleAvatar(
                minRadius: 30,
                child: Icon(
                  Icons.person_2_rounded,
                  size: SizeConfig.horizontal(10),
                ),
              )
            : CircleAvatar(
                backgroundImage: NetworkImage(akunController.userImage.value),
                minRadius: size ?? 30,
              ));
  }
}

class UserStatus extends StatelessWidget {
  const UserStatus({
    super.key,
    this.size,
    this.height,
    this.width,
  });

  final double? size;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final AkunController akunController = Get.put(AkunController());

    return Obx(
      () => akunController.userStatus.value != 'User'
          ? Container(
              width: width,
              height: height,
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.horizontal(0.2),
                  horizontal: SizeConfig.horizontal(2)),
              decoration: BoxDecoration(
                  color: AppColors.goldButton,
                  borderRadius: BorderRadius.all(
                      Radius.circular(SizeConfig.horizontal(1)))),
              child: Center(
                child: RobotoTextView(
                  color: AppColors.black,
                  value: akunController.userStatus.value,
                  size: SizeConfig.safeBlockHorizontal * 3,
                  alignText: AlignTextType.left,
                ),
              ),
            )
          : RobotoTextView(
              value: akunController.userStatus.value,
              size: SizeConfig.safeBlockHorizontal * (size ?? 3),
              alignText: AlignTextType.left),
    );
  }
}
