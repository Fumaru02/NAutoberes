import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../core/helpers/snackbar.dart';
import '../../../../core/utils/asset_list.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/size_config.dart';
import '../../../bloc/login/login_bloc.dart';
import 'bordered_button.dart';

class LoginMenu extends StatelessWidget {
  const LoginMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(listener: (_, LoginState state) {
      if (state.status == Status.success) {
      } else {
        Snack.show(SnackbarType.error, 'invalid email',
            'Email tidak dapat ditemukan coba lagi');
      }
    }, builder: (_, LoginState state) {
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
              ontap: () => context.read<LoginBloc>().add(
                    SignInWithGoogle(),
                  ),
            ),
          ),
          ResponsiveRowColumnItem(
              child: BorderedButton(
            image: AssetList.appleLogo,
            ontap: () => context.read<LoginBloc>().add(SignInWithGoogle()),
          )),
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
