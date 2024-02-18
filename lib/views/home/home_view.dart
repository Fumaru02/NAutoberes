import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_row_column.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../controllers/home_controller.dart';
import '../../models/about_automotive/about_automotive_model.dart';
import '../../models/beresin_menu/beresin_menu_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/enums.dart';
import '../../utils/size_config.dart';
import '../widgets/custom/custom_ripple_button.dart';
import '../widgets/layouts/space_sizer.dart';
import '../widgets/text/inter_text_view.dart';
import '../widgets/user/user_info.dart';
import 'about_automotive_detail_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (HomeController homeController) => RefreshIndicator(
              onRefresh: () async {
                await homeController.refreshPage();
              },
              child: CustomScrollView(primary: true, slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(<Widget>[
                    ResponsiveRowColumn(
                        layout: ResponsiveRowColumnType.COLUMN,
                        columnCrossAxisAlignment: CrossAxisAlignment.start,
                        children: <ResponsiveRowColumnItem>[
                          ResponsiveRowColumnItem(
                              child: Container(
                                  height: SizeConfig.horizontal(16),
                                  decoration: BoxDecoration(
                                      color: AppColors.blackBackground,
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            blurRadius: 2,
                                            color: AppColors.greyDisabled,
                                            spreadRadius: 2,
                                            offset: const Offset(0, 2))
                                      ]),
                                  child: const CustomAppBarHome())),
                          const ResponsiveRowColumnItem(
                              child: SpaceSizer(vertical: 1)),
                          ResponsiveRowColumnItem(
                              child:
                                  PromoWidget(homeController: homeController)),
                          const ResponsiveRowColumnItem(
                              child: SpaceSizer(vertical: 1)),
                        ])
                  ]),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(<Widget>[
                    Padding(
                      padding: EdgeInsets.all(SizeConfig.horizontal(2)),
                      child: InterTextView(
                          value: homeController.gridMenuTitle.value,
                          color: AppColors.black,
                          fontWeight: FontWeight.w900,
                          size: SizeConfig.safeBlockHorizontal * 4.5),
                    ),
                  ]),
                ),
                SliverGrid.builder(
                    itemCount: homeController.beresinMenuList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                    itemBuilder: (BuildContext context, int index) =>
                        BeresinMenu(
                          model: homeController.beresinMenuList[index],
                        )),
                SliverList(
                  delegate: SliverChildListDelegate(<Widget>[
                    Padding(
                        padding: EdgeInsets.all(SizeConfig.horizontal(2)),
                        child: InterTextView(
                            value: homeController.aboutAutomotiveTitle.value,
                            color: AppColors.black,
                            fontWeight: FontWeight.w900,
                            size: SizeConfig.safeBlockHorizontal * 4.5))
                  ]),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.horizontal(4),
                      top: SizeConfig.horizontal(4),
                      right: SizeConfig.horizontal(4),
                      bottom: SizeConfig.horizontal(35)),
                  sliver: AutomotiveNews(homeController: homeController),
                ),
              ]),
            ));
  }
}

class BeresinMenu extends StatelessWidget {
  const BeresinMenu({
    super.key,
    required this.model,
  });

  final BeresinMenuModel model;

  @override
  Widget build(BuildContext context) {
    return ResponsiveRowColumn(
      layout: ResponsiveRowColumnType.COLUMN,
      columnMainAxisAlignment: MainAxisAlignment.center,
      children: <ResponsiveRowColumnItem>[
        ResponsiveRowColumnItem(
            child: CachedNetworkImage(
          imageUrl: model.imageUrl,
          width: SizeConfig.horizontal(12),
          height: SizeConfig.horizontal(12),
          fit: BoxFit.fill,
        )),
        const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 0.5)),
        ResponsiveRowColumnItem(
            child: SizedBox(
          width: SizeConfig.horizontal(22),
          child: InterTextView(
            value: model.title,
            alignText: AlignTextType.center,
            color: AppColors.black,
            size: SizeConfig.safeBlockHorizontal * 3.5,
            fontWeight: FontWeight.w500,
          ),
        ))
      ],
    );
  }
}

class PromoWidget extends StatelessWidget {
  const PromoWidget({
    super.key,
    required this.homeController,
  });

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return ResponsiveRowColumn(
        layout: ResponsiveRowColumnType.COLUMN,
        columnCrossAxisAlignment: CrossAxisAlignment.start,
        children: <ResponsiveRowColumnItem>[
          ResponsiveRowColumnItem(
              child: Padding(
                  padding: EdgeInsets.only(left: SizeConfig.horizontal(2)),
                  child: InterTextView(
                      value: homeController.promoTitle.value,
                      color: AppColors.black,
                      fontWeight: FontWeight.w900,
                      size: SizeConfig.safeBlockHorizontal * 4.5))),
          const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 1)),
          ResponsiveRowColumnItem(
              child: PromoSlideView(homeController: homeController)),
          ResponsiveRowColumnItem(
              child: AnimatedDotPromoSlide(homeController: homeController)),
        ]);
  }
}

