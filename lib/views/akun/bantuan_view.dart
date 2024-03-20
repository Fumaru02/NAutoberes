import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../utils/app_colors.dart';
import '../../utils/size_config.dart';
import '../widgets/custom/custom_background_apps.dart';
import '../widgets/frame/frame_scaffold.dart';
import '../widgets/layouts/space_sizer.dart';
import '../widgets/text/inter_text_view.dart';

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
                children: const <ResponsiveRowColumnItem>[
                  ResponsiveRowColumnItem(
                      child: IconTextWrapper(
                    title: 'Ketentuan dan Kebijakan Privasi',
                    icon: Icons.note_alt_outlined,
                  )),
                  ResponsiveRowColumnItem(
                      child: SpaceSizer(
                    vertical: 3,
                  )),
                  ResponsiveRowColumnItem(
                      child: IconTextWrapper(
                    title: 'Hubungi kami',
                    icon: Icons.call,
                  )),
                  ResponsiveRowColumnItem(
                      child: SpaceSizer(
                    vertical: 3,
                  )),
                  ResponsiveRowColumnItem(
                      child: IconTextWrapper(
                    title: 'Laporkan bug',
                    icon: Icons.dangerous_outlined,
                  )),
                  ResponsiveRowColumnItem(
                      child: SpaceSizer(
                    vertical: 3,
                  )),
                  ResponsiveRowColumnItem(
                      child: IconTextWrapper(
                    title: 'Informasi Aplikasi',
                    icon: Icons.info_outline,
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
  });
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ResponsiveRowColumn(
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
          horizontal: 5,
        )),
        ResponsiveRowColumnItem(
            child: InterTextView(
          value: title,
          color: AppColors.black,
        )),
      ],
    );
  }
}
