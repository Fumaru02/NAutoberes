import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../controllers/akun_controller.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/size_config.dart';
import '../../widgets/custom/custom_confirmation_dialog.dart';
import '../../widgets/custom/custom_ripple_button.dart';
import '../../widgets/layouts/space_sizer.dart';
import '../../widgets/text/inter_text_view.dart';
import '../../widgets/user/user_info.dart';
import 'edit_profile_view.dart';
import 'workshop_manager_view.dart';

class AkunView extends StatelessWidget {
  const AkunView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AkunController>(
        init: AkunController(),
        builder: (AkunController akunController) => Stack(
              children: <Widget>[
                Container(
                  color: AppColors.blackBackground,
                  height: SizeConfig.horizontal(70),
                ),
                Center(
                  child: ResponsiveRowColumn(
                    layout: ResponsiveRowColumnType.COLUMN,
                    children: <ResponsiveRowColumnItem>[
                      const ResponsiveRowColumnItem(
                          child: SpaceSizer(vertical: 4)),
                      ResponsiveRowColumnItem(
                          child: ResponsiveRowColumn(
                        layout: ResponsiveRowColumnType.COLUMN,
                        children: <ResponsiveRowColumnItem>[
                          ResponsiveRowColumnItem(
                              child: ResponsiveRowColumn(
                            layout: ResponsiveRowColumnType.COLUMN,
                            children: <ResponsiveRowColumnItem>[
                              const ResponsiveRowColumnItem(
                                  child: UserPicture(
                                width: 40,
                                height: 40,
                                isUseBorder: true,
                              )),
                              const ResponsiveRowColumnItem(
                                  child: SpaceSizer(vertical: 1)),
                              ResponsiveRowColumnItem(
                                  child: ResponsiveRowColumn(
                                layout: ResponsiveRowColumnType.COLUMN,
                                children: <ResponsiveRowColumnItem>[
                                  ResponsiveRowColumnItem(
                                      child: ResponsiveRowColumn(
                                          layout:
                                              ResponsiveRowColumnType.COLUMN,
                                          children: <ResponsiveRowColumnItem>[
                                        ResponsiveRowColumnItem(
                                            child: Username(
                                          size: 5,
                                          color: AppColors.white,
                                        )),
                                      ])),
                                  const ResponsiveRowColumnItem(
                                      child: SpaceSizer(vertical: 1)),
                                  ResponsiveRowColumnItem(
                                      child: _verifiedEmailWrapper()),
                                  const ResponsiveRowColumnItem(
                                      child: SpaceSizer(vertical: 0.5)),
                                ],
                              )),
                            ],
                          )),
                        ],
                      )),
                      const ResponsiveRowColumnItem(
                          child: SpaceSizer(vertical: 6)),
                      ResponsiveRowColumnItem(
                          child: CustomDividerText(
                              title: 'Edit Profile',
                              onTap: () => Get.to(const EditProfileView()),
                              icon: Icons.edit)),
                      const ResponsiveRowColumnItem(
                          child: SpaceSizer(vertical: 2)),
                      ResponsiveRowColumnItem(
                          child: CustomDividerText(
                              icon: Icons.maps_home_work_outlined,
                              title: 'Workshop Manager',
                              onTap: () =>
                                  Get.to(const WorkShopManagerView()))),
                      const ResponsiveRowColumnItem(
                          child: SpaceSizer(vertical: 2)),
                      ResponsiveRowColumnItem(
                          child: CustomDividerText(
                              icon: Icons.home_repair_service_rounded,
                              title: 'Home Service Manager',
                              onTap: () => router.push('/homeservicemanager'))),
                      const ResponsiveRowColumnItem(
                          child: SpaceSizer(vertical: 2)),
                      // ResponsiveRowColumnItem(
                      //     child: CustomDividerText(
                      //         icon: Icons.question_mark_rounded,
                      //         title: 'Bantuan',
                      //         onTap: () => Get.to(const BantuanView()))),
                      const ResponsiveRowColumnItem(
                          child: SpaceSizer(vertical: 2)),
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
                ),
              ],
            ));
  }

  Container _verifiedEmailWrapper() {
    return Container(
      width: SizeConfig.horizontal(42),
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.horizontal(2),
        vertical: SizeConfig.horizontal(0.5),
      ),
      decoration: BoxDecoration(
          color: AppColors.greenDRT,
          borderRadius:
              BorderRadius.all(Radius.circular(SizeConfig.horizontal(4)))),
      child: ResponsiveRowColumn(
        layout: ResponsiveRowColumnType.ROW,
        children: <ResponsiveRowColumnItem>[
          ResponsiveRowColumnItem(
            child: InterTextView(
              value: 'Email terverifikasi',
              size: SizeConfig.safeBlockHorizontal * 3.5,
              fontWeight: FontWeight.bold,
              color: AppColors.greenSuccess,
            ),
          ),
          const ResponsiveRowColumnItem(child: SpaceSizer(horizontal: 1)),
          ResponsiveRowColumnItem(
              child: Container(
                  padding: EdgeInsets.all(SizeConfig.horizontal(1)),
                  decoration: BoxDecoration(
                      color: AppColors.greenSuccess,
                      borderRadius: BorderRadius.all(
                          Radius.circular(SizeConfig.horizontal(4)))),
                  child: Icon(
                    Icons.check,
                    color: AppColors.white,
                    size: SizeConfig.horizontal(4),
                  )))
        ],
      ),
    );
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
      width: SizeConfig.horizontal(90),
      height: SizeConfig.horizontal(13),
      decoration: BoxDecoration(
          color: AppColors.blackBackground,
          borderRadius:
              BorderRadius.all(Radius.circular(SizeConfig.horizontal(10)))),
      child: CustomRippleButton(
        onTap: onTap,
        child: ResponsiveRowColumn(
          layout: ResponsiveRowColumnType.ROW,
          rowMainAxisAlignment: MainAxisAlignment.center,
          rowPadding: EdgeInsets.symmetric(
            vertical: SizeConfig.horizontal(2),
            horizontal: SizeConfig.horizontal(5),
          ),
          children: <ResponsiveRowColumnItem>[
            ResponsiveRowColumnItem(
                child: icon == null
                    ? const SizedBox.shrink()
                    : Icon(
                        icon,
                        size: SizeConfig.horizontal(8),
                        color: AppColors.white,
                      )),
            const ResponsiveRowColumnItem(
                child: SpaceSizer(
              horizontal: 2,
            )),
            ResponsiveRowColumnItem(
                child: InterTextView(
                    value: title,
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                    size: SizeConfig.safeBlockHorizontal * (textSize ?? 4))),
            ResponsiveRowColumnItem(
                // ignore: use_if_null_to_convert_nulls_to_bools
                child: isCenter == true
                    ? const Spacer()
                    : const SizedBox.shrink()),
            ResponsiveRowColumnItem(
                child: useArrowIcon == false
                    ? const SizedBox.shrink()
                    : Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: AppColors.white,
                      ))
          ],
        ),
      ),
    );
  }
}
