import 'package:flutter/widgets.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/size_config.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.child,
    this.height,
  });
  final Widget child;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                spreadRadius: 2,
                blurRadius: 2,
                color: AppColors.greyDisabled,
                offset: const Offset(0, 2))
          ],
          color: AppColors.blackBackground,
          borderRadius:
              BorderRadius.all(Radius.circular(SizeConfig.horizontal(5)))),
      width: SizeConfig.horizontal(90),
      height: height,
      child: child,
    );
  }
}
