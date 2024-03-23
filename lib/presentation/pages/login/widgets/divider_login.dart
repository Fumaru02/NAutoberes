import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/size_config.dart';

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
