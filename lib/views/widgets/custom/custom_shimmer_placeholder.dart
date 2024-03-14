import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/size_config.dart';

class CustomShimmerPlaceHolder extends StatelessWidget {
  const CustomShimmerPlaceHolder({
    required this.width,
    this.height,
    this.borderRadius,
    this.shape,
    this.baseColor,
    this.lightColor,
    super.key,
  });

  final double width;
  final double? height;
  final double? borderRadius;
  final BoxShape? shape;
  final Color? baseColor;
  final Color? lightColor;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Shimmer.fromColors(
      baseColor: baseColor ?? AppColors.linearCurverBegin,
      highlightColor: lightColor ?? AppColors.shimmerHightlight,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
              Radius.circular(borderRadius ?? SizeConfig.horizontal(2))),
          shape: shape ?? BoxShape.rectangle,
        ),
        height: height ?? SizeConfig.vertical(2),
        width: width,
      ),
    );
  }
}
