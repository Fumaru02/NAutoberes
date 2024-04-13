import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/asset_list.dart';
import '../../../utils/size_config.dart';
import '../text/inter_text_view.dart';

class CustomEmptyState extends StatelessWidget {
  const CustomEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          width: SizeConfig.horizontal(65),
          height: SizeConfig.horizontal(65),
          child: ResponsiveRowColumn(
              layout: ResponsiveRowColumnType.COLUMN,
              children: <ResponsiveRowColumnItem>[
                ResponsiveRowColumnItem(
                    child: InterTextView(
                  value: 'empty list please try again...',
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                )),
                ResponsiveRowColumnItem(
                    child: Lottie.asset(AssetList.emptyStateAnimation,
                        frameRate: FrameRate.max))
              ])),
    );
  }
}
