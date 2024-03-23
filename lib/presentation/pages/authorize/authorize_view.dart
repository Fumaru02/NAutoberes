import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/size_config.dart';
import '../../bloc/authorize_bloc/authorize_bloc.dart';
import '../../cubit/version_info_app_cubit.dart';
import '../../widgets/custom/custom_app_version.dart';
import '../../widgets/custom/custom_ripple_button.dart';
import '../../widgets/frame/frame_scaffold.dart';
import '../../widgets/layouts/space_sizer.dart';
import '../../widgets/logo/autoberes_logo.dart';
import '../../widgets/text/inter_text_view.dart';

class AuthorizeView extends StatefulWidget {
  const AuthorizeView({super.key});

  @override
  State<AuthorizeView> createState() => _AuthorizeViewState();
}

class _AuthorizeViewState extends State<AuthorizeView>
    with SingleTickerProviderStateMixin {
  final VersionInfoAppCubit _infoAppCubit = VersionInfoAppCubit();

  late AnimationController animationController;
  @override
  void initState() {
    super.initState();
    _infoAppCubit.getApplicationInfo();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
    animationController.repeat();
  }

  @override
  void dispose() {
    _infoAppCubit.close();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
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
          view: Center(
            child: ResponsiveRowColumn(
              layout: ResponsiveRowColumnType.COLUMN,
              columnMainAxisAlignment: MainAxisAlignment.center,
              children: <ResponsiveRowColumnItem>[
                const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 35)),
                ResponsiveRowColumnItem(
                    child: BlocListener<AuthorizeBloc, AuthorizeState>(
                  listener: (_, AuthorizeState state) {
                    if (state.authenticatedStatus ==
                        AuthenticatedStatus.authenticated) {
                      log('masuk frame');
                    } else {
                      router.go('/login');
                    }
                  },
                  child: RotationTransition(
                      turns: Tween<double>(begin: 0.0, end: 1.0)
                          .animate(animationController),
                      child:
                          const Hero(tag: 'autoberes', child: AutoBeresLogo())),
                )),
                const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 10)),
                ResponsiveRowColumnItem(
                    child: InterTextView(
                        value: 'Connecting to Server...',
                        size: SizeConfig.safeBlockHorizontal * 4.5,
                        fontWeight: FontWeight.bold)),
                ResponsiveRowColumnItem(
                    child: InterTextView(
                        value: 'Please wait a moment',
                        size: SizeConfig.safeBlockHorizontal * 3.5,
                        fontWeight: FontWeight.w300)),
                const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 12)),
                const ResponsiveRowColumnItem(child: CustomAppVersion()),
                const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 3))
              ],
            ),
          ),
        ));
  }
}

class CustomBorderedButton extends StatelessWidget {
  const CustomBorderedButton({
    super.key,
    required this.image,
    required this.ontap,
  });

  final String image;
  final Function() ontap;

  @override
  Widget build(BuildContext context) {
    return CustomRippleButton(
      onTap: ontap,
      child: Container(
        width: SizeConfig.horizontal(22),
        height: SizeConfig.horizontal(11),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius:
                BorderRadius.all(Radius.circular(SizeConfig.horizontal(3)))),
        child: Image.asset(
          image,
          width: SizeConfig.horizontal(5),
          height: SizeConfig.horizontal(5),
          scale: 1.5,
        ),
      ),
    );
  }
}

class DividerLogin extends StatelessWidget {
  const DividerLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.horizontal(24),
      color: AppColors.white,
      height: SizeConfig.horizontal(0.5),
    );
  }
}
