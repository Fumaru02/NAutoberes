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
      builder: (HomeController homeController) => ResponsiveRowColumn(
          layout: ResponsiveRowColumnType.COLUMN,
          columnCrossAxisAlignment: CrossAxisAlignment.start,
          children: <ResponsiveRowColumnItem>[
            ResponsiveRowColumnItem(
                child: Container(
              height: SizeConfig.horizontal(20),
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
                rowPadding:
                    EdgeInsets.symmetric(horizontal: SizeConfig.horizontal(4)),
                rowSpacing: 8,
                children: <ResponsiveRowColumnItem>[
                  ResponsiveRowColumnItem(
                      child: CircleAvatar(
                    foregroundColor: AppColors.white,
                    minRadius: 25,
                    child: Icon(
                      Icons.person,
                      color: AppColors.black,
                      size: 40,
                    ),
                  )),
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
                          alignText: AlignTextType.left,
                        ),
                      ),
                      ResponsiveRowColumnItem(
                        child: RobotoTextView(
                          value: homeController.username.value,
                          size: SizeConfig.safeBlockHorizontal * 3.5,
                          fontWeight: FontWeight.bold,
                          alignText: AlignTextType.left,
                        ),
                      ),
                      ResponsiveRowColumnItem(
                        child: homeController.userStatus.value == 'Founder'
                            ? Container(
                                width: SizeConfig.horizontal(14),
                                decoration: BoxDecoration(
                                    color: AppColors.goldButton,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            SizeConfig.horizontal(2)))),
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
                                alignText: AlignTextType.left,
                              ),
                      ),
                    ],
                  )),
                  const ResponsiveRowColumnItem(child: Spacer()),
                  const ResponsiveRowColumnItem(
                      child: AutoBeresLogo(
                    width: 20,
                    height: 20,
                  ))
                ],
              ),
            )),
            const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 1)),
            ResponsiveRowColumnItem(
                child: ResponsiveRowColumn(
                    layout: ResponsiveRowColumnType.COLUMN,
                    columnCrossAxisAlignment: CrossAxisAlignment.start,
                    columnPadding:
                        EdgeInsets.only(left: SizeConfig.horizontal(2)),
                    children: <ResponsiveRowColumnItem>[
                  ResponsiveRowColumnItem(
                    child: RobotoTextView(
                      value: 'SPECIAL OFFERS',
                      color: AppColors.black,
                      fontWeight: FontWeight.w900,
                      size: SizeConfig.safeBlockHorizontal * 4.5,
                    ),
                  ),
                  const ResponsiveRowColumnItem(
                      child: SpaceSizer(
                    vertical: 1,
                  )),
                  ResponsiveRowColumnItem(
                      child: CarouselSlider.builder(
                          carouselController: homeController.carouselController,
                          options: CarouselOptions(
                            autoPlay: true,
                            aspectRatio: 9 / 4,
                            enlargeCenterPage: true,
                            onPageChanged:
                                (int index, CarouselPageChangedReason reason) {
                              homeController.currentDot(index);
                            },
                          ),
                          itemCount: homeController.imageUrl.length,
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

                                    // child: Image.asset(
                                    //   item,
                                    //   fit: BoxFit.cover,
                                    //   width: SizeConfig.horizontal(110),
                                    // ),
                                    child: homeController.imageUrl.isEmpty
                                        ? const CircularProgressIndicator()
                                        : CachedNetworkImage(
                                            imageUrl:
                                                homeController.imageUrl[index],
                                            fit: BoxFit.fill,
                                            width: SizeConfig.horizontal(100),
                                            height: SizeConfig.horizontal(100),
                                          ),
                                  ),
                                ),
                              )))
                ])),
            const ResponsiveRowColumnItem(
                child: SpaceSizer(
              vertical: 0.5,
            )),
            ResponsiveRowColumnItem(
                child: Center(
              child: Obx(
                () => AnimatedSmoothIndicator(
                  activeIndex: homeController.currentDot.value,
                  count: 3,
                  effect: JumpingDotEffect(
                    jumpScale: 0.5,
                    verticalOffset: 15,
                    dotColor: AppColors.greyDisabled,
                    spacing: SizeConfig.horizontal(4.5),
                    dotHeight: SizeConfig.horizontal(2.5),
                    dotWidth: SizeConfig.horizontal(2.5),
                    activeDotColor: AppColors.black,
                  ),
                ),
              ),
            )),
          ]),
    );
  }
}
