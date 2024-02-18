import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_row_column.dart';

import '../../controllers/akun_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/size_config.dart';
import '../widgets/custom/custom_confirmation_dialog.dart';
import '../widgets/custom/custom_ripple_button.dart';
import '../widgets/layouts/space_sizer.dart';
import '../widgets/text/inter_text_view.dart';
import '../widgets/user/user_info.dart';
import 'edit_profile_view.dart';

class AkunView extends StatelessWidget {
  const AkunView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AkunController>(
        init: AkunController(),
        builder: (AkunController akunController) => Center(
              child: ResponsiveRowColumn(
                layout: ResponsiveRowColumnType.COLUMN,
                children: <ResponsiveRowColumnItem>[
                  const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 1)),
                  ResponsiveRowColumnItem(
                      child: ResponsiveRowColumn(
                    layout: ResponsiveRowColumnType.COLUMN,
                    columnCrossAxisAlignment: CrossAxisAlignment.start,
                    children: <ResponsiveRowColumnItem>[
                      ResponsiveRowColumnItem(
                          child: ResponsiveRowColumn(
                        layout: ResponsiveRowColumnType.ROW,
                        rowPadding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.horizontal(4),
                            vertical: SizeConfig.horizontal(2)),
                        rowSpacing: 8,
                        children: <ResponsiveRowColumnItem>[
                          const ResponsiveRowColumnItem(
                              child: UserPicture(size: 45)),
                          ResponsiveRowColumnItem(
                              child: ResponsiveRowColumn(
                            layout: ResponsiveRowColumnType.COLUMN,
                            columnCrossAxisAlignment: CrossAxisAlignment.start,
                            children: <ResponsiveRowColumnItem>[
                              const ResponsiveRowColumnItem(
                                  child: ResponsiveRowColumn(
                                      layout: ResponsiveRowColumnType.ROW,
                                      children: <ResponsiveRowColumnItem>[
                                    ResponsiveRowColumnItem(
                                        child: Username(size: 5)),
                                  ])),
                              const ResponsiveRowColumnItem(
                                  child: SpaceSizer(vertical: 1)),
                              const ResponsiveRowColumnItem(
                                  child: UserStatus(size: 4.5)),
                              const ResponsiveRowColumnItem(
                                  child: SpaceSizer(vertical: 1)),
                              ResponsiveRowColumnItem(
                                  child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.horizontal(2),
                                  vertical: SizeConfig.horizontal(0.5),
                                ),
                                decoration: BoxDecoration(
                                    color: AppColors.greenDRT,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            SizeConfig.horizontal(4)))),
                                child: ResponsiveRowColumn(
                                  layout: ResponsiveRowColumnType.ROW,
                                  children: <ResponsiveRowColumnItem>[
                                    ResponsiveRowColumnItem(
                                      child: InterTextView(
                                        value: 'Email terverifikasi',
                                        size: SizeConfig.safeBlockHorizontal *
                                            3.5,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.greenSuccess,
                                      ),
                                    ),
                                    const ResponsiveRowColumnItem(
                                        child: SpaceSizer(horizontal: 1)),
                                    ResponsiveRowColumnItem(
                                        child: Container(
                                            padding: EdgeInsets.all(
                                                SizeConfig.horizontal(1)),
                                            decoration: BoxDecoration(
                                                color: AppColors.greenSuccess,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        SizeConfig.horizontal(
                                                            4)))),
                                            child: Icon(
                                              Icons.check,
                                              color: AppColors.white,
                                              size: SizeConfig.horizontal(4),
                                            )))
                                  ],
                                ),
                              )),
                              const ResponsiveRowColumnItem(
                                  child: SpaceSizer(vertical: 0.5)),
                            ],
                          )),
                        ],
                      )),
                    ],
                  )),
                  const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 1)),
                  ResponsiveRowColumnItem(
                      child: CustomDividerText(
                          title: 'Edit Profile',
                          onTap: () => Get.to(const EditProfileView()),
                          icon: Icons.edit)),
                  ResponsiveRowColumnItem(
                      child: CustomDividerText(
                          icon: Icons.maps_home_work_outlined,
                          title: 'Workshop Manager',
                          onTap: () {})),
                  ResponsiveRowColumnItem(
                      child: CustomDividerText(
                          icon: Icons.home_repair_service_rounded,
                          title: 'Service Manager',
                          onTap: () {})),
                  ResponsiveRowColumnItem(
                      child: CustomDividerText(
                    icon: Icons.logout_sharp,
                    title: 'Log Out',
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              CustomConfirmationDialog(
                                  onConfirm: () => akunController.signOut(),
                                  title: 'Log out of your account',
                                  confirmText: 'Keep Log out',
                                  cancelText: 'Cancel',
                                  width: 50));
                    },
                  ))
                ],
              ),
            ));
  }
}

