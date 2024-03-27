import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../core/constant/enums.dart';
import '../../../core/helpers/snackbar.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/size_config.dart';
import '../../blocs/login/login_bloc.dart';
import '../../cubits/login/login_cubit.dart';
import '../../widgets/custom/custom_flat_button.dart';
import '../../widgets/frame/frame_scaffold.dart';
import '../../widgets/layouts/space_sizer.dart';
import '../../widgets/logo/autoberes_logo.dart';
import '../../widgets/text/inter_text_view.dart';
import 'widgets/back_card.dart';
import 'widgets/front_card.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (BuildContext context, LoginState state) {
        if (state.status == Status.error) {
          Snack.showSnackBar(context,
              messageInfo: 'Something wrong',
              message: state.errorMessage,
              snackbarType: SnackbarType.error);
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            systemNavigationBarColor: AppColors.black,
            systemNavigationBarIconBrightness: Brightness.dark),
        child: FrameScaffold(
          heightBar: 0,
          elevation: 0,
          color: AppColors.blackBackground,
          statusBarColor: AppColors.blackBackground,
          colorScaffold: AppColors.blackBackground,
          statusBarBrightness: Brightness.light,
          view: Stack(
            children: <Widget>[
              Center(
                child: ResponsiveRowColumn(
                  layout: ResponsiveRowColumnType.COLUMN,
                  children: <ResponsiveRowColumnItem>[
                    const ResponsiveRowColumnItem(
                        child: SpaceSizer(vertical: 12)),
                    const ResponsiveRowColumnItem(
                        child: Hero(tag: 'autoberes', child: AutoBeresLogo())),
                    const ResponsiveRowColumnItem(
                        child: SpaceSizer(vertical: 7)),
                    ResponsiveRowColumnItem(
                        child: InterTextView(
                            value: 'Welcome',
                            size: SizeConfig.safeBlockHorizontal * 4.5,
                            fontWeight: FontWeight.bold)),
                    ResponsiveRowColumnItem(
                        child: InterTextView(
                            value: 'Nice to see you',
                            size: SizeConfig.safeBlockHorizontal * 3.5,
                            fontWeight: FontWeight.w300)),
                    const ResponsiveRowColumnItem(
                        child: SpaceSizer(vertical: 35)),
                    ResponsiveRowColumnItem(
                        child: CustomFlatButton(
                      text: 'Continue',
                      backgroundColor: AppColors.white,
                      textColor: AppColors.blackBackground,
                      onTap: () {
                        context.read<LoginCubit>().isTappedAnimation();
                      },
                    )),
                  ],
                ),
              ),
              ResponsiveRowColumnItem(
                  child: OnShowModalCard(email: email, password: password))
            ],
          ),
        ),
      ),
    );
  }
}

class OnShowModalCard extends StatelessWidget {
  const OnShowModalCard({
    super.key,
    required this.email,
    required this.password,
  });

  final TextEditingController email;
  final TextEditingController password;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginCubitState>(
      builder: (BuildContext ctx, LoginCubitState state) {
        return AnimatedPositioned(
            curve: Curves.fastOutSlowIn,
            bottom: SizeConfig.horizontal(state.tappedAnimation ? 0 : -200),
            duration: const Duration(milliseconds: 300),
            child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: state.angle),
                duration: const Duration(seconds: 1),
                builder: (BuildContext _, double value, Widget? child) {
                  ctx.read<LoginCubit>().isFrontCard(value);
                  return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(value),
                      child: state.isFront == true
                          ? FrontCard(
                              angle: state.angle,
                              email: email,
                              password: password,
                            )
                          : BackCard(
                              state: state,
                              email: email,
                            ));
                }));
      },
    );
  }
}
