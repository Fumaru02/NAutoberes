import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../controllers/login_controller.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/size_config.dart';
import '../text/inter_text_view.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.title,
    this.height,
    this.titleFontWeight,
    this.width,
    this.borderRadius,
    this.labelText,
    this.hintText,
    this.textColor,
    this.hintTextColor,
    this.isPasswordField = false,
    this.suffixIcon,
    this.onChanged,
    this.autofillHint,
    this.textInputAction,
    this.contentPadding,
    this.prefixIcon,
    this.controller,
    this.passwordController,
    this.textAlignVertical,
    this.onFieldSubmitted,
    this.minLines,
    this.maxLength,
    this.maxLines,
    this.focusNode,
    this.keyboardType,
  });
  final String title;
  final double? height;
  final FontWeight? titleFontWeight;
  final double? width;
  final double? borderRadius;
  final String? labelText;
  final String? hintText;
  final Color? textColor;
  final Color? hintTextColor;
  final bool? isPasswordField;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final Iterable<String>? autofillHint;
  final TextInputAction? textInputAction;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final TextEditingController? passwordController;
  final TextAlignVertical? textAlignVertical;
  final Function(String)? onFieldSubmitted;
  final int? minLines;
  final int? maxLength;
  final int? maxLines;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());
    return ResponsiveRowColumn(
        layout: ResponsiveRowColumnType.COLUMN,
        columnSpacing: 4,
        columnCrossAxisAlignment: CrossAxisAlignment.start,
        children: <ResponsiveRowColumnItem>[
          ResponsiveRowColumnItem(
              child: title == ''
                  ? const SizedBox.shrink()
                  : InterTextView(
                      value: title,
                      size: SizeConfig.safeBlockHorizontal * 4,
                      fontWeight: titleFontWeight ?? FontWeight.w500,
                      color: textColor ?? AppColors.black)),
          ResponsiveRowColumnItem(
              child: SizedBox(
                  width: SizeConfig.horizontal(width ?? 80),
                  height: height ?? SizeConfig.vertical(7),
                  // ignore: use_if_null_to_convert_nulls_to_bools
                  child: isPasswordField == true
                      ? Obx(
                          () => TextFormField(
                              autofillHints: autofillHint,
                              minLines: minLines,
                              controller: controller,
                              focusNode: focusNode,
                              onChanged: onChanged,
                              keyboardType: TextInputType.text,
                              textInputAction: textInputAction,
                              // ignore: avoid_bool_literals_in_conditional_expressions, use_if_null_to_convert_nulls_to_bools
                              obscureText: isPasswordField == true
                                  ? loginController.isObscurePassword.value =
                                      loginController.isObscurePassword.value
                                  : false,
                              decoration: InputDecoration(
                                  prefixIcon: prefixIcon,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      loginController.isObscurePassword.value =
                                          !loginController
                                              .isObscurePassword.value;
                                    },
                                    icon: Icon(loginController
                                            .isObscurePassword.isFalse
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    color: loginController
                                            .isObscurePassword.isFalse
                                        ? AppColors.black
                                        : AppColors.greyDisabled,
                                  ),
                                  fillColor: AppColors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(SizeConfig.horizontal(
                                              borderRadius ?? 4)))),
                                  labelText: hintText,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  labelStyle:
                                      InterStyle().labelStyle(hintTextColor))),
                        )
                      : TextFormField(
                          autofillHints: autofillHint,
                          minLines: minLines,
                          controller: controller,
                          textAlignVertical: textAlignVertical,
                          focusNode: focusNode,
                          maxLines: maxLines,
                          textInputAction: textInputAction,
                          onChanged: onChanged,
                          onFieldSubmitted: onFieldSubmitted,
                          keyboardType: keyboardType ?? TextInputType.text,
                          // ignore: avoid_bool_literals_in_conditional_expressions, use_if_null_to_convert_nulls_to_bools
                          decoration: InputDecoration(
                              prefixIcon: prefixIcon,
                              suffixIcon: suffixIcon,
                              fillColor: AppColors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(SizeConfig.horizontal(
                                          borderRadius ?? 4)))),
                              labelText: labelText,
                              hintText: hintText,
                              hintStyle: InterStyle().labelStyle(hintTextColor),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelStyle:
                                  InterStyle().labelStyle(hintTextColor)))))
        ]);
  }
}
