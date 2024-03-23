import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/size_config.dart';
import '../../cubit/version_info_app_cubit.dart';
import '../text/inter_text_view.dart';

class CustomAppVersion extends StatelessWidget {
  const CustomAppVersion({
    super.key,
    this.color,
  });

  final Color? color;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VersionInfoAppCubit, VersionInfoAppState>(
      builder: (BuildContext context, VersionInfoAppState state) {
        return ResponsiveRowColumn(
          layout: ResponsiveRowColumnType.COLUMN,
          children: <ResponsiveRowColumnItem>[
            ResponsiveRowColumnItem(
              child: InterTextView(
                value: 'Version ${state.versionApp}',
                size: SizeConfig.safeBlockHorizontal * 3.5,
                color: color ?? AppColors.white,
              ),
            ),
            ResponsiveRowColumnItem(
                child: InterTextView(
              value: '©${state.appYear}. ${state.appName}',
              size: SizeConfig.safeBlockHorizontal * 3.5,
              color: color ?? AppColors.white,
            )),
          ],
        );
      },
    );
  }
}
