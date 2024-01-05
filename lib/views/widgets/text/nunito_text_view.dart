import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/enums.dart';
import '../../../utils/size_config.dart';

class NunitoTextView extends StatelessWidget {
  // constructor
  const NunitoTextView({
    Key? key,
    required this.value,
    this.color,
    this.size,
    this.fontStyle,
    this.fontWeight,
    this.alignText,
    this.overFlow,
    this.textDecoration,
  }) : super(key: key);

  final String value;
  final Color? color;
  final double? size;
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;
  final AlignTextType? alignText;
  final TextOverflow? overFlow;
  final TextDecoration? textDecoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      overflow: overFlow,
      style: GoogleFonts.nunito(
        decoration: textDecoration,
        color: color ?? AppColors.textColor,
        fontSize: size ?? SizeConfig.safeBlockHorizontal * 5,
        fontStyle: fontStyle ?? FontStyle.normal,
        fontWeight: fontWeight ?? FontWeight.w500,
      ),
      textAlign: alignText == AlignTextType.center
          ? TextAlign.center
          : alignText == AlignTextType.right
              ? TextAlign.right
              : TextAlign.left,
    );
  }
}

class WorkSansStyle {
  TextStyle labelStyle() {
    return GoogleFonts.nunito(
      color: Colors.grey,
      fontSize: SizeConfig.safeBlockHorizontal * 3.5,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
    );
  }
}
