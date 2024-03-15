import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../models/about_automotive/about_automotive_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/enums.dart';
import '../../../utils/size_config.dart';
import '../../widgets/custom/custom_ripple_button.dart';
import '../../widgets/layouts/space_sizer.dart';
import '../../widgets/text/inter_text_view.dart';

class AboutAutomotiveList extends StatelessWidget {
  const AboutAutomotiveList({
    super.key,
    required this.model,
  });

  final AboutAutomotiveModel model;
  @override
  Widget build(BuildContext context) {
    return CustomRippleButton(
      onTap: () => Get.to(AboutAutomotiveList(model: model)),
      child: ResponsiveRowColumn(
        layout: ResponsiveRowColumnType.COLUMN,
        columnPadding:
            EdgeInsets.symmetric(horizontal: SizeConfig.horizontal(2)),
        columnCrossAxisAlignment: CrossAxisAlignment.start,
        children: <ResponsiveRowColumnItem>[
          const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 1)),
          ResponsiveRowColumnItem(
              child: Center(
                  child: Stack(
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(SizeConfig.horizontal(1))),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(
                          Radius.circular(SizeConfig.horizontal(2))),
                      child: Hero(
                          tag: model.id,
                          child: CachedNetworkImage(
                              maxHeightDiskCache: 300,
                              maxWidthDiskCache: 300,
                              imageUrl: model.imageUrl,
                              width: SizeConfig.horizontal(75),
                              height: SizeConfig.horizontal(50),
                              fit: BoxFit.fill)))),
              Container(
                  width: SizeConfig.horizontal(75),
                  height: SizeConfig.horizontal(50),
                  decoration: BoxDecoration(
                    color: AppColors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.all(
                        Radius.circular(SizeConfig.horizontal(2))),
                  ),
                  child: ResponsiveRowColumn(
                    layout: ResponsiveRowColumnType.COLUMN,
                    children: <ResponsiveRowColumnItem>[
                      ResponsiveRowColumnItem(
                          child: ResponsiveRowColumn(
                        layout: ResponsiveRowColumnType.ROW,
                        rowMainAxisAlignment: MainAxisAlignment.end,
                        rowPadding: EdgeInsets.all(SizeConfig.horizontal(2)),
                        children: <ResponsiveRowColumnItem>[
                          ResponsiveRowColumnItem(
                              child: Icon(
                            Icons.favorite,
                            color: AppColors.white,
                          )),
                          ResponsiveRowColumnItem(
                            child: InterTextView(
                                value: '1.1k',
                                color: AppColors.white,
                                alignText: AlignTextType.left,
                                size: SizeConfig.safeBlockHorizontal * 4),
                          ),
                          const ResponsiveRowColumnItem(
                              child: SpaceSizer(horizontal: 2)),
                          ResponsiveRowColumnItem(
                              child: Icon(
                            Icons.comment_outlined,
                            color: AppColors.white,
                          )),
                          ResponsiveRowColumnItem(
                            child: InterTextView(
                                value: '20',
                                color: AppColors.white,
                                alignText: AlignTextType.left,
                                size: SizeConfig.safeBlockHorizontal * 4),
                          ),
                        ],
                      )),
                      const ResponsiveRowColumnItem(
                          child: SpaceSizer(vertical: 1)),
                      ResponsiveRowColumnItem(
                          child: Padding(
                              padding: EdgeInsets.only(
                                  right: SizeConfig.horizontal(4)),
                              child: InterTextView(
                                  maxLines: 3,
                                  value: model.source,
                                  color: AppColors.greyTextDisabled,
                                  alignText: AlignTextType.left,
                                  size: SizeConfig.safeBlockHorizontal * 4))),
                      const ResponsiveRowColumnItem(child: Spacer()),
                      ResponsiveRowColumnItem(
                          child: Padding(
                        padding: EdgeInsets.all(SizeConfig.horizontal(2)),
                        child: InterTextView(
                            value: model.title,
                            fontWeight: FontWeight.w700,
                            size: SizeConfig.safeBlockHorizontal * 4),
                      )),
                    ],
                  )),
            ],
          ))),
        ],
      ),
    );
  }
}
