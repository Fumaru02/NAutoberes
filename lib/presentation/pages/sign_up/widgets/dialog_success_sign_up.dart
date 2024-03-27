import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../core/constant/enums.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/size_config.dart';
import '../../../widgets/custom/custom_flat_button.dart';
import '../../../widgets/layouts/space_sizer.dart';
import '../../../widgets/logo/autoberes_logo.dart';
import '../../../widgets/text/inter_text_view.dart';

class DialogSuccessSignUp extends StatelessWidget {
  const DialogSuccessSignUp({
    super.key,
    required this.email,
  });
  final String email;
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(SizeConfig.horizontal(4)))),
        backgroundColor: AppColors.blackBackground,
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.horizontal(4)),
          child: ResponsiveRowColumn(
            layout: ResponsiveRowColumnType.COLUMN,
            columnMainAxisSize: MainAxisSize.min,
            children: <ResponsiveRowColumnItem>[
              const ResponsiveRowColumnItem(
                  child: AutoBeresLogo(height: 20, width: 19)),
              const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 2)),
              ResponsiveRowColumnItem(
                  child: InterTextView(
                      value:
                          'Pendaftaran Berhasil\nKami telah mengirim link email verifikasi ke $email mohon untuk di verifikasi terlebih dahulu sebelum login',
                      fontWeight: FontWeight.bold,
                      alignText: AlignTextType.center)),
              const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 2)),
              ResponsiveRowColumnItem(
                  child: CustomFlatButton(
                      backgroundColor: AppColors.white,
                      textColor: AppColors.blackBackground,
                      text: 'Confirm',
                      onTap: () => router.pop()))
            ],
          ),
        ));
  }
}
