import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/size_config.dart';
import '../../widgets/layouts/space_sizer.dart';
import '../../widgets/text/inter_text_view.dart';

class ItemChat extends StatelessWidget {
  const ItemChat({
    super.key,
    required this.isSender,
    required this.msg,
    required this.time,
    required this.isRead,
  });

  final bool isSender;
  final String msg;
  final String time;
  final bool isRead;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: SizeConfig.horizontal(1),
          horizontal: SizeConfig.horizontal(2)),
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                color: AppColors.blackBackground,
                borderRadius: isSender
                    ? BorderRadius.only(
                        topLeft: Radius.circular(SizeConfig.horizontal(3.5)),
                        topRight: Radius.circular(SizeConfig.horizontal(3.5)),
                        bottomLeft: Radius.circular(SizeConfig.horizontal(3.5)),
                      )
                    : BorderRadius.only(
                        topLeft: Radius.circular(SizeConfig.horizontal(3.5)),
                        topRight: Radius.circular(SizeConfig.horizontal(3.5)),
                        bottomRight:
                            Radius.circular(SizeConfig.horizontal(3.5)),
                      ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.horizontal(3.5),
                vertical: SizeConfig.horizontal(2),
              ),
              child: SizedBox(
                width: msg.length > 20 ? SizeConfig.horizontal(60) : null,
                child: InterTextView(
                    value: msg,
                    size: SizeConfig.safeBlockHorizontal * 4,
                    fontWeight: FontWeight.w500),
              )),
          const SpaceSizer(vertical: 0.5),
          ResponsiveRowColumn(
            layout: ResponsiveRowColumnType.ROW,
            rowMainAxisSize: MainAxisSize.min,
            rowCrossAxisAlignment:
                isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: <ResponsiveRowColumnItem>[
              ResponsiveRowColumnItem(
                child: InterTextView(
                  value: DateFormat.jm().format(DateTime.parse(time)),
                  color: AppColors.black,
                  size: SizeConfig.safeBlockHorizontal * 3,
                ),
              ),
              const ResponsiveRowColumnItem(child: SpaceSizer(horizontal: 0.5)),
              ResponsiveRowColumnItem(
                  child: isSender == true
                      ? Icon(
                          isRead == true
                              ? Icons.check_circle
                              : Icons.check_circle_outline,
                          size: SizeConfig.horizontal(5),
                          color: AppColors.blackBackground,
                        )
                      : const SizedBox.shrink())
            ],
          ),
        ],
      ),
    );
  }
}
