import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../controllers/login_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/asset_list.dart';
import '../../utils/enums.dart';
import '../../utils/size_config.dart';
import '../widgets/custom/custom_flat_button.dart';
import '../widgets/custom/custom_text_field.dart';
import '../widgets/frame/frame_scaffold.dart';
import '../widgets/layouts/space_sizer.dart';
import '../widgets/logo/autoberes_logo.dart';
import '../widgets/text/inter_text_view.dart';
import 'login_view.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            systemNavigationBarColor: AppColors.black,
            systemNavigationBarIconBrightness: Brightness.dark),
        child: GetBuilder<LoginController>(
          init: LoginController(),
          builder: (LoginController controller) => FrameScaffold(
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
                                      controller.emailController.clear();
                                    },
                                    icon: Icon(Icons.close,
                                        size: SizeConfig.horizontal(12),
                                        color: AppColors.white)))),
                        const ResponsiveRowColumnItem(
                            child: AutoBeresLogo(width: 38, height: 40)),
                        ResponsiveRowColumnItem(
                            child: SizedBox(
                                height: SizeConfig.horizontal(20),
                                width: SizeConfig.horizontal(65),
                                child: const InterTextView(
                                    value:
                                        'Masukkan email, kami akan mengirimkan link untuk reset password anda',
                                    alignText: AlignTextType.center))),
                        ResponsiveRowColumnItem(
                            child: CustomTextField(
                                controller: controller.emailController,
                                title: 'Email',
                                hintText: 'Type Email',
                                prefixIcon: Image.asset(AssetList.emailLogo))),
                        ResponsiveRowColumnItem(
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: SizeConfig.horizontal(3)),
                            child: CustomFlatButton(
                                text: 'Confirm',
                                textColor: AppColors.black,
                                onTap: () async {
                                  final bool isReset =
                                      await controller.resetPassword();
                                  if (isReset == true) {
                                    if (!context.mounted) {
                                      return;
                                    }
                                    showDialog(
                                        context: context,
                                        builder: (_) =>
                                            successDialog(controller));
                                  }
                                }),
                          ),
                        )
                      ]))),
        ));
  }

  Dialog successDialog(LoginController controller) {
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
              ResponsiveRowColumnItem(
                  child: InterTextView(
                      value:
                          'Reset Berhasil\nKami telah mengirim link email reset password ke ${controller.emailController.text} mohon untuk dicheck inbox/spam',
                      fontWeight: FontWeight.bold,
                      alignText: AlignTextType.center)),
              const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 2)),
              ResponsiveRowColumnItem(
                  child: ResponsiveRowColumn(
                layout: ResponsiveRowColumnType.ROW,
                rowMainAxisAlignment: MainAxisAlignment.center,
                children: <ResponsiveRowColumnItem>[
                  ResponsiveRowColumnItem(
                      child: CustomFlatButton(
                          width: SizeConfig.horizontal(30),
                          text: 'Login',
                          textColor: AppColors.blackBackground,
                          onTap: () {
                            Get.off(() => const LoginView());
                            controller.emailController.clear();
                          }))
                ],
              ))
            ],
          ),
        ));
  }
}
