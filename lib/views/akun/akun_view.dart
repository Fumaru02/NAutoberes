import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_row_column.dart';

import '../../controllers/akun_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/size_config.dart';
import '../widgets/custom/custom_confirmation_dialog.dart';
import '../widgets/custom/custom_ripple_button.dart';
import '../widgets/text/roboto_text_view.dart';
import '../widgets/user/user_info.dart';
import 'edit_profile_view.dart';

class AkunView extends StatelessWidget {
  const AkunView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AkunController>(
        init: AkunController(),
        builder: (AkunController akunController) => ResponsiveRowColumn(
              layout: ResponsiveRowColumnType.COLUMN,
              children: <ResponsiveRowColumnItem>[
                ResponsiveRowColumnItem(
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          vertical: SizeConfig.horizontal(5)),
                      decoration: BoxDecoration(
                          color: AppColors.blackBackground,
                          borderRadius: BorderRadius.all(
                              Radius.circular(SizeConfig.horizontal(5)))),
                      width: SizeConfig.horizontal(80),
                      height: SizeConfig.horizontal(50),
                      child: ResponsiveRowColumn(
                        layout: ResponsiveRowColumnType.COLUMN,
                        columnCrossAxisAlignment: CrossAxisAlignment.start,
                        children: <ResponsiveRowColumnItem>[
                          ResponsiveRowColumnItem(
                              child: ResponsiveRowColumn(
                            layout: ResponsiveRowColumnType.ROW,
                            rowSpacing: 8,
                            children: <ResponsiveRowColumnItem>[
                              ResponsiveRowColumnItem(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: SizeConfig.horizontal(4),
                                          vertical: SizeConfig.horizontal(2)),
                                      child: const UserPicture(size: 40))),
                              const ResponsiveRowColumnItem(
                                  child: ResponsiveRowColumn(
                                layout: ResponsiveRowColumnType.COLUMN,
                                columnCrossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: <ResponsiveRowColumnItem>[
                                  ResponsiveRowColumnItem(
                                      child: Username(size: 6)),
                                  ResponsiveRowColumnItem(
                                      child: UserStatus(size: 4))
                                ],
                              )),
                            ],
                          )),
                          const ResponsiveRowColumnItem(child: Divider()),
                          ResponsiveRowColumnItem(
                              child: RobotoTextView(
                            size: SizeConfig.safeBlockHorizontal * 4,
                            value: 'Follower',
                          )),
                          ResponsiveRowColumnItem(
                              child: RobotoTextView(
                            size: SizeConfig.safeBlockHorizontal * 4,
                            value: 'Following',
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
                ResponsiveRowColumnItem(
                    child: CustomDividerText(
                        title: 'Edit Profile',
                        onTap: () => Get.to(const EditProfileView()),
                        icon: Icons.edit)),
                ResponsiveRowColumnItem(
                    child: CustomDividerText(
                  icon: Icons.maps_home_work_outlined,
                  title: 'Workshop Manager',
                  onTap: () {},
                )),
                ResponsiveRowColumnItem(
                    child: CustomDividerText(
                  icon: Icons.home_repair_service_rounded,
                  title: 'Service Manager',
                  onTap: () {},
                )),
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
                        width: 50,
                      ),
                    );
                  },
                ))
              ],
            ));
  }
}

class CustomDividerText extends StatelessWidget {
  const CustomDividerText({
    Key? key,
    required this.title,
    this.textSize,
    this.iconSize,
    required this.onTap,
    required this.icon,
    this.useArrowIcon = true,
    this.isCenter = true,
    this.iconColor,
  }) : super(key: key);

  final String title;
  final double? textSize;
  final double? iconSize;
  final Function() onTap;
  final IconData icon;
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
                child: Icon(
              icon,
              size: iconSize,
              color: iconColor,
            )),
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
