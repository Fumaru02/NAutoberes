import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/size_config.dart';
import '../../../cubits/login/login_cubit.dart';
import '../../../widgets/custom/custom_ripple_button.dart';
import '../../../widgets/text/inter_text_view.dart';

class FlipCardButton extends StatelessWidget {
  const FlipCardButton({
    super.key,
    required this.angle,
  });

  final double angle;

  @override
  Widget build(BuildContext context) {
    return CustomRippleButton(
        onTap: () => context.read<LoginCubit>().flipped(angle),
        child: InterTextView(
            size: SizeConfig.safeBlockHorizontal * 3.5,
            value: angle == 0 ? 'Register' : 'Sign In',
            fontWeight: FontWeight.bold));
  }
}
