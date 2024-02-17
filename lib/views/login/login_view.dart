import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_row_column.dart';

import '../../controllers/login_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/asset_list.dart';
import '../../utils/enums.dart';
import '../../utils/size_config.dart';
import '../authorize/authorize_view.dart';
import '../widgets/custom/custom_flat_button.dart';
import '../widgets/custom/custom_ripple_button.dart';
import '../widgets/custom/custom_text_field.dart';
import '../widgets/frame/frame_scaffold.dart';
import '../widgets/layouts/space_sizer.dart';
import '../widgets/logo/autoberes_logo.dart';
import '../widgets/text/inter_text_view.dart';
import 'forgot_password_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            systemNavigationBarColor: AppColors.black,
            systemNavigationBarIconBrightness: Brightness.dark),
        child: FrameScaffold(
            heightBar: 0,
            elevation: 0,
            color: Platform.isIOS ? AppColors.black : null,
            statusBarColor: AppColors.black,
            colorScaffold: AppColors.blackBackground,
            statusBarBrightness: Brightness.light,
            view: Container(
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 46, 43, 43),
                    image: DecorationImage(
                        image: AssetImage(AssetList.background),
                        fit: BoxFit.fill)),
                child: GetBuilder<LoginController>(
                  init: LoginController(),
                  builder: (LoginController loginController) => Stack(
                    children: <Widget>[
                      Center(
                        child: ResponsiveRowColumn(
                          layout: ResponsiveRowColumnType.COLUMN,
                          children: <ResponsiveRowColumnItem>[
                            const ResponsiveRowColumnItem(
                                child: SpaceSizer(vertical: 12)),
                            ResponsiveRowColumnItem(
                                child: Obx(() => Hero(
                                    tag: authorizeController.tagHero.value,
                                    child: const AutoBeresLogo()))),
                            const ResponsiveRowColumnItem(
                                child: SpaceSizer(vertical: 7)),
                            ResponsiveRowColumnItem(
                                child: InterTextView(
                                    value: 'Welcome',
                                    size: SizeConfig.safeBlockHorizontal * 4.5,
                                    fontWeight: FontWeight.bold)),
                            ResponsiveRowColumnItem(
                                child: InterTextView(
                                    value: 'Nice to see you',
                                    size: SizeConfig.safeBlockHorizontal * 3.5,
                                    fontWeight: FontWeight.w300)),
                            const ResponsiveRowColumnItem(
                                child: SpaceSizer(vertical: 35)),
                            ResponsiveRowColumnItem(
                                child: CustomFlatButton(
                              text: 'Continue',
                              onTap: () {
                                loginController.tapAnimation.value =
                                    !loginController.tapAnimation.value;
                              },
                            )),
                          ],
                        ),
                      ),
                      ResponsiveRowColumnItem(
                          child: Obx(
                        () => AnimatedPositioned(
                            curve: Curves.fastOutSlowIn,
                            bottom: SizeConfig.horizontal(
                                loginController.tapAnimation.isTrue ? 0 : -200),
                            duration: const Duration(milliseconds: 300),
                            child: cardFlipper(loginController)),
                      ))
                    ],
                  ),
                ))));
  }

  Widget cardFlipper(LoginController loginController) {
    return TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: loginController.angle.value),
        duration: const Duration(seconds: 1),
        builder: (BuildContext context, double value, Widget? child) {
          if (value >= (pi / 2)) {
            loginController.isFront.value = false;
          } else {
            loginController.isFront.value = true;
          }
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(value),
            child: loginController.isFront.isTrue
                ? frontCard(loginController)
                : backCard(loginController, context),
          );
        });
  }

  Widget backCard(LoginController loginController, BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()..rotateY(pi),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.greyBackground,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        height: SizeConfig.vertical(65),
        width: SizeConfig.screenWidth,
        child: ResponsiveRowColumn(
          layout: ResponsiveRowColumnType.COLUMN,
          columnPadding:
              EdgeInsets.symmetric(vertical: SizeConfig.horizontal(10)),
          columnMainAxisAlignment: MainAxisAlignment.center,
          children: <ResponsiveRowColumnItem>[
            const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 2)),
            ResponsiveRowColumnItem(
                child: InterTextView(
                    value: 'Sign Up',
                    fontWeight: FontWeight.bold,
                    size: SizeConfig.safeBlockHorizontal * 6.5)),
            const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 1)),
            ResponsiveRowColumnItem(
                child: InterTextView(
                    value: 'Please register your account',
                    size: SizeConfig.safeBlockHorizontal * 3.5)),
            const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 2)),
            ResponsiveRowColumnItem(
              child: TabBar(
                  indicatorColor: AppColors.white,
                  controller: loginController.tabController,
                  labelStyle: InterStyle().labelStyle(AppColors.white),
                  padding: EdgeInsets.all(SizeConfig.horizontal(2)),
                  indicatorPadding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.horizontal(8)),
                  tabs: <Widget>[
                    InterTextView(
                        value: 'E-mail',
                        fontWeight: FontWeight.bold,
                        size: SizeConfig.safeBlockHorizontal * 4),
                    InterTextView(
                        value: 'No. Hp',
                        fontWeight: FontWeight.bold,
                        size: SizeConfig.safeBlockHorizontal * 4),
                  ]),
            ),
            ResponsiveRowColumnItem(
                child: Expanded(
              child: TabBarView(
                controller: loginController.tabController,
                children: <Widget>[
                  Center(
                      child: CustomTextField(
                          controller: loginController.emailController,
                          title: '',
                          hintText: 'Username/Email',
                          prefixIcon: Image.asset(AssetList.emailLogo))),
                  Center(
                      child: CustomTextField(
                          controller: loginController.emailController,
                          title: '',
                          hintText: 'Phone number',
                          prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.horizontal(2)),
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Image.asset(AssetList.indonesian, scale: 1.5),
                                  const SpaceSizer(horizontal: 1),
                                  InterTextView(
                                      value: '+62',
                                      color: AppColors.black,
                                      size:
                                          SizeConfig.safeBlockHorizontal * 3.5)
                                ]),
                          ))),
                ],
              ),
            )),
            ResponsiveRowColumnItem(
                child: Obx(() => CustomFlatButton(
                    text: 'Continue',
                    loading: loginController.isTapped.value,
                    onTap: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          SizeConfig.horizontal(2)))),
                              insetAnimationCurve: Curves.bounceIn,
                              backgroundColor: AppColors.greyBackground,
                              child: SizedBox(
                                height: SizeConfig.horizontal(120),
                                width: SizeConfig.horizontal(170),
                                child: RawScrollbar(
                                  thumbColor: AppColors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              SizeConfig.horizontal(4)))),
                                  trackVisibility: true,
                                  child: SingleChildScrollView(
                                    child: ResponsiveRowColumn(
                                      columnPadding: EdgeInsets.all(
                                          SizeConfig.horizontal(4)),
                                      layout: ResponsiveRowColumnType.COLUMN,
                                      children: <ResponsiveRowColumnItem>[
                                        ResponsiveRowColumnItem(
                                            child: InterTextView(
                                                value: 'Terms of Use\n',
                                                fontWeight: FontWeight.bold,
                                                size: SizeConfig
                                                        .safeBlockHorizontal *
                                                    6)),
                                        ResponsiveRowColumnItem(
                                            child: InterTextView(
                                                alignText:
                                                    AlignTextType.justify,
                                                size: SizeConfig
                                                        .safeBlockHorizontal *
                                                    4,
                                                value: loginController
                                                    .termsOfUse.value)),
                                        ResponsiveRowColumnItem(
                                            child: Obx(
                                          () => Row(
                                            children: <Widget>[
                                              Checkbox(
                                                  side: BorderSide(
                                                      width:
                                                          SizeConfig.horizontal(
                                                              0.7),
                                                      color: AppColors.white),
                                                  value: loginController
                                                      .isChecked.value,
                                                  onChanged: (bool? v0) {
                                                    loginController
                                                        .isChecked.value = v0!;
                                                  }),
                                              SizedBox(
                                                width:
                                                    SizeConfig.horizontal(55),
                                                child: InterTextView(
                                                  value:
                                                      'I here by agree to the Terms and Conditions and Privacy Policy of\nPT. Autoberes Teknologi Indonesia.',
                                                  size: SizeConfig
                                                          .safeBlockHorizontal *
                                                      3,
                                                ),
                                              )
                                            ],
                                          ),
                                        )),
                                        const ResponsiveRowColumnItem(
                                            child: SpaceSizer(vertical: 1)),
                                        ResponsiveRowColumnItem(
                                            child: Obx(
                                          () =>
                                              loginController.isChecked.isFalse
                                                  ? const SizedBox.shrink()
                                                  : CustomFlatButton(
                                                      height: 5,
                                                      text: 'Continue',
                                                      onTap: () {}),
                                        ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ))))),
            const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 5)),
            ResponsiveRowColumnItem(
              child: ResponsiveRowColumn(
                layout: ResponsiveRowColumnType.ROW,
                rowPadding:
                    EdgeInsets.symmetric(horizontal: SizeConfig.horizontal(8)),
                rowMainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <ResponsiveRowColumnItem>[
                  const ResponsiveRowColumnItem(child: DividerLogin()),
                  ResponsiveRowColumnItem(
                      child: InterTextView(
                          value: 'Or continue with',
                          size: SizeConfig.safeBlockHorizontal * 3)),
                  const ResponsiveRowColumnItem(child: DividerLogin())
                ],
              ),
            ),
            const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 3)),
            ResponsiveRowColumnItem(
              child: ResponsiveRowColumn(
                layout: ResponsiveRowColumnType.ROW,
                rowMainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <ResponsiveRowColumnItem>[
                  ResponsiveRowColumnItem(
                      child: CustomBorderedButton(
                          image: AssetList.googleLogo,
                          ontap: () => loginController.signInWithGoogle())),
                  ResponsiveRowColumnItem(
                      child: CustomBorderedButton(
                          image: AssetList.appleLogo,
                          ontap: () => loginController.signInWithGoogle())),
                  ResponsiveRowColumnItem(
                      child: CustomBorderedButton(
                          image: AssetList.facebookLogo,
                          ontap: () => loginController.signInWithGoogle()))
                ],
              ),
            ),
            const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 2)),
            ResponsiveRowColumnItem(
                child: InterTextView(
                    value: 'have an account?',
                    size: SizeConfig.safeBlockHorizontal * 3.5)),
            const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 2)),
            ResponsiveRowColumnItem(
                child: CustomRippleButton(
                    onTap: () => loginController.flipped(),
                    child: InterTextView(
                        size: SizeConfig.safeBlockHorizontal * 3.5,
                        value: 'Sign In',
                        fontWeight: FontWeight.bold)))
          ],
        ),
      ),
    );
  }

  Widget frontCard(LoginController loginController) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.greyBackground,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
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
                  controller: loginController.emailController,
                  title: '',
                  hintText: 'Username/Email',
                  prefixIcon: Image.asset(AssetList.emailLogo))),
          const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 1)),
          ResponsiveRowColumnItem(
              child: CustomTextField(
                  controller: loginController.passwordController,
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
              child: Obx(() => CustomFlatButton(
                  backgroundColor: AppColors.grey,
                  text: 'Sign In',
                  loading: loginController.isTapped.value,
                  onTap: () => loginController.signInWithEmailAndPassword()))),
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
          ResponsiveRowColumnItem(
              child: ResponsiveRowColumn(
            layout: ResponsiveRowColumnType.ROW,
            rowPadding:
                EdgeInsets.symmetric(horizontal: SizeConfig.horizontal(1)),
            rowMainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <ResponsiveRowColumnItem>[
              ResponsiveRowColumnItem(
                  child: CustomBorderedButton(
                image: AssetList.googleLogo,
                ontap: () => loginController.signInWithGoogle(),
              )),
              ResponsiveRowColumnItem(
                  child: CustomBorderedButton(
                image: AssetList.appleLogo,
                ontap: () => loginController.signInWithGoogle(),
              )),
              ResponsiveRowColumnItem(
                  child: CustomBorderedButton(
                image: AssetList.facebookLogo,
                ontap: () => loginController.signInWithGoogle(),
              ))
            ],
          )),
          const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 4)),
          ResponsiveRowColumnItem(
              child: InterTextView(
            value: "Don't have an account?",
            size: SizeConfig.safeBlockHorizontal * 3.5,
          )),
          ResponsiveRowColumnItem(
              child: CustomRippleButton(
                  onTap: () => loginController.flipped(),
                  child: InterTextView(
                      size: SizeConfig.safeBlockHorizontal * 3.5,
                      value: 'Register',
                      fontWeight: FontWeight.bold)))
        ],
      ),
    );
  }
}

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:responsive_framework/responsive_row_column.dart';
// import '../../controllers/authorize_controller.dart';
// import '../../controllers/login_controller.dart';
// import '../../utils/app_colors.dart';
// import '../../utils/asset_list.dart';
// import '../../utils/size_config.dart';
// import '../sign_up/sign_up_view.dart';
// import '../widgets/custom/custom_app_version.dart';
// import '../widgets/custom/custom_flat_button.dart';
// import '../widgets/custom/custom_text_field.dart';
// import '../widgets/frame/frame_scaffold.dart';
// import '../widgets/layouts/space_sizer.dart';
// import '../widgets/logo/autoberes_logo.dart';
// import '../widgets/text/inter_text_view.dart';
// import 'forgot_password_view.dart';

