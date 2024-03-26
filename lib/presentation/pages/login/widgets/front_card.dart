import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/size_config.dart';
import '../../../blocs/login/login_bloc.dart';
import '../../../widgets/custom/custom_flat_button.dart';
import '../../../widgets/layouts/space_sizer.dart';
import '../../../widgets/text/inter_text_view.dart';
import 'back_card.dart';
import 'divider_login.dart';
import 'flip_card_button.dart';
import 'login_menu.dart';

class FrontCard extends StatelessWidget {
  const FrontCard({
    super.key,
    required this.email,
    required this.password,
    required this.angle,
  });
  final TextEditingController email;
  final TextEditingController password;
  final double angle;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.blueDark,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(SizeConfig.horizontal(8)),
          topRight: Radius.circular(SizeConfig.horizontal(8)),
        ),
      ),
      height: SizeConfig.vertical(65),
      width: SizeConfig.screenWidth,
      child: ResponsiveRowColumn(
        layout: ResponsiveRowColumnType.COLUMN,
        columnMainAxisAlignment: MainAxisAlignment.center,
        children: <ResponsiveRowColumnItem>[
          const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 1)),
          ResponsiveRowColumnItem(
              child: InterTextView(
            value: 'Welcome abroad!',
            fontWeight: FontWeight.bold,
            size: SizeConfig.safeBlockHorizontal * 7,
          )),
          const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 1)),
          ResponsiveRowColumnItem(
              child: InterTextView(
                  value: 'Please sign in to your account',
                  size: SizeConfig.safeBlockHorizontal * 3.5)),
          const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 3)),
          ResponsiveRowColumnItem(
              child: TextFieldCard(
            email: email,
            password: password,
          )),
          ResponsiveRowColumnItem(
              child: Padding(
                  padding: EdgeInsets.only(right: SizeConfig.horizontal(10)),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () =>
                              router.go('/forgotpassword', extra: email),
                          child: InterTextView(
                              size: SizeConfig.safeBlockHorizontal * 3.5,
                              value: 'Forgot your password?',
                              decorationColor: AppColors.white))))),
          ResponsiveRowColumnItem(child: BlocBuilder<LoginBloc, LoginState>(
            builder: (_, LoginState state) {
              return state.status == Status.loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : CustomFlatButton(
                      backgroundColor: AppColors.white,
                      text: 'Sign In',
                      textColor: AppColors.blackBackground,
                      onTap: () => context.read<LoginBloc>().add(
                          SignInWithEmailPassword(
                              email: email.text.trim(),
                              password: password.text.trim())));
            },
          )),
          const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 5)),
          ResponsiveRowColumnItem(
              child: ResponsiveRowColumn(
            layout: ResponsiveRowColumnType.ROW,
            rowPadding:
                EdgeInsets.symmetric(horizontal: SizeConfig.horizontal(2)),
            rowMainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <ResponsiveRowColumnItem>[
              const ResponsiveRowColumnItem(child: DividerLogin()),
              ResponsiveRowColumnItem(
                  child: InterTextView(
                value: 'Or continue with',
                size: SizeConfig.safeBlockHorizontal * 3,
              )),
              const ResponsiveRowColumnItem(child: DividerLogin())
            ],
          )),
          const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 2)),
          const ResponsiveRowColumnItem(child: LoginMenu()),
          const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 4)),
          ResponsiveRowColumnItem(
              child: InterTextView(
            value: "Don't have an account?",
            size: SizeConfig.safeBlockHorizontal * 3.5,
          )),
          ResponsiveRowColumnItem(child: FlipCardButton(angle: angle))
        ],
      ),
    );
  }
}
