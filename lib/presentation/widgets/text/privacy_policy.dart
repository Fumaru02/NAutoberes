import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/size_config.dart';
import '../../blocs/login/login_bloc.dart';
import '../../cubits/login/login_cubit.dart';
import '../custom/custom_bordered_container.dart';
import '../custom/custom_flat_button.dart';
import '../custom/custom_html_wrapper.dart';
import '../layouts/space_sizer.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({
    super.key,
    required this.state,
  });
  final LoginCubitState state;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(SizeConfig.horizontal(2)))),
      insetAnimationCurve: Curves.bounceIn,
      backgroundColor: AppColors.blackBackground,
      child: SizedBox(
        height: SizeConfig.horizontal(120),
        width: SizeConfig.horizontal(170),
        child: RawScrollbar(
          thumbColor: AppColors.white,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(SizeConfig.horizontal(4)))),
          trackVisibility: true,
          child: SingleChildScrollView(
            child: ResponsiveRowColumn(
              columnPadding: EdgeInsets.all(SizeConfig.horizontal(4)),
              layout: ResponsiveRowColumnType.COLUMN,
              children: <ResponsiveRowColumnItem>[
                ResponsiveRowColumnItem(
                    child: BlocBuilder<LoginBloc, LoginState>(
                  builder: (_, LoginState loginState) {
                    return CustomBorderedContainer(
                        useShadow: false,
                        color: AppColors.blueDark,
                        child:
                            CustomHtmlWrapper(data: loginState.privacyPolicy));
                  },
                )),
                const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 1.5)),
                ResponsiveRowColumnItem(
                  child: CustomFlatButton(
                      backgroundColor: AppColors.white,
                      textColor: AppColors.blackBackground,
                      height: 5,
                      text: 'Agree',
                      onTap: () {
                        router.pop();
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
