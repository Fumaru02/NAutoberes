import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_row_column.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../controllers/home_controller.dart';
import '../../models/about_automotive/about_automotive_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/enums.dart';
import '../../utils/size_config.dart';
import '../widgets/custom/custom_ripple_button.dart';
import '../widgets/layouts/space_sizer.dart';
import '../widgets/logo/autoberes_logo.dart';
import '../widgets/text/roboto_text_view.dart';
import '../widgets/user/user_info.dart';
import 'about_automotive_detail_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (HomeController homeController) => homeView(homeController));
  }

  Widget homeView(HomeController homeController) {
    const String testString =
        'aowkdoakowdkaokdoawdawdokaowkdoakowdkoakwdokaodkwokdowkwdok';
    return RefreshIndicator(
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
                ResponsiveRowColumnItem(child: appBarHome(homeController)),
                const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 1)),
                ResponsiveRowColumnItem(child: promoSlider(homeController)),
                const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 1)),
              ])
        ])),
        SliverList(
          delegate: SliverChildListDelegate(<Widget>[
            RobotoTextView(
                value: homeController.aboutAutomotiveTitle.value,
                color: AppColors.black,
                fontWeight: FontWeight.w900,
                size: SizeConfig.safeBlockHorizontal * 4.5)
          ]),
        ),
        SliverPadding(
          padding: EdgeInsets.only(
              left: SizeConfig.horizontal(4),
              top: SizeConfig.horizontal(4),
              right: SizeConfig.horizontal(4),
              bottom: SizeConfig.horizontal(35)),
          sliver: aboutAutomotiveList(homeController, testString),
        ),
      ]),
    );
  }

  SliverList aboutAutomotiveList(
      HomeController homeController, String testString) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) => AboutAutomotiveList(
                  model: homeController.aboutAutomotiveList[index],
                ),
            childCount: homeController.aboutAutomotiveList.length));
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
              activeDotColor: AppColors.black)),
    ));
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
                      size: SizeConfig.safeBlockHorizontal * 4.5))),
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
                                      Radius.circular(
                                          SizeConfig.horizontal(1))),
                                  child: homeController.promoImage.isEmpty
                                      ? const CircularProgressIndicator()
                                      : CachedNetworkImage(
                                          maxWidthDiskCache: 350,
                                          maxHeightDiskCache: 250,
                                          imageUrl:
                                              homeController.promoImage[index],
                                          fit: BoxFit.fill,
                                          width: SizeConfig.horizontal(100),
                                          height:
                                              SizeConfig.horizontal(100))))))),
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
          const ResponsiveRowColumnItem(child: UserPicture()),
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
                const ResponsiveRowColumnItem(child: Username()),
                const ResponsiveRowColumnItem(child: UserStatus())
              ])),
          const ResponsiveRowColumnItem(child: Spacer()),
          const ResponsiveRowColumnItem(
              child: AutoBeresLogo(width: 20, height: 20))
        ],
      ),
    );
  }
}

class AboutAutomotiveList extends StatelessWidget {
  const AboutAutomotiveList({
    Key? key,
    required this.model,
  }) : super(key: key);

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
                        child: RobotoTextView(
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
                            child: RobotoTextView(
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
                                child: RobotoTextView(
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
