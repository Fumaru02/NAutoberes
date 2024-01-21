import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static Color hex({required String colorCode}) {
    final String containHex = colorCode.toUpperCase().replaceAll('#', '');
    String result = '';
    if (colorCode.length == 7) {
      result = 'FF$containHex';
    }

    return Color(int.parse(result, radix: 16));
  }

  // color list
  // main theme color
  static Color textColor = AppColors.hex(colorCode: '#FFFFFF');
  static Color greenSuccess = AppColors.hex(colorCode: '#1F9941');
  static Color greenDRT = AppColors.hex(colorCode: '#5ABA55');
  static Color blackBackground = AppColors.hex(colorCode: '#332941');
  static Color cyanBackgroundAppBar = AppColors.hex(colorCode: '#30B1AF');
  static Color greenDark = AppColors.hex(colorCode: '#3bc0bd');
  static Color goldButton = AppColors.hex(colorCode: '#FFDB61');
  static Color greyButton = AppColors.hex(colorCode: '#5B5B5B');
  static Color redAlert = AppColors.hex(colorCode: '#FF004D');
  static Color black = AppColors.hex(colorCode: '#000000');
  static Color white = AppColors.hex(colorCode: '#FFFFFF');
  static Color greyDisabled = AppColors.hex(colorCode: '#DADADA');
  static Color orangeActive = AppColors.hex(colorCode: '#D37116');
  static Color backgroundColor = AppColors.hex(colorCode: '#EFEFEF');
  static Color backgroundImlyLeading = AppColors.hex(colorCode: '#8D8D8D');
  static Color greyTextDisabled = AppColors.hex(colorCode: '#BBBBBB');
  static Color blueColor = AppColors.hex(colorCode: '#0B60B0');
  static Color pinkColor = AppColors.hex(colorCode: '#FF9BD2');

  static Color rippleColor =
      AppColors.hex(colorCode: '#EFEFEF').withOpacity(0.20);
}
