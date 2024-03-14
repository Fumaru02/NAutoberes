import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../controllers/authorize_controller.dart';
import '../../controllers/connection_status_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/size_config.dart';
import '../widgets/custom/custom_app_version.dart';
import '../widgets/custom/custom_background_apps.dart';
import '../widgets/custom/custom_ripple_button.dart';
import '../widgets/frame/frame_scaffold.dart';
import '../widgets/layouts/space_sizer.dart';
import '../widgets/logo/autoberes_logo.dart';
import '../widgets/text/inter_text_view.dart';

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
  void dispose() {
    authorizeController.animationController.dispose();
    super.dispose();
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
            view: CustomBackgroundApps(
              child: Center(
                child: ResponsiveRowColumn(
                  layout: ResponsiveRowColumnType.COLUMN,
                  columnMainAxisAlignment: MainAxisAlignment.center,
                  children: <ResponsiveRowColumnItem>[
                    const ResponsiveRowColumnItem(
                        child: SpaceSizer(vertical: 35)),
                    ResponsiveRowColumnItem(
                        child: RotationTransition(
                            turns: Tween<double>(begin: 0.0, end: 1.0).animate(
                                authorizeController.animationController),
                            child: Obx(() => Hero(
                                tag: authorizeController.tagHero.value,
                                child: const AutoBeresLogo())))),
                    const ResponsiveRowColumnItem(
                        child: SpaceSizer(vertical: 10)),
                    ResponsiveRowColumnItem(
                        child: InterTextView(
                            value: 'Connecting to Server...',
                            size: SizeConfig.safeBlockHorizontal * 4.5,
                            fontWeight: FontWeight.bold)),
                    ResponsiveRowColumnItem(
                        child: InterTextView(
                            value: 'Please wait a moment',
                            size: SizeConfig.safeBlockHorizontal * 3.5,
                            fontWeight: FontWeight.w300)),
                    const ResponsiveRowColumnItem(
                        child: SpaceSizer(vertical: 12)),
                    ResponsiveRowColumnItem(
                        child: CustomAppVersion(
                            authorizeController: authorizeController)),
                    const ResponsiveRowColumnItem(
                        child: SpaceSizer(vertical: 3))
                  ],
                ),
              ),
            )));
  }
}

class CustomBorderedButton extends StatelessWidget {
  const CustomBorderedButton({
    super.key,
    required this.image,
    required this.ontap,
  });

  final String image;
  final Function() ontap;

  @override
  Widget build(BuildContext context) {
    return CustomRippleButton(
      onTap: ontap,
      child: Container(
        width: SizeConfig.horizontal(22),
        height: SizeConfig.horizontal(11),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius:
                BorderRadius.all(Radius.circular(SizeConfig.horizontal(3)))),
        child: Image.asset(
          image,
          width: SizeConfig.horizontal(5),
          height: SizeConfig.horizontal(5),
          scale: 1.5,
        ),
      ),
    );
  }
}

class DividerLogin extends StatelessWidget {
  const DividerLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.horizontal(24),
      color: AppColors.white,
      height: SizeConfig.horizontal(0.5),
    );
  }
}
