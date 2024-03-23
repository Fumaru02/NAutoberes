import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/asset_list.dart';
import '../../../../core/utils/size_config.dart';
import '../../../widgets/custom/custom_flat_button.dart';
import '../../../widgets/custom/custom_text_field.dart';
import '../../../widgets/layouts/space_sizer.dart';
import '../../../widgets/text/inter_text_view.dart';
import '../forgot_password_view.dart';
import 'divider_login.dart';
import 'flip_card_button.dart';
import 'login_menu.dart';

class FrontCard extends StatelessWidget {
  const FrontCard({
    super.key,
    required this.email,
    required this.password,
    required this.angle,
  });
  final TextEditingController email;
  final TextEditingController password;
  final double angle;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.blueDark,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(SizeConfig.horizontal(8)),
          topRight: Radius.circular(SizeConfig.horizontal(8)),
        ),
      ),
      height: SizeConfig.vertical(70),
      width: SizeConfig.screenWidth,
      child: ResponsiveRowColumn(
        layout: ResponsiveRowColumnType.COLUMN,
        columnMainAxisAlignment: MainAxisAlignment.center,
        children: <ResponsiveRowColumnItem>[
          const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 1)),
          ResponsiveRowColumnItem(
              child: InterTextView(
            value: 'Welcome abroad!',
            fontWeight: FontWeight.bold,
            size: SizeConfig.safeBlockHorizontal * 7,
          )),
          const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 1)),
          ResponsiveRowColumnItem(
              child: InterTextView(
                  value: 'Please sign in to your account',
                  size: SizeConfig.safeBlockHorizontal * 3.5)),
          const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 3)),
          ResponsiveRowColumnItem(
              child: CustomTextField(
                  controller: email,
                  title: '',
                  hintText: 'Username/Email',
                  prefixIcon: Image.asset(AssetList.emailLogo))),
          const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 1)),
          ResponsiveRowColumnItem(
              child: CustomTextField(
                  controller: password,
                  title: '',
                  hintText: 'Password',
                  isPasswordField: true,
                  prefixIcon: Image.asset(AssetList.passwordLogo))),
          const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 3)),
          ResponsiveRowColumnItem(
              child: Padding(
                  padding: EdgeInsets.only(right: SizeConfig.horizontal(10)),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () => Get.to(const ForgotPasswordView()),
                          child: InterTextView(
                              size: SizeConfig.safeBlockHorizontal * 3.5,
                              value: 'Forgot your password?',
                              decorationColor: AppColors.white))))),
          ResponsiveRowColumnItem(
              child: CustomFlatButton(
                  backgroundColor: AppColors.white,
                  text: 'Sign In',
                  textColor: AppColors.blackBackground,
                  onTap: () {})),
          const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 5)),
          ResponsiveRowColumnItem(
              child: ResponsiveRowColumn(
            layout: ResponsiveRowColumnType.ROW,
            rowPadding:
                EdgeInsets.symmetric(horizontal: SizeConfig.horizontal(2)),
            rowMainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <ResponsiveRowColumnItem>[
              const ResponsiveRowColumnItem(child: DividerLogin()),
              ResponsiveRowColumnItem(
                  child: InterTextView(
                value: 'Or continue with',
                size: SizeConfig.safeBlockHorizontal * 3,
              )),
              const ResponsiveRowColumnItem(child: DividerLogin())
            ],
          )),
          const ResponsiveRowColumnItem(
              child: SpaceSizer(
            vertical: 2,
          )),
          const ResponsiveRowColumnItem(child: LoginMenu()),
          const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 4)),
          ResponsiveRowColumnItem(
              child: InterTextView(
            value: "Don't have an account?",
            size: SizeConfig.safeBlockHorizontal * 3.5,
          )),
          ResponsiveRowColumnItem(child: FlipCardButton(angle: angle))
        ],
      ),
    );
  }
}
