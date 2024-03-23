import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/size_config.dart';

class CustomBorderedContainer extends StatelessWidget {
  const CustomBorderedContainer({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.color,
    this.useShadow = true,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final Color? color;
  final bool? useShadow;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding,
        width: SizeConfig.horizontal(85),
        margin: EdgeInsets.all(SizeConfig.horizontal(2)),
        decoration: BoxDecoration(
            // ignore: use_if_null_to_convert_nulls_to_bools
            boxShadow: useShadow == true
                ? <BoxShadow>[
                    BoxShadow(
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 2),
                        color: AppColors.greyDisabled)
                  ]
                : null,
            borderRadius: BorderRadius.all(
                Radius.circular(SizeConfig.horizontal(borderRadius ?? 3))),
            color: color ?? AppColors.white),
        child: child);
  }
}
