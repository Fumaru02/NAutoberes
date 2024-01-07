import 'package:flutter/material.dart';

import '../../../utils/asset_list.dart';
import '../../../utils/size_config.dart';

class AutoBeresLogo extends StatelessWidget {
  const AutoBeresLogo({Key? key, this.height, this.width}) : super(key: key);

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: SizeConfig.horizontal(height ?? 50),
        width: SizeConfig.horizontal(width ?? 48),
        child: Image.asset(AssetList.autoberesLogo));
  }
}
