import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../controllers/home/home_controller.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/enums.dart';
import '../../../utils/size_config.dart';
import '../../widgets/custom/custom_shimmer_placeholder.dart';
import '../../widgets/layouts/space_sizer.dart';
import '../../widgets/text/inter_text_view.dart';
import '../../widgets/user/user_info.dart';

class CustomAppBarHome extends StatelessWidget {
  const CustomAppBarHome({
    super.key,
    required this.homeController,
  });
  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return ResponsiveRowColumn(
      layout: ResponsiveRowColumnType.ROW,
      rowPadding: EdgeInsets.symmetric(
          horizontal: SizeConfig.horizontal(2),
          vertical: SizeConfig.horizontal(2)),
      rowSpacing: 8,
      children: <ResponsiveRowColumnItem>[
        ResponsiveRowColumnItem(
            child: ResponsiveRowColumn(
                layout: ResponsiveRowColumnType.COLUMN,
                columnCrossAxisAlignment: CrossAxisAlignment.start,
                columnMainAxisAlignment: MainAxisAlignment.center,
                children: <ResponsiveRowColumnItem>[
              ResponsiveRowColumnItem(
                  child: InterTextView(
                      value: 'Hi,',
                      size: SizeConfig.safeBlockHorizontal * 3.5,
                      fontWeight: FontWeight.bold,
                      alignText: AlignTextType.left)),
              ResponsiveRowColumnItem(
                  child: Obx(
                () => homeController.isLoading.isTrue
                    ? CustomShimmerPlaceHolder(
                        borderRadius: 4,
                        width: SizeConfig.horizontal(50),
                      )
                    : Username(
                        color: AppColors.white,
                        size: 5,
                      ),
              )),
            ])),
        const ResponsiveRowColumnItem(child: Spacer()),
        ResponsiveRowColumnItem(
          child: Icon(
            Icons.favorite,
            color: AppColors.white,
            size: SizeConfig.horizontal(8),
          ),
        ),
        const ResponsiveRowColumnItem(child: SpaceSizer(horizontal: 1)),
        ResponsiveRowColumnItem(
          child: Icon(
            Icons.notifications_sharp,
            color: AppColors.white,
            size: SizeConfig.horizontal(8),
          ),
        )
      ],
    );
  }
}
