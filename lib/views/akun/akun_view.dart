import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_row_column.dart';

import '../../controllers/akun_controller.dart';
import '../../helpers/string_extension.dart';
import '../../utils/app_colors.dart';
import '../../utils/size_config.dart';
import '../widgets/custom/custom_card.dart';
import '../widgets/custom/custom_confirmation_dialog.dart';
import '../widgets/custom/custom_ripple_button.dart';
import '../widgets/layouts/space_sizer.dart';
import '../widgets/text/roboto_text_view.dart';
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
                      child: CustomCard(
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
                              child: UserPicture(size: 35)),
                          ResponsiveRowColumnItem(
                              child: ResponsiveRowColumn(
                            layout: ResponsiveRowColumnType.COLUMN,
                            columnCrossAxisAlignment: CrossAxisAlignment.start,
                            children: <ResponsiveRowColumnItem>[
                              ResponsiveRowColumnItem(
                                  child: ResponsiveRowColumn(
                                      layout: ResponsiveRowColumnType.ROW,
                                      children: <ResponsiveRowColumnItem>[
                                    const ResponsiveRowColumnItem(
                                        child: Username(size: 6)),
                                    ResponsiveRowColumnItem(
                                        child: Obx(() => Icon(
                                            akunController.userGender.value ==
                                                    'male'
                                                ? Icons.male
                                                : Icons.female,
                                            size: 35,
                                            color: akunController
                                                        .userGender.value ==
                                                    'male'
                                                ? AppColors.blueColor
                                                : AppColors.pinkColor)))
                                  ])),
                              const ResponsiveRowColumnItem(
                                  child: UserStatus(size: 4.5)),
                              const ResponsiveRowColumnItem(
                                  child: SpaceSizer(vertical: 0.5)),
                              ResponsiveRowColumnItem(
                                  child: SizedBox(
                                      width: SizeConfig.horizontal(60),
                                      child: Obx(() => RobotoTextView(
                                          value:
                                              '${akunController.userProfiency.value.capitalizeByWord()},${akunController.userCity.value.capitalizeByWord()},${akunController.userSubdistrict.value.capitalizeByWord()}',
                                          size: SizeConfig.safeBlockHorizontal *
                                              4,
                                          overFlow: TextOverflow.ellipsis))))
                            ],
                          )),
                        ],
                      )),
                      const ResponsiveRowColumnItem(child: Divider()),
                      ResponsiveRowColumnItem(
                          child: Obx(() => ResponsiveRowColumn(
                                layout: ResponsiveRowColumnType.COLUMN,
                                columnCrossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: <ResponsiveRowColumnItem>[
                                  ResponsiveRowColumnItem(
                                      child: TextGoldDivider(
                                          title: 'Email',
                                          subtitle:
                                              akunController.userEmail.value)),
                                  const ResponsiveRowColumnItem(
                                      child: TextGoldDivider(
                                          title: 'Birth Date',
                                          subtitle: '02 September 1950')),
                                  ResponsiveRowColumnItem(
                                      child: TextGoldDivider(
                                          title: 'Gender',
                                          subtitle: akunController
                                              .userGender.value
                                              .capitalizeByWord())),
                                  const ResponsiveRowColumnItem(
                                      child: TextGoldDivider(
                                          title: 'Address',
                                          subtitle: 'Jl.Pendidikan 4')),
                                  const ResponsiveRowColumnItem(
                                      child: SpaceSizer(vertical: 2)),
                                ],
                              )))
                    ],
                  ))),
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
              child: RobotoTextView(
                  value: title,
                  fontWeight: FontWeight.bold,
                  size: SizeConfig.safeBlockHorizontal * 4.5)),
          ResponsiveRowColumnItem(
              child: Container(
                  height: SizeConfig.horizontal(1),
                  width: SizeConfig.horizontal(5),
                  color: AppColors.goldButton)),
          ResponsiveRowColumnItem(
              child: SizedBox(
                  width:
                      // ignore: use_if_null_to_convert_nulls_to_bools
                      overflowText == true ? SizeConfig.horizontal(30) : null,
                  child: RobotoTextView(
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
                child: RobotoTextView(
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
