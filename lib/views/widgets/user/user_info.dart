import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/akun_controller.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/enums.dart';
import '../../../utils/size_config.dart';
import '../custom/custom_shimmer_placeholder.dart';
import '../text/inter_text_view.dart';

class UserEmail extends StatelessWidget {
  const UserEmail({super.key});

  @override
  Widget build(BuildContext context) {
    final AkunController akunController = Get.put(AkunController());

    return Obx(
      () => InterTextView(
          value: akunController.userEmail.value, color: AppColors.black),
    );
  }
}

class Username extends StatelessWidget {
  const Username({
    super.key,
    this.size,
    this.color,
  });
  final double? size;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    final AkunController akunController = Get.put(AkunController());

    return Obx(
      () => InterTextView(
          value: akunController.username.value,
          color: color ?? AppColors.black,
          size: SizeConfig.safeBlockHorizontal * (size ?? 3.5),
          fontWeight: FontWeight.bold,
          alignText: AlignTextType.left),
    );
  }
}

class UserPicture extends StatelessWidget {
  const UserPicture({
    super.key,
    this.width,
    this.height,
    this.isUseBorder,
  });
  final double? width;
  final double? height;
  final bool? isUseBorder;

  @override
  Widget build(BuildContext context) {
    final AkunController akunController = Get.put(AkunController());

    return Obx(
      () => akunController.isLoading.isTrue
          ? Center(
              child: CustomShimmerPlaceHolder(
                  width: SizeConfig.horizontal(17),
                  borderRadius: SizeConfig.horizontal(20)))
          : akunController.userImage.value == ''
              ? CircleAvatar(
                  minRadius: 30,
                  child: Icon(Icons.person_2_rounded,
                      size: SizeConfig.horizontal(10)))
              : Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(SizeConfig.horizontal(20))),
                      // ignore: use_if_null_to_convert_nulls_to_bools
                      border: isUseBorder == true
                          ? Border.all(
                              color: AppColors.white,
                              width: SizeConfig.horizontal(1))
                          : null),
                  width: SizeConfig.horizontal(width ?? 20),
                  height: SizeConfig.horizontal(height ?? 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                        Radius.circular(SizeConfig.horizontal(20))),
                    child: CachedNetworkImage(
                        imageUrl: akunController.userImage.value,
                        fit: BoxFit.cover),
                  ),
                ),
    );
  }
}

class UserStatus extends StatelessWidget {
  const UserStatus({
    super.key,
    this.size,
    this.height,
    this.width,
    this.textColor,
  });

  final double? size;
  final double? height;
  final double? width;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final AkunController akunController = Get.put(AkunController());

    return Obx(() => akunController.userStatus.value != 'User'
        ? Container(
            width: width,
            height: height,
            padding: EdgeInsets.symmetric(
                vertical: SizeConfig.horizontal(0.2),
                horizontal: SizeConfig.horizontal(2)),
            decoration: BoxDecoration(
                color: AppColors.gold,
                borderRadius: BorderRadius.all(
                    Radius.circular(SizeConfig.horizontal(1)))),
            child: Center(
              child: InterTextView(
                color: AppColors.black,
                value: akunController.userStatus.value,
                size: SizeConfig.safeBlockHorizontal * 3,
                alignText: AlignTextType.left,
              ),
            ),
          )
        : Container(
            width: width,
            height: height,
            padding: EdgeInsets.symmetric(
                vertical: SizeConfig.horizontal(0.2),
                horizontal: SizeConfig.horizontal(2)),
            decoration: BoxDecoration(
                color: AppColors.greyTextDisabled,
                borderRadius: BorderRadius.all(
                    Radius.circular(SizeConfig.horizontal(1)))),
            child: InterTextView(
              value: akunController.userStatus.value,
              size: SizeConfig.safeBlockHorizontal * (size ?? 3),
              alignText: AlignTextType.left,
              color: textColor ?? AppColors.black,
            ),
          ));
  }
}