class TextGoldDivider extends StatelessWidget {
  const TextGoldDivider({
    super.key,
    required this.title,
    required this.subtitle,
    this.overflowText = false,
  });

  final String title;
  final String subtitle;
  final bool? overflowText;

  @override
  Widget build(BuildContext context) {
    return ResponsiveRowColumn(
        layout: ResponsiveRowColumnType.COLUMN,
        columnPadding:
            EdgeInsets.symmetric(horizontal: SizeConfig.horizontal(4)),
        columnCrossAxisAlignment: CrossAxisAlignment.start,
        children: <ResponsiveRowColumnItem>[
          const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 0.5)),
          ResponsiveRowColumnItem(
              child: InterTextView(
                  value: title,
                  fontWeight: FontWeight.bold,
                  size: SizeConfig.safeBlockHorizontal * 4.5)),
          ResponsiveRowColumnItem(
              child: Container(
                  height: SizeConfig.horizontal(1),
                  width: SizeConfig.horizontal(5),
                  color: AppColors.gold)),
          ResponsiveRowColumnItem(
              child: SizedBox(
                  width:
                      // ignore: use_if_null_to_convert_nulls_to_bools
                      overflowText == true ? SizeConfig.horizontal(30) : null,
                  child: InterTextView(
                      value: subtitle,
                      overFlow:
                          // ignore: use_if_null_to_convert_nulls_to_bools
                          overflowText == true ? TextOverflow.ellipsis : null,
                      fontWeight: FontWeight.w400,
                      size: SizeConfig.safeBlockHorizontal * 4))),
        ]);
  }
}

class CustomDividerText extends StatelessWidget {
  const CustomDividerText(
      {super.key,
      required this.title,
      this.textSize,
      this.iconSize,
      required this.onTap,
      this.icon,
      this.useArrowIcon = true,
      this.isCenter = true,
      this.iconColor});

  final String title;
  final double? textSize;
  final double? iconSize;
  final Function() onTap;
  final IconData? icon;
  final bool? useArrowIcon;
  final bool? isCenter;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: SizeConfig.horizontal(2)),
      width: SizeConfig.horizontal(90),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: SizeConfig.horizontal(0.1)))),
      child: CustomRippleButton(
        onTap: onTap,
        child: ResponsiveRowColumn(
          layout: ResponsiveRowColumnType.ROW,
          rowMainAxisAlignment: MainAxisAlignment.center,
          rowSpacing: 8,
          rowPadding: EdgeInsets.all(SizeConfig.horizontal(2)),
          children: <ResponsiveRowColumnItem>[
            ResponsiveRowColumnItem(
                child: Icon(icon, size: iconSize, color: iconColor)),
            ResponsiveRowColumnItem(
                child: InterTextView(
                    value: title,
                    color: AppColors.black,
                    size: SizeConfig.safeBlockHorizontal * (textSize ?? 4))),
            ResponsiveRowColumnItem(
                // ignore: use_if_null_to_convert_nulls_to_bools
                child: isCenter == true
                    ? const Spacer()
                    : const SizedBox.shrink()),
            ResponsiveRowColumnItem(
                child: useArrowIcon == false
                    ? const SizedBox.shrink()
                    : const Icon(Icons.arrow_forward_ios_outlined))
          ],
        ),
      ),
    );
  }
}
