import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../controllers/home/home_controller.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/size_config.dart';

class AnimatedDotPromoSlide extends StatelessWidget {
  const AnimatedDotPromoSlide({
    super.key,
    required this.homeController,
  });

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Obx(() => AnimatedSmoothIndicator(
            activeIndex: homeController.currentDot.value,
            count: homeController.promoImage.length,
            effect: ExpandingDotsEffect(
                dotColor: AppColors.greyDisabled,
                spacing: SizeConfig.horizontal(3),
                dotHeight: SizeConfig.horizontal(2.5),
                dotWidth: SizeConfig.horizontal(2.5),
                activeDotColor: AppColors.blueDark))));
  }
}
