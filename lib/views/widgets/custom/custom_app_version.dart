import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_row_column.dart';

import '../../../controllers/authorize_controller.dart';
import '../../../utils/size_config.dart';
import '../text/inter_text_view.dart';

class CustomAppVersion extends StatelessWidget {
  const CustomAppVersion({super.key, required this.authorizeController});

  final AuthorizeController authorizeController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Obx(
        () => ResponsiveRowColumn(
          layout: ResponsiveRowColumnType.COLUMN,
          children: <ResponsiveRowColumnItem>[
            ResponsiveRowColumnItem(
              child: InterTextView(
                value: 'Version ${authorizeController.versionApp}',
                size: SizeConfig.safeBlockHorizontal * 3.5,
              ),
            ),
            ResponsiveRowColumnItem(
                child: InterTextView(
              value:
                  '©${authorizeController.appYear}. ${authorizeController.appName}',
              size: SizeConfig.safeBlockHorizontal * 3.5,
            )),
          ],
        ),
      ),
    );
  }
}
