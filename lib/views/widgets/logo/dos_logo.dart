import 'package:flutter/material.dart';

import '../../../utils/asset_list.dart';
import '../../../utils/size_config.dart';

class DosLogo extends StatelessWidget {
  const DosLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: SizeConfig.horizontal(30),
        width: SizeConfig.horizontal(30),
        child: Image.asset(AssetList.dosLogo));
  }
}
