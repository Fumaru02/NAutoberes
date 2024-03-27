import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../core/constant/enums.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/size_config.dart';
import '../../../cubits/home/home_cubit.dart';
import '../../../widgets/layouts/space_sizer.dart';
import '../../../widgets/text/inter_text_view.dart';
import '../../../widgets/user/user_info.dart';

class CustomAppBarHome extends StatelessWidget {
  const CustomAppBarHome({
    super.key,
  });

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
                  child: BlocBuilder<HomeCubit, HomeCubitState>(
                builder: (_, HomeCubitState state) {
                  return InterTextView(
                      value: '${state.greetings},',
                      size: SizeConfig.safeBlockHorizontal * 3.5,
                      fontWeight: FontWeight.bold,
                      alignText: AlignTextType.left);
                },
              )),
              ResponsiveRowColumnItem(
                child:
                    // () => homeController.isLoading.isTrue
                    //     ? CustomShimmerPlaceHolder(
                    //         borderRadius: 4,
                    //         width: SizeConfig.horizontal(50),
                    //       )
                    SizedBox(
                  width: SizeConfig.horizontal(60),
                  child: Username(
                    color: AppColors.white,
                    size: 5,
                  ),
                ),
              )
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
