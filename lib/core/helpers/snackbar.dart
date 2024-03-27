import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../presentation/widgets/layouts/space_sizer.dart';
import '../../presentation/widgets/text/inter_text_view.dart';
import '../constant/enums.dart';
import '../utils/app_colors.dart';
import '../utils/size_config.dart';

class Snack {
  Snack._();

  static dynamic showSnackBar(
    BuildContext context, {
    required String message,
    required String messageInfo,
    SnackbarType? snackbarType,
    Duration duration = const Duration(milliseconds: 4000),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: EdgeInsets.all(SizeConfig.horizontal(4)),
          decoration: BoxDecoration(
              color: snackbarType == SnackbarType.error
                  ? AppColors.redAlert
                  : snackbarType == SnackbarType.success
                      ? AppColors.greenSuccess
                      : AppColors.orangeActive,
              borderRadius:
                  BorderRadius.all(Radius.circular(SizeConfig.horizontal(4)))),
          child: ResponsiveRowColumn(
            layout: ResponsiveRowColumnType.ROW,
            children: <ResponsiveRowColumnItem>[
              ResponsiveRowColumnItem(
                  child: Icon(
                snackbarType == SnackbarType.error
                    ? Icons.error
                    : snackbarType == SnackbarType.success
                        ? Icons.check_circle
                        : Icons.error_outline_outlined,
                size: SizeConfig.horizontal(8),
                color: AppColors.white,
              )),
              const ResponsiveRowColumnItem(child: SpaceSizer(horizontal: 2)),
              ResponsiveRowColumnItem(
                child: ResponsiveRowColumn(
                  layout: ResponsiveRowColumnType.COLUMN,
                  columnCrossAxisAlignment: CrossAxisAlignment.start,
                  children: <ResponsiveRowColumnItem>[
                    ResponsiveRowColumnItem(
                      child: InterTextView(
                        value: messageInfo,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        size: SizeConfig.safeBlockHorizontal * 3.5,
                      ),
                    ),
                    ResponsiveRowColumnItem(
                      child: ResponsiveRowColumnItem(
                        child: InterTextView(
                          value: message,
                          size: SizeConfig.safeBlockHorizontal * 3.5,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom: SizeConfig.horizontal(180),
        ),
        duration: duration,
      ),
    );
  }
}
