import 'package:flutter/material.dart';

import '../../../utils/asset_list.dart';
import '../../../utils/size_config.dart';

class AutoBeresLogo extends StatelessWidget {
  const AutoBeresLogo({
    super.key,
    this.height,
    this.width,
    this.color,
  });

  final double? height;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: SizeConfig.horizontal(height ?? 50),
        width: SizeConfig.horizontal(width ?? 48),
        child: Image.asset(
          AssetList.autoberesLogo,
          color: color,
        ));
  }
}
