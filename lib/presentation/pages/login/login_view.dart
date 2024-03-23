import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../controllers/login_controller.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/asset_list.dart';
import '../../../core/utils/size_config.dart';
import '../../bloc/login/login_bloc.dart';
import '../../cubit/login/login_cubit.dart';
import '../../widgets/custom/custom_flat_button.dart';
import '../../widgets/custom/custom_ripple_button.dart';
import '../../widgets/custom/custom_text_field.dart';
import '../../widgets/frame/frame_scaffold.dart';
import '../../widgets/layouts/space_sizer.dart';
import '../../widgets/logo/autoberes_logo.dart';
import '../../widgets/text/inter_text_view.dart';
import '../authorize/authorize_view.dart';
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
        color: AppColors.blackBackground,
        statusBarColor: AppColors.blackBackground,
        colorScaffold: AppColors.blackBackground,
        statusBarBrightness: Brightness.light,
        view: Stack(
          children: <Widget>[
            Center(
              child: ResponsiveRowColumn(
                layout: ResponsiveRowColumnType.COLUMN,
                children: <ResponsiveRowColumnItem>[
                  const ResponsiveRowColumnItem(
                      child: SpaceSizer(vertical: 12)),
                  const ResponsiveRowColumnItem(
                      child: Hero(tag: 'autoberes', child: AutoBeresLogo())),
                  const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 7)),
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
                    backgroundColor: AppColors.white,
                    textColor: AppColors.blackBackground,
                    onTap: () {
                      context.read<LoginCubit>().isTappedAnimation();
                    },
                  )),
                ],
              ),
            ),
            ResponsiveRowColumnItem(
                child: BlocBuilder<LoginCubit, LoginCubitState>(
              builder: (BuildContext ctx, LoginCubitState state) {
                return AnimatedPositioned(
                    curve: Curves.fastOutSlowIn,
                    bottom:
                        SizeConfig.horizontal(state.tappedAnimation ? 0 : -200),
                    duration: const Duration(milliseconds: 300),
                    child: cardFlipper(state, ctx));
              },
            ))
          ],
        ),
      ),
    );
  }

  Widget cardFlipper(LoginCubitState state, BuildContext context) {
    return TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: state.angle),
        duration: const Duration(seconds: 1),
        builder: (BuildContext _, double value, Widget? child) {
          context.watch<LoginCubit>().isFrontCard(value);
          return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(value),
              child: state.isFront ? const FrontCard() : Container()

              // backCard(loginController, context),
              );
        });
  }

  Widget backCard(LoginController loginController, BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()..rotateY(pi),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.blueDark,
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
              child: Obx(
                () => CustomFlatButton(
                  backgroundColor: AppColors.white,
                  textColor: AppColors.blackBackground,
                  text: 'Continue',
                  loading: loginController.isTapped.value,
                  onTap: () => showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        termsAndCondition(loginController, context),
                  ),
                ),
              ),
            ),
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

  Dialog termsAndCondition(
      LoginController loginController, BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(SizeConfig.horizontal(2)))),
      insetAnimationCurve: Curves.bounceIn,
      backgroundColor: AppColors.blackBackground,
      child: SizedBox(
        height: SizeConfig.horizontal(150),
        width: SizeConfig.horizontal(180),
        child: RawScrollbar(
          thumbColor: AppColors.white,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(SizeConfig.horizontal(4)))),
          trackVisibility: true,
          child: SingleChildScrollView(
            child: ResponsiveRowColumn(
              columnPadding: EdgeInsets.all(SizeConfig.horizontal(4)),
              layout: ResponsiveRowColumnType.COLUMN,
              children: <ResponsiveRowColumnItem>[
                // ResponsiveRowColumnItem(
                //     child: CustomBorderedContainer(
                //         useShadow: false,
                //         color: AppColors.blueDark,
                //         child: CustomHtmlWrapper(
                //             data: authorizeController.termsOfUse.value))),
                const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 2)),
                ResponsiveRowColumnItem(
                    child: Obx(
                  () => Row(
                    children: <Widget>[
                      Checkbox(
                          side: BorderSide(
                              width: SizeConfig.horizontal(0.7),
                              color: AppColors.white),
                          value: loginController.isChecked.value,
                          onChanged: (bool? v0) {
                            loginController.isChecked.value = v0!;
                          }),
                      SizedBox(
                          width: SizeConfig.horizontal(55),
                          child: RichText(
                            text: TextSpan(
                              text:
                                  'Saya Setuju membagikan data diri saya kepihak AutoBeres untuk tujuan komersial ',
                              children: <InlineSpan>[
                                const TextSpan(
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                    text: 'Terms And Condition'),
                                const TextSpan(
                                  text: ' and ',
                                ),
                                TextSpan(
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.underline),
                                  text: 'Privacy Policy',
                                  recognizer:
                                      loginController.privacyPolicyRecognizer
                                        ..onTap = () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                privacyPolicy(loginController),
                                          );
                                        },
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                )),
                const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 1.5)),
                ResponsiveRowColumnItem(
                    child: Obx(
                  () => loginController.isChecked.isFalse
                      ? const SizedBox.shrink()
                      : CustomFlatButton(
                          backgroundColor: AppColors.white,
                          textColor: AppColors.blackBackground,
                          height: 5,
                          text: 'I Agree',
                          onTap: () {}),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Dialog privacyPolicy(LoginController loginController) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(SizeConfig.horizontal(2)))),
      insetAnimationCurve: Curves.bounceIn,
      backgroundColor: AppColors.blackBackground,
      child: SizedBox(
        height: SizeConfig.horizontal(120),
        width: SizeConfig.horizontal(170),
        child: RawScrollbar(
          thumbColor: AppColors.white,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(SizeConfig.horizontal(4)))),
          trackVisibility: true,
          child: SingleChildScrollView(
            child: ResponsiveRowColumn(
              columnPadding: EdgeInsets.all(SizeConfig.horizontal(4)),
              layout: ResponsiveRowColumnType.COLUMN,
              children: <ResponsiveRowColumnItem>[
                // ResponsiveRowColumnItem(
                //     child: CustomBorderedContainer(
                //         useShadow: false,
                //         color: AppColors.blueDark,
                //         child: CustomHtmlWrapper(
                //             data: authorizeController.privacyPolicy.value))),
                const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 1.5)),
                ResponsiveRowColumnItem(
                  child: CustomFlatButton(
                      backgroundColor: AppColors.white,
                      textColor: AppColors.blackBackground,
                      height: 5,
                      text: 'Agree',
                      onTap: () {
                        loginController.isChecked.value = true;
                        Get.back();
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FrontCard extends StatefulWidget {
  const FrontCard({
    super.key,
  });

  @override
  State<FrontCard> createState() => _FrontCardState();
}

final TextEditingController email = TextEditingController();
final TextEditingController password = TextEditingController();

class _FrontCardState extends State<FrontCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.blueDark,
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
          ResponsiveRowColumnItem(
              child: ResponsiveRowColumn(
            layout: ResponsiveRowColumnType.ROW,
            rowPadding:
                EdgeInsets.symmetric(horizontal: SizeConfig.horizontal(1)),
            rowMainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <ResponsiveRowColumnItem>[
              ResponsiveRowColumnItem(
                  child: BlocListener<LoginBloc, LoginState>(
                listener: (BuildContext context, LoginState state) {},
                child: CustomBorderedButton(
                  image: AssetList.googleLogo,
                  ontap: () => BlocProvider.of<LoginBloc>(context)
                      .add(SignInWithGoogle()),
                ),
              )),
              // ResponsiveRowColumnItem(
              //     child: CustomBorderedButton(
              //   image: AssetList.appleLogo,
              //   ontap: () => loginController.signInWithGoogle(),
              // )),
              // ResponsiveRowColumnItem(
              //     child: CustomBorderedButton(
              //   image: AssetList.facebookLogo,
              //   ontap: () => loginController.signInWithGoogle(),
              // ))
            ],
          )),
          const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 4)),
          ResponsiveRowColumnItem(
              child: InterTextView(
            value: "Don't have an account?",
            size: SizeConfig.safeBlockHorizontal * 3.5,
          )),
          // ResponsiveRowColumnItem(
          //     child: CustomRippleButton(
          //         onTap: () => loginController.flipped(),
          //         child: InterTextView(
          //             size: SizeConfig.safeBlockHorizontal * 3.5,
          //             value: 'Register',
          //             fontWeight: FontWeight.bold)))
        ],
      ),
    );
  }
}
