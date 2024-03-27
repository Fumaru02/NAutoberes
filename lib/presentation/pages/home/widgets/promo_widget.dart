import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../widgets/layouts/space_sizer.dart';
import '../home_view.dart';
import 'animated_dot_promo_slide.dart';

class PromoWidget extends StatelessWidget {
  const PromoWidget({
    super.key,
    required this.carouselController,
  });

  final CarouselController carouselController;

  @override
  Widget build(BuildContext context) {
    return ResponsiveRowColumn(
        layout: ResponsiveRowColumnType.COLUMN,
        columnCrossAxisAlignment: CrossAxisAlignment.start,
        children: <ResponsiveRowColumnItem>[
          const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 5)),
          ResponsiveRowColumnItem(
              child: PromoSlideView(
            carouselController: carouselController,
          )),
          const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 1)),
          const ResponsiveRowColumnItem(child: AnimatedDotPromoSlide()),
        ]);
  }
}
