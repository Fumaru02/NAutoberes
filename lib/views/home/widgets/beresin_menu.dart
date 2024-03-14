import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../models/beresin_menu/beresin_menu_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/enums.dart';
import '../../../utils/size_config.dart';
import '../../widgets/custom/custom_ripple_button.dart';
import '../../widgets/layouts/space_sizer.dart';
import '../../widgets/text/inter_text_view.dart';

class BeresinMenu extends StatelessWidget {
  const BeresinMenu({
    super.key,
    required this.onRoute,
    required this.model,
  });

  final Function() onRoute;
  final BeresinMenuModel model;

  @override
  Widget build(BuildContext context) {
    return CustomRippleButton(
      onTap: onRoute,
      child: ResponsiveRowColumn(
        layout: ResponsiveRowColumnType.COLUMN,
        columnMainAxisAlignment: MainAxisAlignment.center,
        children: <ResponsiveRowColumnItem>[
          ResponsiveRowColumnItem(
              child: CachedNetworkImage(
                  imageUrl: model.imageUrl,
                  width: SizeConfig.horizontal(12),
                  height: SizeConfig.horizontal(12),
                  fit: BoxFit.fill)),
          const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 0.5)),
          ResponsiveRowColumnItem(
              child: SizedBox(
            width: SizeConfig.horizontal(22),
            child: InterTextView(
              value: model.title,
              alignText: AlignTextType.center,
              color: AppColors.black,
              size: SizeConfig.safeBlockHorizontal * 3,
              fontWeight: FontWeight.w500,
            ),
          ))
        ],
      ),
    );
  }
}