// class LoginView extends StatelessWidget {
//   const LoginView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final AuthorizeController authorizeController =
//         Get.put(AuthorizeController());
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//         value: SystemUiOverlayStyle(
//             systemNavigationBarColor: AppColors.black,
//             systemNavigationBarIconBrightness: Brightness.dark),
//         child: GetBuilder<LoginController>(
//           init: LoginController(),
//           builder: (LoginController loginController) => FrameScaffold(
//               heightBar: 0,
//               elevation: 0,
//               color: Platform.isIOS ? AppColors.black : null,
//               statusBarColor: AppColors.black,
//               colorScaffold: AppColors.blackBackground,
//               statusBarBrightness: Brightness.light,
//               view: ResponsiveRowColumn(
//                 layout: ResponsiveRowColumnType.COLUMN,
//                 columnPadding: EdgeInsets.only(left: SizeConfig.horizontal(5)),
//                 columnCrossAxisAlignment: CrossAxisAlignment.start,
//                 children: <ResponsiveRowColumnItem>[
//                   const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 3)),
//                   const ResponsiveRowColumnItem(
//                       child: Center(
//                           child: Hero(
//                               tag: 'auth',
//                               child: AutoBeresLogo(width: 30, height: 30)))),
//                   ResponsiveRowColumnItem(
//                       child: InterTextView(
//                           value: 'Login',
//                           size: SizeConfig.safeBlockHorizontal * 8,
//                           fontWeight: FontWeight.bold)),
//                   const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 2)),
//                   ResponsiveRowColumnItem(
//                       child: CustomTextField(
//                           controller: loginController.emailController,
//                           title: 'Email',
//                           hintText: 'Type Email',
//                           prefixIcon: Image.asset(AssetList.emailLogo))),
//                   const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 2)),
//                   ResponsiveRowColumnItem(
//                       child: CustomTextField(
//                           controller: loginController.passwordController,
//                           title: 'Password',
//                           hintText: 'Type Password',
//                           isPasswordField: true,
//                           prefixIcon: Image.asset(AssetList.passwordLogo))),
//                   ResponsiveRowColumnItem(
//                       child: Padding(
//                           padding:
//                               EdgeInsets.only(right: SizeConfig.horizontal(2)),
//                           child: Align(
//                               alignment: Alignment.centerRight,
//                               child: TextButton(
//                                   onPressed: () =>
//                                       Get.to(const ForgotPasswordView()),
//                                   child: InterTextView(
//                                       size:
//                                           SizeConfig.safeBlockHorizontal * 3.5,
//                                       value: 'Forgot Password?',
//                                       textDecoration: TextDecoration.underline,
//                                       decorationColor: AppColors.white))))),
//                   const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 2)),
//                   ResponsiveRowColumnItem(
//                       child: Obx(() => CustomFlatButton(
//                           textColor: AppColors.black,
//                           text: 'Login',
//                           loading: loginController.isTapped.value,
//                           onTap: () =>
//                               loginController.signInWithEmailAndPassword()))),
//                   ResponsiveRowColumnItem(
//                       child: Padding(
//                           padding: EdgeInsets.only(
//                               bottom: SizeConfig.horizontal(1),
//                               right: SizeConfig.horizontal(2),
//                               top: SizeConfig.horizontal(1)),
//                           child:
//                               const Center(child: InterTextView(value: 'or')))),
//                   ResponsiveRowColumnItem(
//                       child: Obx(() => CustomFlatButton(
//                           text: 'Sign with Google',
//                           backgroundColor: AppColors.greyButton,
//                           image: AssetList.googleLogo,
//                           loading: loginController.isTapped.value,
//                           onTap: () => loginController.signInWithGoogle()))),
//                   ResponsiveRowColumnItem(
//                       child: ResponsiveRowColumn(
//                     layout: ResponsiveRowColumnType.ROW,
//                     rowMainAxisAlignment: MainAxisAlignment.center,
//                     children: <ResponsiveRowColumnItem>[
//                       ResponsiveRowColumnItem(
//                           child: InterTextView(
//                               size: SizeConfig.safeBlockHorizontal * 3.5,
//                               value: "Don't have an account?")),
//                       ResponsiveRowColumnItem(
//                           child: TextButton(
//                               onPressed: () => Get.to(() => const SignUpView()),
//                               child: InterTextView(
//                                   size: SizeConfig.safeBlockHorizontal * 3.5,
//                                   value: 'Sign Up',
//                                   fontWeight: FontWeight.bold)))
//                     ],
//                   )),
//                   const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 8)),
//                   ResponsiveRowColumnItem(
//                       child: Center(
//                           child: CustomAppVersion(
//                               authorizeController: authorizeController)))
//                 ],
//               )),
//         ));
//   }
// }
