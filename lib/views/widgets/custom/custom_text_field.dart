import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_row_column.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/size_config.dart';
import '../text/worksans_text_view.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.title,
    this.height,
    this.width,
    required this.hintText,
    this.errorText,
    this.textColor,
    this.isPasswordField = false,
    this.suffixIcon,
    this.onChanged,
    this.autofillHint,
    this.controller,
    this.passwordController,
    this.minLines,
  }) : super(key: key);
  final String title;
  final double? height;
  final double? width;
  final String hintText;
  final String? errorText;
  final Color? textColor;
  final bool? isPasswordField;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final Iterable<String>? autofillHint;

  final TextEditingController? controller;
  final TextEditingController? passwordController;
  final int? minLines;

  @override
  Widget build(BuildContext context) {
    return ResponsiveRowColumn(
        layout: ResponsiveRowColumnType.COLUMN,
        columnSpacing: 4,
        columnCrossAxisAlignment: CrossAxisAlignment.start,
        children: <ResponsiveRowColumnItem>[
          ResponsiveRowColumnItem(
              child: WorkSansTextView(
                  value: title,
                  size: SizeConfig.safeBlockHorizontal * 4,
                  fontWeight: FontWeight.w500,
                  color: textColor ?? AppColors.textColor)),
          ResponsiveRowColumnItem(
              child: SizedBox(
                  width: SizeConfig.horizontal(width ?? 90),
                  height: SizeConfig.vertical(height ?? 5.5),
                  // ignore: use_if_null_to_convert_nulls_to_bools
                  child: TextFormField(
                      autofillHints: autofillHint,
                      minLines: minLines,
                      controller: controller,
                      onChanged: onChanged,
                      keyboardType: TextInputType.text,
                      // ignore: avoid_bool_literals_in_conditional_expressions, use_if_null_to_convert_nulls_to_bools
                      obscureText: true,
                      decoration: InputDecoration(
                          errorText: errorText,
                          suffixIcon: Icon(
                            Icons.visibility_off,
                            color: AppColors.greyDisabled,
                          ),
                          fillColor: AppColors.white,
                          filled: true,
                          border: const OutlineInputBorder(),
                          labelText: hintText,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelStyle: WorkSansStyle().labelStyle()))))
        ]);
  }
}
