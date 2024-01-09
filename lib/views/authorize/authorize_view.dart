import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_row_column.dart';

import '../../controllers/authorize_controller.dart';
import '../../controllers/connection_status_controller.dart';
import '../../utils/app_colors.dart';
import '../widgets/custom/custom_app_version.dart';
import '../widgets/frame/frame_scaffold.dart';
import '../widgets/layouts/space_sizer.dart';
import '../widgets/logo/autoberes_logo.dart';

class AuthorizeView extends StatefulWidget {
  const AuthorizeView({super.key});

  @override
  State<AuthorizeView> createState() => _AuthorizeViewState();
}

final ConnectionStatusController connectionStatusController =
    Get.put(ConnectionStatusController(), permanent: true);
final AuthorizeController authorizeController = Get.put(AuthorizeController());

class _AuthorizeViewState extends State<AuthorizeView> {
  @override
  void initState() {
    super.initState();
    connectionStatusController.getConnectionType();
  }

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
        view: ResponsiveRowColumn(
          layout: ResponsiveRowColumnType.COLUMN,
          columnMainAxisAlignment: MainAxisAlignment.center,
          children: <ResponsiveRowColumnItem>[
            const ResponsiveRowColumnItem(child: Spacer()),
            const ResponsiveRowColumnItem(
                child: Center(child: AutoBeresLogo())),
            const ResponsiveRowColumnItem(child: Spacer()),
            ResponsiveRowColumnItem(
                child:
                    CustomAppVersion(authorizeController: authorizeController)),
            const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 3))
          ],
        ),
      ),
    );
  }
}
