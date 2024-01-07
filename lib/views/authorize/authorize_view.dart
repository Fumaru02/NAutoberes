import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_row_column.dart';

import '../../controllers/authorize_controller.dart';
import '../../utils/app_colors.dart';
import '../widgets/custom/custom_app_version.dart';
import '../widgets/frame/frame_scaffold.dart';
import '../widgets/layouts/space_sizer.dart';
import '../widgets/logo/autoberes_logo.dart';

class AuthorizeView extends StatelessWidget {
  const AuthorizeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AuthorizeController());
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
        view: const ResponsiveRowColumn(
          layout: ResponsiveRowColumnType.COLUMN,
          columnMainAxisAlignment: MainAxisAlignment.center,
          children: <ResponsiveRowColumnItem>[
            ResponsiveRowColumnItem(child: Spacer()),
            ResponsiveRowColumnItem(child: Center(child: AutoBeresLogo())),
            ResponsiveRowColumnItem(child: Spacer()),
            ResponsiveRowColumnItem(child: CustomAppVersion()),
            ResponsiveRowColumnItem(child: SpaceSizer(vertical: 3))
          ],
        ),
      ),
    );
  }
}
