import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:nested/nested.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../core/constant/enums.dart';
import '../../../../core/helpers/snackbar.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/asset_list.dart';
import '../../../../core/utils/size_config.dart';
import '../../../blocs/login/login_bloc.dart';
import '../../../cubits/login/login_cubit.dart';
import '../../../widgets/custom/custom_flat_button.dart';
import '../../../widgets/custom/custom_text_field.dart';
import '../../../widgets/layouts/space_sizer.dart';
import '../../../widgets/text/inter_text_view.dart';
import '../../../widgets/text/terms_and_conditions.dart';
import '../../sign_up/widgets/dialog_success_sign_up.dart';
import 'divider_login.dart';
import 'flip_card_button.dart';
import 'login_menu.dart';

class BackCard extends StatefulWidget {
  const BackCard({
    super.key,
    required this.email,
    required this.state,
  });
  final TextEditingController email;
  final LoginCubitState state;

  @override
  State<BackCard> createState() => _BackCardState();
}

class _BackCardState extends State<BackCard>
    with SingleTickerProviderStateMixin {
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController password = TextEditingController();

  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()..rotateY(math.pi),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.blueDark,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(SizeConfig.horizontal(8)),
                topRight: Radius.circular(SizeConfig.horizontal(8)))),
        height: SizeConfig.vertical(65),
        width: SizeConfig.screenWidth,
        child: KeyboardSizeProvider(
          child: Consumer<ScreenHeight>(
            builder: (BuildContext context, ScreenHeight res, Widget? child) =>
                BlocListener<LoginBloc, LoginState>(
              listener: (_, LoginState state) {
                if (state.status == Status.error) {
                  Snack.showSnackBar(context,
                      messageInfo: 'Something wrong',
                      message: state.errorMessage,
                      snackbarType: SnackbarType.error);
                }
              },
              child: ResponsiveRowColumn(
                layout: ResponsiveRowColumnType.COLUMN,
                columnPadding: EdgeInsets.symmetric(
                    vertical: SizeConfig.horizontal(res.isOpen ? 0 : 10)),
                columnMainAxisAlignment: MainAxisAlignment.center,
                children: <ResponsiveRowColumnItem>[
                  const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 2)),
                  ResponsiveRowColumnItem(
                      child: InterTextView(
                          value: 'Sign Up',
                          fontWeight: FontWeight.bold,
                          size: SizeConfig.safeBlockHorizontal * 6.5)),
                  const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 1)),
                  ResponsiveRowColumnItem(
                      child: InterTextView(
                          value: 'Please register your account',
                          size: SizeConfig.safeBlockHorizontal * 3.5)),
                  const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 2)),
                  ResponsiveRowColumnItem(
                    child: TabBar(
                        indicatorColor: AppColors.white,
                        controller: tabController,
                        labelStyle: InterStyle().labelStyle(AppColors.white),
                        padding: EdgeInsets.all(SizeConfig.horizontal(2)),
                        indicatorPadding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.horizontal(8)),
                        tabs: <Widget>[
                          InterTextView(
                              value: 'E-mail',
                              fontWeight: FontWeight.bold,
                              size: SizeConfig.safeBlockHorizontal * 4),
                          InterTextView(
                              value: 'No. Hp',
                              fontWeight: FontWeight.bold,
                              size: SizeConfig.safeBlockHorizontal * 4),
                        ]),
                  ),
                  ResponsiveRowColumnItem(
                      child: Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: <Widget>[
                        TextFieldCard(email: widget.email, password: password),
                        Center(
                            child: CustomTextField(
                                controller: phoneNumber,
                                title: '',
                                hintText: 'Phone number',
                                prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: SizeConfig.horizontal(2)),
                                  child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Image.asset(AssetList.indonesian,
                                            scale: 1.5),
                                        const SpaceSizer(horizontal: 1),
                                        InterTextView(
                                            value: '+62',
                                            color: AppColors.black,
                                            size:
                                                SizeConfig.safeBlockHorizontal *
                                                    3.5)
                                      ]),
                                ))),
                      ],
                    ),
                  )),
                  ResponsiveRowColumnItem(
                    child: CustomFlatButton(
                        backgroundColor: AppColors.white,
                        textColor: AppColors.blackBackground,
                        text: 'Continue',
                        onTap: () {
                          if (widget.email.text.length <= 6 ||
                              widget.email.text.isEmpty ||
                              password.text.isEmpty ||
                              password.text.length <= 6) {
                            Snack.showSnackBar(context,
                                messageInfo: 'Something wrong',
                                message: 'email/password is not valid',
                                snackbarType: SnackbarType.error);
                          } else {
                            showDialog(
                              context: context,
                              builder: (__) => MultiBlocProvider(
                                providers: <SingleChildWidget>[
                                  BlocProvider<LoginCubit>.value(
                                    value: context.read<LoginCubit>(),
                                  ),
                                  BlocProvider<LoginBloc>.value(
                                    value: context.read<LoginBloc>(),
                                  ),
                                ],
                                child: TermsAndCondition(onTap: () {
                                  context.read<LoginBloc>().add(SignUpWithEmail(
                                      agreeTerms: true,
                                      email: widget.email.text,
                                      password: password.text));
                                  router.pop();
                                  showDialog(
                                      context: context,
                                      builder: (__) => DialogSuccessSignUp(
                                          email: widget.email.text));
                                }),
                              ),
                            );
                          }
                        }),
                  ),
                  const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 3)),
                  ResponsiveRowColumnItem(
                    child: ResponsiveRowColumn(
                      layout: ResponsiveRowColumnType.ROW,
                      rowPadding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.horizontal(8)),
                      rowMainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <ResponsiveRowColumnItem>[
                        const ResponsiveRowColumnItem(child: DividerLogin()),
                        ResponsiveRowColumnItem(
                            child: InterTextView(
                                value: 'Or continue with',
                                size: SizeConfig.safeBlockHorizontal * 3)),
                        const ResponsiveRowColumnItem(child: DividerLogin())
                      ],
                    ),
                  ),
                  const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 3)),
                  const ResponsiveRowColumnItem(child: LoginMenu()),
                  const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 2)),
                  ResponsiveRowColumnItem(
                      child: InterTextView(
                          value: 'have an account?',
                          size: SizeConfig.safeBlockHorizontal * 3.5)),
                  ResponsiveRowColumnItem(
                    child: FlipCardButton(
                      angle: widget.state.angle,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TextFieldCard extends StatelessWidget {
  const TextFieldCard({
    super.key,
    required this.email,
    required this.password,
  });

  final TextEditingController email;
  final TextEditingController password;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ResponsiveRowColumn(
      layout: ResponsiveRowColumnType.COLUMN,
      children: <ResponsiveRowColumnItem>[
        ResponsiveRowColumnItem(
          child: CustomTextField(
              controller: email,
              textAlignVertical: TextAlignVertical.center,
              title: '',
              keyboardType: TextInputType.multiline,
              hintText: 'Username/Email',
              height: SizeConfig.horizontal(15),
              contentPadding: EdgeInsets.symmetric(
                vertical: SizeConfig.horizontal(5),
              ),
              prefixIcon: Image.asset(AssetList.emailLogo)),
        ),
        ResponsiveRowColumnItem(
          child: CustomTextField(
              isPasswordField: true,
              controller: password,
              title: '',
              hintText: 'Password',
              prefixIcon: Image.asset(AssetList.passwordLogo)),
        ),
      ],
    ));
  }
}
