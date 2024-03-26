import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../core/utils/asset_list.dart';
import '../../../../core/utils/size_config.dart';
import '../../../blocs/login/login_bloc.dart';
import 'bordered_button.dart';

class LoginMenu extends StatelessWidget {
  const LoginMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (_, LoginState state) {
      if (state.status == Status.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return ResponsiveRowColumn(
        layout: ResponsiveRowColumnType.ROW,
        rowPadding: EdgeInsets.symmetric(horizontal: SizeConfig.horizontal(1)),
        rowMainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <ResponsiveRowColumnItem>[
          ResponsiveRowColumnItem(
            child: BorderedButton(
                image: AssetList.googleLogo,
                ontap: () {
                  context.read<LoginBloc>().add(
                        SignInWithGoogle(),
                      );
                }),
          ),
          // ResponsiveRowColumnItem(
          //     child: BorderedButton(
          //   image: AssetList.appleLogo,
          //   ontap: () => context.read<LoginBloc>().add(SignInWithGoogle()),
          // )),
          ResponsiveRowColumnItem(
              child: BorderedButton(
                  image: AssetList.facebookLogo,
                  ontap: () => context.read<LoginBloc>().add(
                        SignInWithGoogle(),
                      )))
        ],
      );
    });
  }
}
