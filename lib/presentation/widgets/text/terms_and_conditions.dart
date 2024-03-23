import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/size_config.dart';
import '../../bloc/login/login_bloc.dart';
import '../../cubit/login/login_cubit.dart';
import '../custom/custom_bordered_container.dart';
import '../custom/custom_flat_button.dart';
import '../custom/custom_html_wrapper.dart';
import '../layouts/space_sizer.dart';
import 'privacy_policy.dart';

class TermsAndCondition extends StatelessWidget {
  const TermsAndCondition({
    super.key,
    required this.privacyPolicyRecognizer,
  });
  final TapGestureRecognizer privacyPolicyRecognizer;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(SizeConfig.horizontal(2)))),
      insetAnimationCurve: Curves.bounceIn,
      backgroundColor: AppColors.blackBackground,
      child: SizedBox(
        height: SizeConfig.horizontal(150),
        width: SizeConfig.horizontal(180),
        child: RawScrollbar(
          thumbColor: AppColors.white,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(SizeConfig.horizontal(4)))),
          trackVisibility: true,
          child: SingleChildScrollView(
            child: BlocBuilder<LoginCubit, LoginCubitState>(
              builder: (_, LoginCubitState state) {
                return ResponsiveRowColumn(
                  columnPadding: EdgeInsets.all(SizeConfig.horizontal(4)),
                  layout: ResponsiveRowColumnType.COLUMN,
                  children: <ResponsiveRowColumnItem>[
                    ResponsiveRowColumnItem(
                        child: BlocBuilder<LoginBloc, LoginState>(
                      builder: (_, LoginState loginState) {
                        return CustomBorderedContainer(
                            useShadow: false,
                            color: AppColors.blueDark,
                            child: CustomHtmlWrapper(
                                data: loginState.termsAndcondition));
                      },
                    )),
                    const ResponsiveRowColumnItem(
                        child: SpaceSizer(vertical: 2)),
                    ResponsiveRowColumnItem(
                      child: Row(
                        children: <Widget>[
                          Checkbox(
                              side: BorderSide(
                                  width: SizeConfig.horizontal(0.7),
                                  color: AppColors.white),
                              value: state.isChecked,
                              onChanged: (bool? v0) =>
                                  context.read<LoginCubit>().isCheckedBox()),
                          SizedBox(
                              width: SizeConfig.horizontal(55),
                              child: RichText(
                                text: TextSpan(
                                  text:
                                      'Saya Setuju membagikan data diri saya kepihak AutoBeres untuk tujuan komersial ',
                                  children: <InlineSpan>[
                                    const TextSpan(
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                        text: 'Terms And Condition'),
                                    const TextSpan(
                                      text: ' and ',
                                    ),
                                    TextSpan(
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          decoration: TextDecoration.underline),
                                      text: 'Privacy Policy',
                                      recognizer: privacyPolicyRecognizer
                                        ..onTap = () {
                                          showDialog(
                                            context: context,
                                            builder: (__) =>
                                                BlocProvider<LoginBloc>.value(
                                              value: context.read<LoginBloc>(),
                                              child: PrivacyPolicy(
                                                state: state,
                                              ),
                                            ),
                                          );
                                        },
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                    const ResponsiveRowColumnItem(
                        child: SpaceSizer(vertical: 1.5)),
                    ResponsiveRowColumnItem(
                        child: state.isChecked
                            ? CustomFlatButton(
                                backgroundColor: AppColors.white,
                                textColor: AppColors.blackBackground,
                                height: 5,
                                text: 'I Agree',
                                onTap: () {})
                            : const SizedBox.shrink())
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
