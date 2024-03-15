import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../controllers/home/home_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/asset_list.dart';
import '../../utils/size_config.dart';
import '../widgets/custom/custom_ripple_button.dart';
import '../widgets/custom/custom_shimmer_placeholder.dart';
import '../widgets/layouts/space_sizer.dart';
import '../widgets/text/inter_text_view.dart';
import 'widgets/automotive_news.dart';
import 'widgets/beresin_menu.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/home_shimmer.dart';
import 'widgets/promo_widget.dart';

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
              child: CustomScrollView(
                  controller: homeController.scrollController,
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildListDelegate(<Widget>[
                        ResponsiveRowColumn(
                            layout: ResponsiveRowColumnType.COLUMN,
                            columnCrossAxisAlignment: CrossAxisAlignment.start,
                            children: <ResponsiveRowColumnItem>[
                              ResponsiveRowColumnItem(
                                  child: Stack(
                                children: <Widget>[
                                  Container(
                                    height: SizeConfig.horizontal(50),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                AssetList.backgroundBubble),
                                            fit: BoxFit.fill),
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(
                                              SizeConfig.horizontal(17)),
                                          bottomRight: Radius.circular(
                                              SizeConfig.horizontal(17)),
                                        ),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              blurRadius: 2,
                                              color: AppColors.greyDisabled,
                                              spreadRadius: 2,
                                              offset: const Offset(0, 2))
                                        ]),
                                  ),
                                  Obx(
                                    () => homeController.isLoading.isTrue
                                        ? const HomeShimmer()
                                        : _wrapperHome(homeController),
                                  ),
                                ],
                              )),
                            ])
                      ]),
                    ),
                    // ignore: prefer_if_elements_to_conditional_expressions

                    SliverGrid.builder(
                        itemCount: homeController.beresinMenuList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4),
                        itemBuilder: (BuildContext context, int index) => Obx(
                              () => homeController.isLoading.isTrue
                                  ? Padding(
                                      padding: EdgeInsets.all(
                                          SizeConfig.horizontal(4)),
                                      child: CustomShimmerPlaceHolder(
                                          width: SizeConfig.horizontal(4)),
                                    )
                                  : BeresinMenu(
                                      onRoute: () => Get.to(
                                          homeController.listRouter[index]),
                                      model:
                                          homeController.beresinMenuList[index],
                                    ),
                            )),

                    SliverList(
                      delegate: SliverChildListDelegate(<Widget>[
                        Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.horizontal(2),
                                left: SizeConfig.horizontal(2)),
                            child: Obx(
                              () => homeController.isLoading.isTrue
                                  ? CustomShimmerPlaceHolder(
                                      borderRadius: 4,
                                      width: SizeConfig.horizontal(10),
                                    )
                                  : InterTextView(
                                      value: homeController
                                          .aboutAutomotiveTitle.value,
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w900,
                                      size: SizeConfig.safeBlockHorizontal * 4),
                            ))
                      ]),
                    ),

                    // ignore: prefer_if_elements_to_conditional_expressions
                    SliverPadding(
                      padding: EdgeInsets.only(
                          top: SizeConfig.horizontal(4),
                          bottom: SizeConfig.horizontal(15)),
                      sliver: Obx(
                        () => homeController.isLoading.isTrue
                            ? SliverToBoxAdapter(
                                child: CustomShimmerPlaceHolder(
                                  width: SizeConfig.horizontal(40),
                                  height: SizeConfig.horizontal(50),
                                ),
                              )
                            : AutomotiveNews(homeController: homeController),
                      ),
                    )
                  ]),
            ));
  }

  ResponsiveRowColumn _wrapperHome(HomeController homeController) {
    return ResponsiveRowColumn(
      layout: ResponsiveRowColumnType.COLUMN,
      columnCrossAxisAlignment: CrossAxisAlignment.start,
      children: <ResponsiveRowColumnItem>[
        ResponsiveRowColumnItem(
            child: CustomAppBarHome(
          homeController: homeController,
        )),
        ResponsiveRowColumnItem(
            child: PromoWidget(homeController: homeController)),
        const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 1)),
        ResponsiveRowColumnItem(
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.horizontal(2)),
            child: InterTextView(
                value: homeController.gridMenuTitle.value,
                color: AppColors.black,
                fontWeight: FontWeight.w900,
                size: SizeConfig.safeBlockHorizontal * 4),
          ),
        )
      ],
    );
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
