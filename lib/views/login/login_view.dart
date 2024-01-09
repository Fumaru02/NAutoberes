import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_row_column.dart';
import '../../controllers/authorize_controller.dart';
import '../../controllers/login_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/asset_list.dart';
import '../../utils/size_config.dart';
import '../sign_up/sign_up_view.dart';
import '../widgets/custom/custom_app_version.dart';
import '../widgets/custom/custom_flat_button.dart';
import '../widgets/custom/custom_text_field.dart';
import '../widgets/frame/frame_scaffold.dart';
import '../widgets/layouts/space_sizer.dart';
import '../widgets/logo/autoberes_logo.dart';
import '../widgets/text/roboto_text_view.dart';
import 'forgot_password_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthorizeController authorizeController =
        Get.put(AuthorizeController());
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            systemNavigationBarColor: AppColors.black,
            systemNavigationBarIconBrightness: Brightness.dark),
        child: GetBuilder<LoginController>(
          init: LoginController(),
          builder: (LoginController loginController) => FrameScaffold(
              heightBar: 0,
              elevation: 0,
              color: Platform.isIOS ? AppColors.black : null,
              statusBarColor: AppColors.black,
              colorScaffold: AppColors.blackBackground,
              statusBarBrightness: Brightness.light,
              view: ResponsiveRowColumn(
                layout: ResponsiveRowColumnType.COLUMN,
                columnPadding: EdgeInsets.only(left: SizeConfig.horizontal(5)),
                columnCrossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 3)),
                  const ResponsiveRowColumnItem(
                      child: Center(
                    child: AutoBeresLogo(
                      width: 30,
                      height: 30,
                    ),
                  )),
                  ResponsiveRowColumnItem(
                      child: RobotoTextView(
                    value: 'Login',
                    size: SizeConfig.safeBlockHorizontal * 8,
                    fontWeight: FontWeight.bold,
                  )),
                  const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 2)),
                  ResponsiveRowColumnItem(
                      child: CustomTextField(
                    controller: loginController.emailController,
                    title: 'Email',
                    hintText: 'Type Email',
                    prefixIcon: Image.asset(AssetList.emailLogo),
                  )),
                  const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 2)),
                  ResponsiveRowColumnItem(
                      child: CustomTextField(
                    controller: loginController.passwordController,
                    title: 'Password',
                    hintText: 'Type Password',
                    isPasswordField: true,
                    prefixIcon: Image.asset(AssetList.passwordLogo),
                  )),
                  ResponsiveRowColumnItem(
                      child: Padding(
                    padding: EdgeInsets.only(right: SizeConfig.horizontal(2)),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => Get.to(const ForgotPasswordView()),
                        child: RobotoTextView(
                          size: SizeConfig.safeBlockHorizontal * 3.5,
                          value: 'Forgot Password?',
                          textDecoration: TextDecoration.underline,
                          decorationColor: AppColors.white,
                        ),
                      ),
                    ),
                  )),
                  const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 2)),
                  ResponsiveRowColumnItem(
                    child: Obx(
                      () => CustomFlatButton(
                        textColor: AppColors.black,
                        text: 'Login',
                        loading: loginController.isTapped.value,
                        onTap: () =>
                            loginController.signInWithEmailAndPassword(),
                      ),
                    ),
                  ),
                  ResponsiveRowColumnItem(
                      child: Padding(
                    padding: EdgeInsets.only(
                        bottom: SizeConfig.horizontal(1),
                        right: SizeConfig.horizontal(2),
                        top: SizeConfig.horizontal(1)),
                    child: const Center(
                      child: RobotoTextView(
                        value: 'or',
                      ),
                    ),
                  )),
                  ResponsiveRowColumnItem(
                    child: CustomFlatButton(
                      text: 'Sign with Google',
                      backgroundColor: AppColors.greyButton,
                      image: AssetList.googleLogo,
                      onTap: () {},
                    ),
                  ),
                  ResponsiveRowColumnItem(
                      child: ResponsiveRowColumn(
                    layout: ResponsiveRowColumnType.ROW,
                    rowMainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ResponsiveRowColumnItem(
                        child: RobotoTextView(
                          size: SizeConfig.safeBlockHorizontal * 3.5,
                          value: "Don't have an account?",
                        ),
                      ),
                      ResponsiveRowColumnItem(
                          child: TextButton(
                        onPressed: () => Get.to(() => const SignUpView()),
                        child: RobotoTextView(
                          size: SizeConfig.safeBlockHorizontal * 3.5,
                          value: 'Sign Up',
                          fontWeight: FontWeight.bold,
                        ),
                      ))
                    ],
                  )),
                  const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 8)),
                  ResponsiveRowColumnItem(
                      child: Center(
                          child: CustomAppVersion(
                    authorizeController: authorizeController,
                  )))
                ],
              )),
        ));
  }
}
