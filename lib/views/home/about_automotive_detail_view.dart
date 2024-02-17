import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_row_column.dart';

import '../../models/about_automotive/about_automotive_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/size_config.dart';
import '../widgets/frame/frame_scaffold.dart';
import '../widgets/layouts/space_sizer.dart';
import '../widgets/text/inter_text_view.dart';

class AboutAutomotiveDetailView extends StatelessWidget {
  const AboutAutomotiveDetailView({
    Key? key,
    required this.model,
  }) : super(key: key);

  final AboutAutomotiveModel model;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            systemNavigationBarColor: AppColors.black,
            systemNavigationBarIconBrightness: Brightness.dark),
        child: FrameScaffold(
          heightBar: 60,
          isUseLeading: true,
          titleScreen: 'News Detail',
          elevation: 0,
          color: Platform.isIOS ? AppColors.black : null,
          statusBarColor: AppColors.black,
          colorScaffold: Colors.grey[200],
          statusBarBrightness: Brightness.light,
          view: ResponsiveRowColumn(
            layout: ResponsiveRowColumnType.COLUMN,
            columnCrossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ResponsiveRowColumnItem(
                  child: Hero(
                      tag: model.id,
                      child: CachedNetworkImage(imageUrl: model.imageUrl))),
              const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 0.5)),
              ResponsiveRowColumnItem(
                  child: Padding(
                padding: EdgeInsets.all(SizeConfig.horizontal(2)),
                child: InterTextView(
                  value: model.title,
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              )),
              const ResponsiveRowColumnItem(child: Spacer()),
              ResponsiveRowColumnItem(
                  child: Container(
                padding: EdgeInsets.all(SizeConfig.horizontal(4)),
                height: SizeConfig.horizontal(90),
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(
                    color: AppColors.greyDisabled,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(SizeConfig.horizontal(7)),
                      topRight: Radius.circular(SizeConfig.horizontal(7)),
                    )),
                child: SingleChildScrollView(
                  child: ResponsiveRowColumn(
                    layout: ResponsiveRowColumnType.COLUMN,
                    columnCrossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ResponsiveRowColumnItem(
                          child: InterTextView(
                        value: 'Description',
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                      )),
                      ResponsiveRowColumnItem(
                          child: InterTextView(
                        value: model.description,
                        color: AppColors.black,
                      ))
                    ],
                  ),
                ),
              ))
            ],
          ),
        ));
  }
}
