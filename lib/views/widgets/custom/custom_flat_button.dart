import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/size_config.dart';
import 'custom_ripple_button.dart';

class CustomFlatButton extends StatelessWidget {
  const CustomFlatButton({
    Key? key,
    this.textColor,
    this.textColorLoading,
    this.backgroundColor,
    this.borderColor,
    this.colorIconImage,
    this.textSize,
    this.height,
    this.width,
    this.iconSize,
    this.radius,
    this.image,
    required this.text,
    this.subText = '',
    this.loading = false,
    this.gradientColor,
    required this.onTap,
  }) : super(key: key);

//Color
  final Color? textColor;
  final Color? textColorLoading;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? colorIconImage;
//Double
  final double? textSize;
  final double? height;
  final double? width;
  final double? iconSize;
  final double? radius;
//String
  final String? image;
  final String text;
  final String subText;
//Other
  final bool loading;
  final Gradient? gradientColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: width ?? SizeConfig.horizontal(90),
      height: height ?? SizeConfig.vertical(6),
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(color: Colors.grey, offset: Offset(0, 2), blurRadius: 4)
          ],
          border: loading
              ? null
              : Border.all(
                  color: borderColor ?? backgroundColor ?? AppColors.blueButton,
                ),
          gradient: loading ? null : gradientColor,
          borderRadius:
              BorderRadius.circular(SizeConfig.horizontal(radius ?? 10)),
          color: loading
              ? AppColors.greyDisabled
              : backgroundColor ?? AppColors.blueButton),
      child: CustomRippleButton(
        onTap: () {
          loading ? _emptyAction() : onTap();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (loading) const SizedBox.shrink() else _buildWrapper(),
            if (loading)
              SizedBox(
                  width: SizeConfig.horizontal(5),
                  height: SizeConfig.horizontal(5),
                  child: const CircularProgressIndicator())
            else
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    text,
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.horizontal(textSize ?? 5),
                        color: loading
                            ? textColorLoading ?? AppColors.white
                            : textColor ?? Colors.white),
                  ),
                  if (subText == null || subText == '')
                    const SizedBox.shrink()
                  else
                    Text(subText,
                        style: GoogleFonts.nunito(
                            fontSize: SizeConfig.horizontal(textSize ?? 3),
                            color: loading
                                ? textColorLoading ?? AppColors.white
                                : textColor ?? Colors.white)),
                ],
              )
          ],
        ),
      ),
    );
  }

  Widget _buildWrapper() {
    return Builder(
      builder: (_) {
        if (image != null) {
          return Container(
            margin: EdgeInsets.only(right: SizeConfig.horizontal(2)),
            child: Image.asset(
              image!,
              height: SizeConfig.vertical(iconSize ?? 4),
              color: colorIconImage ?? AppColors.white,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  dynamic _emptyAction() {
    return null;
  }
}
