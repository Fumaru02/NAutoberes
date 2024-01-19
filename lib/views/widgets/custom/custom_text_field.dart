import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_row_column.dart';

import '../../../controllers/login_controller.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/size_config.dart';
import '../text/roboto_text_view.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.title,
    this.height,
    this.width,
    required this.hintText,
    this.textColor,
    this.isPasswordField = false,
    this.suffixIcon,
    this.onChanged,
    this.autofillHint,
    this.textInputAction,
    this.prefixIcon,
    this.controller,
    this.passwordController,
    this.minLines,
  });
  final String title;
  final double? height;
  final double? width;
  final String hintText;
  final Color? textColor;
  final bool? isPasswordField;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final Iterable<String>? autofillHint;
  final TextInputAction? textInputAction;

  final Widget? prefixIcon;
  final TextEditingController? controller;
  final TextEditingController? passwordController;
  final int? minLines;

  @override
  Widget build(BuildContext context) {
    final FocusNode focus = FocusNode();
    final LoginController loginController = Get.put(LoginController());
    return ResponsiveRowColumn(
        layout: ResponsiveRowColumnType.COLUMN,
        columnSpacing: 4,
        columnCrossAxisAlignment: CrossAxisAlignment.start,
        children: <ResponsiveRowColumnItem>[
          ResponsiveRowColumnItem(
              child: RobotoTextView(
                  value: title,
                  size: SizeConfig.safeBlockHorizontal * 4,
                  fontWeight: FontWeight.w500,
                  color: textColor ?? AppColors.white)),
          ResponsiveRowColumnItem(
              child: SizedBox(
                  width: SizeConfig.horizontal(width ?? 90),
                  height: SizeConfig.vertical(height ?? 8),
                  // ignore: use_if_null_to_convert_nulls_to_bools
                  child: isPasswordField == true
                      ? Obx(
                          () => TextFormField(
                              autofillHints: autofillHint,
                              minLines: minLines,
                              controller: controller,
                              focusNode: focus,
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
                                  border: const OutlineInputBorder(),
                                  labelText: hintText,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  labelStyle: WorkSansStyle().labelStyle())),
                        )
                      : TextFormField(
                          autofillHints: autofillHint,
                          minLines: minLines,
                          controller: controller,
                          focusNode: focus,
                          textInputAction: textInputAction,
                          onChanged: onChanged,
                          keyboardType: TextInputType.text,
                          // ignore: avoid_bool_literals_in_conditional_expressions, use_if_null_to_convert_nulls_to_bools
                          decoration: InputDecoration(
                              prefixIcon: prefixIcon,
                              fillColor: AppColors.white,
                              filled: true,
                              border: const OutlineInputBorder(),
                              labelText: hintText,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelStyle: WorkSansStyle().labelStyle()))))
        ]);
  }
}