class CustomAppBarHome extends StatelessWidget {
  const CustomAppBarHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveRowColumn(
      layout: ResponsiveRowColumnType.ROW,
      rowPadding: EdgeInsets.symmetric(
          horizontal: SizeConfig.horizontal(2),
          vertical: SizeConfig.horizontal(2)),
      rowSpacing: 8,
      children: <ResponsiveRowColumnItem>[
        ResponsiveRowColumnItem(
            child: ResponsiveRowColumn(
                layout: ResponsiveRowColumnType.COLUMN,
                columnCrossAxisAlignment: CrossAxisAlignment.start,
                columnMainAxisAlignment: MainAxisAlignment.center,
                children: <ResponsiveRowColumnItem>[
              ResponsiveRowColumnItem(
                  child: InterTextView(
                      value: 'Hi,',
                      size: SizeConfig.safeBlockHorizontal * 3.5,
                      fontWeight: FontWeight.bold,
                      alignText: AlignTextType.left)),
              ResponsiveRowColumnItem(
                  child: Username(
                color: AppColors.white,
                size: 5,
              )),
            ])),
        const ResponsiveRowColumnItem(child: Spacer()),
        ResponsiveRowColumnItem(
          child: Icon(
            Icons.favorite,
            color: AppColors.white,
            size: SizeConfig.horizontal(8),
          ),
        ),
        const ResponsiveRowColumnItem(child: SpaceSizer(horizontal: 1)),
        ResponsiveRowColumnItem(
          child: Icon(
            Icons.notifications_sharp,
            color: AppColors.white,
            size: SizeConfig.horizontal(8),
          ),
        )
      ],
    );
  }
}

class AutomotiveNews extends StatelessWidget {
  const AutomotiveNews({super.key, required this.homeController});

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) => AboutAutomotiveList(
                  model: homeController.aboutAutomotiveList[index],
                ),
            childCount: homeController.aboutAutomotiveList.length));
  }
}

class AnimatedDotPromoSlide extends StatelessWidget {
  const AnimatedDotPromoSlide({
    super.key,
    required this.homeController,
  });

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
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
              activeDotColor: AppColors.gold)),
    ));
  }
}

class PromoSlideView extends StatelessWidget {
  const PromoSlideView({
    super.key,
    required this.homeController,
  });

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        carouselController: homeController.carouselController,
        options: CarouselOptions(
            autoPlayAnimationDuration: const Duration(milliseconds: 1500),
            autoPlay: true,
            aspectRatio: 9 / 4,
            enlargeCenterPage: true,
            onPageChanged: (int index, CarouselPageChangedReason reason) {
              homeController.currentDot(index);
            }),
        itemCount: homeController.promoImage.length,
        itemBuilder: (BuildContext context, int index, int realIndex) => Center(
            child: CustomRippleButton(
                radius: 0,
                onTap: () {},
                child: ClipRRect(
                    borderRadius: BorderRadius.all(
                        Radius.circular(SizeConfig.horizontal(1))),
                    child: homeController.promoImage.isEmpty
                        ? const CircularProgressIndicator()
                        : CachedNetworkImage(
                            maxWidthDiskCache: 350,
                            maxHeightDiskCache: 250,
                            imageUrl: homeController.promoImage[index],
                            fit: BoxFit.fill,
                            width: SizeConfig.horizontal(100),
                            height: SizeConfig.horizontal(100))))));
  }
}

class AboutAutomotiveList extends StatelessWidget {
  const AboutAutomotiveList({
    super.key,
    required this.model,
  });

  final AboutAutomotiveModel model;
  @override
  Widget build(BuildContext context) {
    return ResponsiveRowColumn(
      layout: ResponsiveRowColumnType.COLUMN,
      children: <ResponsiveRowColumnItem>[
        ResponsiveRowColumnItem(
            child: Container(
                margin: EdgeInsets.all(SizeConfig.horizontal(2)),
                decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 2),
                          color: AppColors.greyDisabled)
                    ],
                    borderRadius: BorderRadius.all(
                        Radius.circular(SizeConfig.horizontal(2))),
                    color: AppColors.white),
                child: ResponsiveRowColumn(
                  layout: ResponsiveRowColumnType.COLUMN,
                  columnPadding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.horizontal(4)),
                  columnCrossAxisAlignment: CrossAxisAlignment.start,
                  children: <ResponsiveRowColumnItem>[
                    const ResponsiveRowColumnItem(
                        child: SpaceSizer(vertical: 1.5)),
                    ResponsiveRowColumnItem(
                        child: InterTextView(
                            value: model.title,
                            color: AppColors.black,
                            fontWeight: FontWeight.w900,
                            size: SizeConfig.safeBlockHorizontal * 4.5)),
                    const ResponsiveRowColumnItem(
                        child: SpaceSizer(vertical: 1)),
                    ResponsiveRowColumnItem(
                        child: Center(
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(
                                        SizeConfig.horizontal(1))),
                                    border: Border.all(
                                        width: SizeConfig.horizontal(0.1))),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            SizeConfig.horizontal(1))),
                                    child: Hero(
                                        tag: model.id,
                                        child: CachedNetworkImage(
                                            maxHeightDiskCache: 300,
                                            maxWidthDiskCache: 300,
                                            imageUrl: model.imageUrl,
                                            width: SizeConfig.horizontal(70),
                                            height: SizeConfig.horizontal(50),
                                            fit: BoxFit.fill)))))),
                    const ResponsiveRowColumnItem(
                        child: SpaceSizer(vertical: 1)),
                    ResponsiveRowColumnItem(
                        child: Padding(
                            padding: EdgeInsets.only(
                                right: SizeConfig.horizontal(4)),
                            child: InterTextView(
                                maxLines: 3,
                                value: model.source,
                                color: AppColors.greyTextDisabled,
                                alignText: AlignTextType.left,
                                size: SizeConfig.safeBlockHorizontal * 4))),
                    ResponsiveRowColumnItem(
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                                onPressed: () =>
                                    Get.to(AboutAutomotiveDetailView(
                                      model: model,
                                    )),
                                child: InterTextView(
                                    value: 'More details',
                                    color: AppColors.black,
                                    textDecoration: TextDecoration.underline,
                                    size:
                                        SizeConfig.safeBlockHorizontal * 3)))),
                  ],
                )))
      ],
    );
  }
}
