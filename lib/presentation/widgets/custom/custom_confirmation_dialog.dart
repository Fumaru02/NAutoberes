import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/enums.dart';
import '../../../core/utils/size_config.dart';
import '../layouts/space_sizer.dart';
import '../logo/autoberes_logo.dart';
import '../text/inter_text_view.dart';
import 'custom_flat_button.dart';

class CustomConfirmationDialog extends StatelessWidget {
  const CustomConfirmationDialog({
    super.key,
    required this.title,
    required this.confirmText,
    required this.cancelText,
    this.width,
    required this.onConfirm,
  });

  final String title;
  final String confirmText;
  final String cancelText;
  final double? width;
  final Function() onConfirm;
  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: AppColors.blackBackground,
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.horizontal(4)),
          child: ResponsiveRowColumn(
            layout: ResponsiveRowColumnType.COLUMN,
            columnMainAxisSize: MainAxisSize.min,
            children: <ResponsiveRowColumnItem>[
              const ResponsiveRowColumnItem(
                  child: AutoBeresLogo(
                height: 20,
                width: 19,
              )),
              const ResponsiveRowColumnItem(
                  child: SpaceSizer(
                vertical: 1,
              )),
              ResponsiveRowColumnItem(
                  child: InterTextView(
                value: title,
                fontWeight: FontWeight.bold,
                alignText: AlignTextType.center,
              )),
              const ResponsiveRowColumnItem(
                  child: SpaceSizer(
                vertical: 2,
              )),
              ResponsiveRowColumnItem(
                  child: ResponsiveRowColumn(
                layout: ResponsiveRowColumnType.COLUMN,
                columnSpacing: 8,
                children: <ResponsiveRowColumnItem>[
                  ResponsiveRowColumnItem(
                      child: CustomFlatButton(
                          backgroundColor: AppColors.white,
                          textSize: 4,
                          radius: 1,
                          width: SizeConfig.horizontal(width ?? 70),
                          text: confirmText,
                          textColor: AppColors.blackBackground,
                          onTap: onConfirm)),
                  ResponsiveRowColumnItem(
                      child: CustomFlatButton(
                          textSize: 4,
                          radius: 1,
                          width: SizeConfig.horizontal(width ?? 70),
                          text: cancelText,
                          backgroundColor: AppColors.redAlert,
                          textColor: AppColors.white,
                          onTap: () => Get.back()))
                ],
              ))
            ],
          ),
        ));
  }
}
