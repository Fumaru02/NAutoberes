import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../utils/size_config.dart';
import '../../widgets/custom/custom_shimmer_placeholder.dart';
import '../../widgets/layouts/space_sizer.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveRowColumn(
      layout: ResponsiveRowColumnType.COLUMN,
      columnPadding: EdgeInsets.symmetric(horizontal: SizeConfig.horizontal(4)),
      columnCrossAxisAlignment: CrossAxisAlignment.start,
      children: <ResponsiveRowColumnItem>[
        const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 1)),
        ResponsiveRowColumnItem(
          child: CustomShimmerPlaceHolder(
            borderRadius: 4,
            width: SizeConfig.horizontal(50),
          ),
        ),
        const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 1)),
        ResponsiveRowColumnItem(
            child: Center(
          child: CustomShimmerPlaceHolder(
            borderRadius: 4,
            height: SizeConfig.horizontal(40),
            width: SizeConfig.horizontal(80),
          ),
        )),
        const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 1)),
        ResponsiveRowColumnItem(
          child: CustomShimmerPlaceHolder(
            borderRadius: 4,
            width: SizeConfig.horizontal(50),
          ),
        ),
        const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 1)),
      ],
    );
  }
}
