import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/size_config.dart';
import '../../../widgets/custom/custom_ripple_button.dart';

class BorderedButton extends StatelessWidget {
  const BorderedButton({
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
