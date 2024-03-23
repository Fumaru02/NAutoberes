import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/size_config.dart';
import '../../widgets/custom/custom_background_apps.dart';
import '../../widgets/custom/custom_bordered_container.dart';
import '../../widgets/custom/custom_ripple_button.dart';
import '../../widgets/frame/frame_scaffold.dart';
import '../../widgets/layouts/space_sizer.dart';
import '../../widgets/text/inter_text_view.dart';
import 'widgets/ketentuan_dan_kebijakan_privasi.dart';

class BantuanView extends StatelessWidget {
  const BantuanView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            systemNavigationBarColor: AppColors.black,
            systemNavigationBarIconBrightness: Brightness.dark),
        child: FrameScaffold(
            heightBar: 60,
            isUseLeading: true,
            titleScreen: 'Bantuan',
            isCenter: true,
            elevation: 0,
            color: AppColors.blackBackground,
            statusBarColor: AppColors.blackBackground,
            colorScaffold: AppColors.greyBackground,
            statusBarBrightness: Brightness.light,
            view: CustomBackgroundApp(
              child: ResponsiveRowColumn(
                layout: ResponsiveRowColumnType.COLUMN,
                columnPadding: EdgeInsets.all(SizeConfig.horizontal(5)),
                children: <ResponsiveRowColumnItem>[
                  ResponsiveRowColumnItem(
                      child: IconTextWrapper(
                    onTap: () => Get.to(const KetentuanDanKebijakanPrivasi()),
                    title: 'Ketentuan dan Kebijakan Privasi',
                    icon: Icons.note_alt_outlined,
                  )),
                  const ResponsiveRowColumnItem(
                      child: SpaceSizer(
                    vertical: 1,
                  )),
                  ResponsiveRowColumnItem(
                      child: IconTextWrapper(
                    onTap: () {},
                    title: 'Hubungi kami',
                    icon: Icons.call,
                  )),
                  const ResponsiveRowColumnItem(
                      child: SpaceSizer(
                    vertical: 1,
                  )),
                  ResponsiveRowColumnItem(
                      child: IconTextWrapper(
                    onTap: () {},
                    title: 'Laporkan bug',
                    icon: Icons.dangerous_outlined,
                  )),
                  const ResponsiveRowColumnItem(child: Spacer()),
                  // ResponsiveRowColumnItem(
                  //     child: CustomAppVersion(
                  //   color: AppColors.black,
                  //   authorizeController: authorizeController,
                  // )),
                  const ResponsiveRowColumnItem(
                      child: SpaceSizer(
                    vertical: 2,
                  )),
                ],
              ),
            )));
  }
}

class IconTextWrapper extends StatelessWidget {
  const IconTextWrapper({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });
  final String title;
  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return CustomRippleButton(
      onTap: onTap,
      child: CustomBorderedContainer(
        padding: EdgeInsets.all(SizeConfig.horizontal(2)),
        child: ResponsiveRowColumn(
          layout: ResponsiveRowColumnType.ROW,
          children: <ResponsiveRowColumnItem>[
            ResponsiveRowColumnItem(
                child: Icon(
              icon,
              size: SizeConfig.safeBlockHorizontal * 8,
              color: AppColors.grey,
            )),
            const ResponsiveRowColumnItem(
                child: SpaceSizer(
              horizontal: 2,
            )),
            ResponsiveRowColumnItem(
                child: InterTextView(
              value: title,
              color: AppColors.black,
            )),
          ],
        ),
      ),
    );
  }
}
