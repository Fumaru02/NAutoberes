import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/size_config.dart';

class CustomBorderedContainer extends StatelessWidget {
  const CustomBorderedContainer({
    super.key,
    required this.child,
  });

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: SizeConfig.horizontal(85),
        margin: EdgeInsets.all(SizeConfig.horizontal(2)),
        decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 2),
                  color: AppColors.greyDisabled)
            ],
            borderRadius:
                BorderRadius.all(Radius.circular(SizeConfig.horizontal(3))),
            color: AppColors.white),
        child: child);
  }
}
