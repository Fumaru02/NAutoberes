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
  static Color textColor = AppColors.hex(colorCode: '#505050');
  static Color greenSuccess = AppColors.hex(colorCode: '#1F9941');
  static Color greenDRT = AppColors.hex(colorCode: '#5ABA55');
  static Color cyanBackground = AppColors.hex(colorCode: '#59D2D0');
  static Color cyanBackgroundAppBar = AppColors.hex(colorCode: '#30B1AF');
  static Color greenDark = AppColors.hex(colorCode: '#3bc0bd');
  static Color blueButton = AppColors.hex(colorCode: '#347EC2');
  static Color redAlert = AppColors.hex(colorCode: '#EB6B62');
  static Color black = AppColors.hex(colorCode: '#000000');
  static Color white = AppColors.hex(colorCode: '#FFFFFF');
  static Color greyDisabled = AppColors.hex(colorCode: '#DADADA');
  static Color orangeActive = AppColors.hex(colorCode: '#D37116');
  static Color backgroundColor = AppColors.hex(colorCode: '#EFEFEF');
  static Color backgroundImlyLeading = AppColors.hex(colorCode: '#8D8D8D');
  static Color greyTextDisabled = AppColors.hex(colorCode: '#BBBBBB');

  static Color rippleColor =
      AppColors.hex(colorCode: '#EFEFEF').withOpacity(0.20);
}
