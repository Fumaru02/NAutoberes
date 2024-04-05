import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/size_config.dart';
import '../../../blocs/home/home_bloc.dart';

class AnimatedDotPromoSlide extends StatelessWidget {
  const AnimatedDotPromoSlide({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: BlocBuilder<HomeBloc, HomeState>(
      builder: (_, HomeState state) {
        return AnimatedSmoothIndicator(
            activeIndex: state.currentDot,
            count: state.promoImage.length,
            effect: ExpandingDotsEffect(
                dotColor: AppColors.greyDisabled,
                spacing: SizeConfig.horizontal(3),
                dotHeight: SizeConfig.horizontal(2.5),
                dotWidth: SizeConfig.horizontal(2.5),
                activeDotColor: AppColors.blueDark));
      },
    ));
  }
}
