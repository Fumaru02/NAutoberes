import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_row_column.dart';

import '../../../utils/size_config.dart';
import '../text/roboto_text_view.dart';

class CustomAppVersion extends StatelessWidget {
  const CustomAppVersion({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ResponsiveRowColumn(
        layout: ResponsiveRowColumnType.COLUMN,
        children: [
          ResponsiveRowColumnItem(
            child: RobotoTextView(
              value: 'Version 1.0.0',
              size: SizeConfig.safeBlockHorizontal * 3.5,
            ),
          ),
          ResponsiveRowColumnItem(
              child: RobotoTextView(
            value: '@2024. AutoBeres',
            size: SizeConfig.safeBlockHorizontal * 3.5,
          )),
        ],
      ),
    );
  }
}
