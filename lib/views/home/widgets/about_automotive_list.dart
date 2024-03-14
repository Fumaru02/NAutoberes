import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../models/about_automotive/about_automotive_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/enums.dart';
import '../../../utils/size_config.dart';
import '../../widgets/layouts/space_sizer.dart';
import '../../widgets/text/inter_text_view.dart';
import 'about_automotive_detail_view.dart';

class AboutAutomotiveList extends StatelessWidget {
  const AboutAutomotiveList({
    super.key,
    required this.model,
  });

  final AboutAutomotiveModel model;
  @override
  Widget build(BuildContext context) {
    return ResponsiveRowColumn(
      layout: ResponsiveRowColumnType.COLUMN,
      children: <ResponsiveRowColumnItem>[
        ResponsiveRowColumnItem(
            child: Container(
                margin: EdgeInsets.all(SizeConfig.horizontal(2)),
                decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 2),
                          color: AppColors.greyDisabled)
                    ],
                    borderRadius: BorderRadius.all(
                        Radius.circular(SizeConfig.horizontal(2))),
                    color: AppColors.white),
                child: ResponsiveRowColumn(
                  layout: ResponsiveRowColumnType.COLUMN,
                  columnPadding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.horizontal(4)),
                  columnCrossAxisAlignment: CrossAxisAlignment.start,
                  children: <ResponsiveRowColumnItem>[
                    const ResponsiveRowColumnItem(
                        child: SpaceSizer(vertical: 1.5)),
                    ResponsiveRowColumnItem(
                        child: InterTextView(
                            value: model.title,
                            color: AppColors.black,
                            fontWeight: FontWeight.w900,
                            size: SizeConfig.safeBlockHorizontal * 4)),
                    const ResponsiveRowColumnItem(
                        child: SpaceSizer(vertical: 1)),
                    ResponsiveRowColumnItem(
                        child: Center(
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(
                                        SizeConfig.horizontal(1))),
                                    border: Border.all(
                                        width: SizeConfig.horizontal(0.1))),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            SizeConfig.horizontal(1))),
                                    child: Hero(
                                        tag: model.id,
                                        child: CachedNetworkImage(
                                            maxHeightDiskCache: 300,
                                            maxWidthDiskCache: 300,
                                            imageUrl: model.imageUrl,
                                            width: SizeConfig.horizontal(70),
                                            height: SizeConfig.horizontal(50),
                                            fit: BoxFit.fill)))))),
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
                    ResponsiveRowColumnItem(
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                                onPressed: () =>
                                    Get.to(AboutAutomotiveDetailView(
                                      model: model,
                                    )),
                                child: InterTextView(
                                    value: 'More details',
                                    color: AppColors.black,
                                    textDecoration: TextDecoration.underline,
                                    size:
                                        SizeConfig.safeBlockHorizontal * 3)))),
                  ],
                )))
      ],
    );
  }
}
