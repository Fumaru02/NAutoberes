import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_row_column.dart';

import '../../controllers/sign_up_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/enums.dart';
import '../../utils/size_config.dart';
import '../login/login_view.dart';
import '../widgets/custom/custom_flat_button.dart';
import '../widgets/custom/custom_text_field.dart';
import '../widgets/frame/frame_scaffold.dart';
import '../widgets/layouts/space_sizer.dart';
import '../widgets/logo/autoberes_logo.dart';
import '../widgets/text/roboto_text_view.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpController signUpController = Get.put(SignUpController());
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
            view: SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: ResponsiveRowColumn(
                    layout: ResponsiveRowColumnType.COLUMN,
                    columnPadding:
                        EdgeInsets.only(left: SizeConfig.horizontal(2)),
                    children: <ResponsiveRowColumnItem>[
                      ResponsiveRowColumnItem(
                          child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () {
                            Get.back();
                            signUpController.clearTextController();
                          },
                          icon: Icon(
                            Icons.close,
                            size: SizeConfig.horizontal(12),
                            color: AppColors.white,
                          ),
                        ),
                      )),
                      const ResponsiveRowColumnItem(
                          child: AutoBeresLogo(
                        width: 38,
                        height: 40,
                      )),
                      const ResponsiveRowColumnItem(
                          child: RobotoTextView(
                        value:
                            'Ayo daftarkan diri\nAnda sekarang dan nikmati\nfitur-fitur unggulan dari\naplikasi kami',
                        alignText: AlignTextType.center,
                      )),
                      ResponsiveRowColumnItem(
                          child: CustomTextField(
                              textInputAction: TextInputAction.done,
                              controller: signUpController.fullnameController,
                              title: 'Fullname*',
                              hintText: 'Type Fullname')),
                      ResponsiveRowColumnItem(
                          child: CustomTextField(
                              textInputAction: TextInputAction.done,
                              controller: signUpController.emailController,
                              title: 'Email*',
                              hintText: 'Type Email')),
                      ResponsiveRowColumnItem(
                          child: CustomTextField(
                              textInputAction: TextInputAction.done,
                              isPasswordField: true,
                              controller: signUpController.passwordController,
                              title: 'Password*',
                              hintText: 'Type Password')),
                      ResponsiveRowColumnItem(
                          child: CustomTextField(
                              textInputAction: TextInputAction.done,
                              isPasswordField: true,
                              controller:
                                  signUpController.confirmPasswordController,
                              title: 'Confirm Password*',
                              hintText: 'Re-type Password')),
                      const ResponsiveRowColumnItem(
                          child: SpaceSizer(
                        vertical: 2,
                      )),
                      ResponsiveRowColumnItem(
                          child: CustomFlatButton(
                              text: 'Confirm',
                              textColor: AppColors.black,
                              onTap: () async {
                                final bool isRegister = await signUpController
                                    .signUpWithEmailAndPassword();
                                if (isRegister == true) {
                                  if (!context.mounted) {
                                    return;
                                  }
                                  showDialog(
                                    context: context,
                                    builder: (_) => Dialog(
                                        backgroundColor:
                                            AppColors.blackBackground,
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              SizeConfig.horizontal(4)),
                                          child: ResponsiveRowColumn(
                                            layout:
                                                ResponsiveRowColumnType.COLUMN,
                                            columnMainAxisSize:
                                                MainAxisSize.min,
                                            children: <ResponsiveRowColumnItem>[
                                              const ResponsiveRowColumnItem(
                                                  child: AutoBeresLogo(
                                                height: 20,
                                                width: 19,
                                              )),
                                              ResponsiveRowColumnItem(
                                                  child: RobotoTextView(
                                                value:
                                                    'Daftar Berhasil\nKami telah mengirim link email verifikasi ke ${signUpController.emailController.text} mohon untuk di klik',
                                                fontWeight: FontWeight.bold,
                                                alignText: AlignTextType.center,
                                              )),
                                              const ResponsiveRowColumnItem(
                                                  child: SpaceSizer(
                                                vertical: 2,
                                              )),
                                              ResponsiveRowColumnItem(
                                                  child: ResponsiveRowColumn(
                                                layout:
                                                    ResponsiveRowColumnType.ROW,
                                                rowMainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <ResponsiveRowColumnItem>[
                                                  ResponsiveRowColumnItem(
                                                      child: CustomFlatButton(
                                                          width: SizeConfig
                                                              .horizontal(30),
                                                          text: 'Oke',
                                                          textColor: AppColors
                                                              .blackBackground,
                                                          onTap: () {
                                                            Get.off(() =>
                                                                const LoginView());
                                                            signUpController
                                                                .clearTextController();
                                                          }))
                                                ],
                                              ))
                                            ],
                                          ),
                                        )),
                                  );
                                }
                                log(isRegister.toString());
                              }))
                    ]))));
  }
}
