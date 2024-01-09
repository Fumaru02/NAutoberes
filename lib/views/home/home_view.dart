import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_row_column.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../controllers/home_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/enums.dart';
import '../../utils/size_config.dart';
import '../widgets/custom/custom_ripple_button.dart';
import '../widgets/layouts/space_sizer.dart';
import '../widgets/logo/autoberes_logo.dart';
import '../widgets/text/roboto_text_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (HomeController homeController) => homeView(homeController),
    );
  }

  Widget homeView(HomeController homeController) {
    return CustomScrollView(primary: true, slivers: [
      SliverList(
        delegate: SliverChildListDelegate([
          ResponsiveRowColumn(
              layout: ResponsiveRowColumnType.COLUMN,
              columnCrossAxisAlignment: CrossAxisAlignment.start,
              children: <ResponsiveRowColumnItem>[
                ResponsiveRowColumnItem(child: appBarHome(homeController)),
                const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 1)),
                ResponsiveRowColumnItem(child: promoSlider(homeController)),
                const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 1)),
                ResponsiveRowColumnItem(child: contentList(homeController)),
              ]),
        ]),
      ),
    ]);
  }

  Widget contentList(HomeController homeController) {
    return ResponsiveRowColumn(
      layout: ResponsiveRowColumnType.COLUMN,
      columnCrossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ResponsiveRowColumnItem(
            child: Padding(
          padding: EdgeInsets.only(left: SizeConfig.horizontal(2)),
          child: RobotoTextView(
              value: homeController.aboutAutomotive.value,
              color: AppColors.black,
              fontWeight: FontWeight.w900,
              size: SizeConfig.safeBlockHorizontal * 4.5),
        )),
        ResponsiveRowColumnItem(
          child: Container(
            margin: EdgeInsets.only(
                bottom: SizeConfig.horizontal(25),
                left: SizeConfig.horizontal(6),
                right: SizeConfig.horizontal(6)),
            height: SizeConfig.screenHeight,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: homeController.contentImg.length,
              itemBuilder: (BuildContext context, int index) =>
                  ResponsiveRowColumn(
                layout: ResponsiveRowColumnType.COLUMN,
                children: [
                  ResponsiveRowColumnItem(
                      child: Container(
                          height: SizeConfig.horizontal(90),
                          color: AppColors.greenDRT,
                          child: CachedNetworkImage(
                              imageUrl: homeController.contentImg[index],
                              fit: BoxFit.fill))),
                  ResponsiveRowColumnItem(
                      child: Obx(() => RobotoTextView(
                            value: homeController.contentTitle[index],
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                          ))),
                  const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 2)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget promoSliderDotIndicator(HomeController homeController) {
    return Center(
      child: Obx(
        () => AnimatedSmoothIndicator(
          activeIndex: homeController.currentDot.value,
          count: homeController.promoImage.length,
          effect: JumpingDotEffect(
            jumpScale: 0.5,
            verticalOffset: 15,
            dotColor: AppColors.greyDisabled,
            spacing: SizeConfig.horizontal(4),
            dotHeight: SizeConfig.horizontal(2),
            dotWidth: SizeConfig.horizontal(2),
            activeDotColor: AppColors.black,
          ),
        ),
      ),
    );
  }

  Widget promoSlider(HomeController homeController) {
    return ResponsiveRowColumn(
        layout: ResponsiveRowColumnType.COLUMN,
        columnCrossAxisAlignment: CrossAxisAlignment.start,
        children: <ResponsiveRowColumnItem>[
          ResponsiveRowColumnItem(
              child: Padding(
            padding: EdgeInsets.only(left: SizeConfig.horizontal(2)),
            child: RobotoTextView(
                value: homeController.promoTitle.value,
                color: AppColors.black,
                fontWeight: FontWeight.w900,
                size: SizeConfig.safeBlockHorizontal * 4.5),
          )),
          const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 1)),
          ResponsiveRowColumnItem(
              child: CarouselSlider.builder(
                  carouselController: homeController.carouselController,
                  options: CarouselOptions(
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 1500),
                      autoPlay: true,
                      aspectRatio: 9 / 4,
                      enlargeCenterPage: true,
                      onPageChanged:
                          (int index, CarouselPageChangedReason reason) {
                        homeController.currentDot(index);
                      }),
                  itemCount: homeController.promoImage.length,
                  itemBuilder: (BuildContext context, int index,
                          int realIndex) =>
                      Center(
                        child: CustomRippleButton(
                            radius: 0,
                            onTap: () {},
                            child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(SizeConfig.horizontal(1))),
                                child: homeController.promoImage.isEmpty
                                    ? const CircularProgressIndicator()
                                    : CachedNetworkImage(
                                        imageUrl:
                                            homeController.promoImage[index],
                                        fit: BoxFit.fill,
                                        width: SizeConfig.horizontal(100),
                                        height: SizeConfig.horizontal(100)))),
                      ))),
          ResponsiveRowColumnItem(
              child: promoSliderDotIndicator(homeController)),
        ]);
  }

  Widget appBarHome(HomeController homeController) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.blackBackground,
          boxShadow: <BoxShadow>[
            BoxShadow(
                blurRadius: 2,
                color: AppColors.greyDisabled,
                spreadRadius: 2,
                offset: const Offset(0, 2))
          ]),
      child: ResponsiveRowColumn(
        layout: ResponsiveRowColumnType.ROW,
        rowPadding: EdgeInsets.symmetric(horizontal: SizeConfig.horizontal(2)),
        rowSpacing: 8,
        children: <ResponsiveRowColumnItem>[
          ResponsiveRowColumnItem(
              child: CircleAvatar(
                  foregroundColor: AppColors.white,
                  minRadius: 25,
                  child: Icon(Icons.person, color: AppColors.black, size: 40))),
          ResponsiveRowColumnItem(
              child: ResponsiveRowColumn(
                  layout: ResponsiveRowColumnType.COLUMN,
                  columnCrossAxisAlignment: CrossAxisAlignment.start,
                  columnMainAxisAlignment: MainAxisAlignment.center,
                  children: <ResponsiveRowColumnItem>[
                ResponsiveRowColumnItem(
                    child: RobotoTextView(
                        value: 'Hi,',
                        size: SizeConfig.safeBlockHorizontal * 3.5,
                        fontWeight: FontWeight.bold,
                        alignText: AlignTextType.left)),
                ResponsiveRowColumnItem(
                    child: RobotoTextView(
                        value: homeController.username.value,
                        size: SizeConfig.safeBlockHorizontal * 3.5,
                        fontWeight: FontWeight.bold,
                        alignText: AlignTextType.left)),
                ResponsiveRowColumnItem(
                    child: homeController.userStatus.value != 'User'
                        ? Container(
                            padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.horizontal(0.5),
                                horizontal: SizeConfig.horizontal(2)),
                            decoration: BoxDecoration(
                                color: AppColors.goldButton,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(SizeConfig.horizontal(2)))),
                            child: Center(
                              child: RobotoTextView(
                                color: AppColors.black,
                                value: homeController.userStatus.value,
                                size: SizeConfig.safeBlockHorizontal * 3,
                                alignText: AlignTextType.left,
                              ),
                            ),
                          )
                        : RobotoTextView(
                            value: homeController.userStatus.value,
                            size: SizeConfig.safeBlockHorizontal * 3,
                            alignText: AlignTextType.left))
              ])),
          const ResponsiveRowColumnItem(child: Spacer()),
          const ResponsiveRowColumnItem(
              child: AutoBeresLogo(width: 20, height: 20))
        ],
      ),
    );
  }
}
