import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/enums.dart';
import '../../../utils/size_config.dart';

class InterTextView extends StatelessWidget {
  // constructor
  const InterTextView({
    super.key,
    required this.value,
    this.color,
    this.size,
    this.maxLines,
    this.fontStyle,
    this.fontWeight,
    this.alignText,
    this.overFlow,
    this.textDecoration,
    this.decorationColor,
  });

  final String value;
  final Color? color;
  final double? size;
  final int? maxLines;
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;
  final AlignTextType? alignText;
  final TextOverflow? overFlow;
  final TextDecoration? textDecoration;
  final Color? decorationColor;
  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      overflow: overFlow,
      maxLines: maxLines,
      style: GoogleFonts.inter(
        decoration: textDecoration,
        decorationColor: decorationColor,
        color: color ?? AppColors.white,
        fontSize: size ?? SizeConfig.safeBlockHorizontal * 5,
        fontStyle: fontStyle ?? FontStyle.normal,
        fontWeight: fontWeight ?? FontWeight.normal,
      ),
      textAlign: alignText == AlignTextType.center
          ? TextAlign.center
          : alignText == AlignTextType.right
              ? TextAlign.right
              : alignText == AlignTextType.justify
                  ? TextAlign.justify
                  : TextAlign.left,
    );
  }
}

class InterStyle {
  TextStyle labelStyle(Color? color) {
    return GoogleFonts.inter(
      color: color ?? Colors.grey,
      fontSize: SizeConfig.safeBlockHorizontal * 3.5,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
    );
  }
}
