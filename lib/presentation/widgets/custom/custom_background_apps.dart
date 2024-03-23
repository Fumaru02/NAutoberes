import 'package:flutter/widgets.dart';

import '../../../core/utils/asset_list.dart';

class CustomBackgroundApp extends StatelessWidget {
  const CustomBackgroundApp({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AssetList.backgroundRoom), fit: BoxFit.fill)),
        child: child);
  }
}
