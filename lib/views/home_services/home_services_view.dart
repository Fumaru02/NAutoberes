import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../controllers/home_services_controller.dart';
import '../../models/brands_car/brands_car_model.dart';
import '../../models/list_mechanics/list_mechanics_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/size_config.dart';
import '../widgets/custom/custom_ripple_button.dart';
import '../widgets/custom/custom_shimmer_placeholder.dart';
import '../widgets/custom/custom_text_field.dart';
import '../widgets/layouts/space_sizer.dart';
import '../widgets/text/inter_text_view.dart';
import 'home_services_about.dart';

class HomeServicesView extends StatelessWidget {
  const HomeServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeServicesController>(
        init: HomeServicesController(),
        builder: (HomeServicesController homeServicesController) =>
            RefreshIndicator(
              onRefresh: () async {
                await homeServicesController.onRefreshPage();
              },
              child: ResponsiveRowColumn(
                layout: ResponsiveRowColumnType.COLUMN,
                columnCrossAxisAlignment: CrossAxisAlignment.start,
                children: <ResponsiveRowColumnItem>[
                  ResponsiveRowColumnItem(
                      child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.horizontal(2)),
                    color: AppColors.blackBackground,
                    child: ResponsiveRowColumn(
                      layout: ResponsiveRowColumnType.ROW,
                      rowMainAxisAlignment: MainAxisAlignment.center,
                      children: <ResponsiveRowColumnItem>[
                        ResponsiveRowColumnItem(
                            child: CustomTextField(
                          borderRadius: 2,
                          title: '',
                          hintText: 'Search...',
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppColors.greyDisabled,
                          ),
                        )),
                        const ResponsiveRowColumnItem(
                            child: SpaceSizer(horizontal: 2)),
                        ResponsiveRowColumnItem(
                            child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(2))),
                          child: Icon(
                            Icons.sort,
                            size: SizeConfig.horizontal(11),
                            color: AppColors.blackBackground,
                          ),
                        ))
                      ],
                    ),
                  )),
                  // ResponsiveRowColumnItem(
                  //     child: Padding(
                  //   padding: EdgeInsets.only(
                  //       left: SizeConfig.horizontal(6),
                  //       top: SizeConfig.horizontal(2)),
                  //   child: InterTextView(
                  //     value: 'Hasil Pencarian :',
                  //     color: AppColors.black,
                  //     fontWeight: FontWeight.bold,
                  //     size: SizeConfig.safeBlockHorizontal * 4.5,
                  //   ),
                  // )),
                  ResponsiveRowColumnItem(
                    child: TabBar(
                        indicatorColor: AppColors.blackBackground,
                        labelPadding:
                            EdgeInsets.only(bottom: SizeConfig.horizontal(1)),
                        controller: homeServicesController.tabController,
                        unselectedLabelColor: AppColors.greyTextDisabled,
                        labelStyle:
                            InterStyle().labelStyle(AppColors.blackBackground),
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.horizontal(2)),
                        tabs: <Widget>[
                          Icon(
                            Icons.directions_car,
                            size: SizeConfig.safeBlockHorizontal * 7,
                          ),
                          Icon(
                            Icons.directions_bike_outlined,
                            size: SizeConfig.safeBlockHorizontal * 7,
                          ),
                        ]),
                  ),
                  ResponsiveRowColumnItem(
                      child: Expanded(
                    child: TabBarView(
                      controller: homeServicesController.tabController,
                      children: <Widget>[
                        Obx(
                          () => ListView.builder(
                            itemCount: homeServicesController.isLoading.isTrue
                                ? 2
                                : homeServicesController
                                    .listMechanicsMobil.length,
                            itemBuilder: (BuildContext context, int index) =>
                                homeServicesController.isLoading.value == true
                                    ? Padding(
                                        padding: EdgeInsets.all(
                                            SizeConfig.horizontal(2)),
                                        child: CustomShimmerPlaceHolder(
                                          width: SizeConfig.horizontal(30),
                                          height: SizeConfig.horizontal(20),
                                        ),
                                      )
                                    : ListMechanics(
                                        model: homeServicesController
                                            .listMechanicsMobil[index],
                                        homeServicesController:
                                            homeServicesController,
                                      ),
                          ),
                        ),
                        Obx(
                          () => ListView.builder(
                            itemCount: homeServicesController.isLoading.isTrue
                                ? 2
                                : homeServicesController
                                    .listMechanicsMotor.length,
                            itemBuilder: (BuildContext context, int index) =>
                                homeServicesController.isLoading.value == true
                                    ? Padding(
                                        padding: EdgeInsets.all(
                                            SizeConfig.horizontal(2)),
                                        child: CustomShimmerPlaceHolder(
                                          width: SizeConfig.horizontal(30),
                                          height: SizeConfig.horizontal(20),
                                        ),
                                      )
                                    : ListMechanics(
                                        model: homeServicesController
                                            .listMechanicsMotor[index],
                                        homeServicesController:
                                            homeServicesController,
                                      ),
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ));
  }
}

class ListMechanics extends StatelessWidget {
  const ListMechanics({
    super.key,
    required this.homeServicesController,
    required this.model,
  });

  final HomeServicesController homeServicesController;
  final ListMechanicsModel model;

  @override
  Widget build(BuildContext context) {
    return CustomRippleButton(
        onTap: () {
          // homeServicesController.mechanicId.value = model.;
          homeServicesController.mechanicId.value = model.userUid;
          Get.to(HomeServicesAbout(
            mechanicDescription: model.homeMechanicDescription,
            mechanicId: model.userUid,
            homeServicesController: homeServicesController,
            mechanicEmail: model.userEmail,
            mechanicPic: model.homeServiceImage,
            mechanicName: model.name,
            mechanicAlias: model.homeServiceName,
            mechanicRating: model.userRating,
            mechanicLevel: model.userLevel,
            mechanicLat: model.homeServiceLat,
            mechanicLong: model.homeServiceLong,
            mechanicAlamatDetail: model.homeServiceAddress,
            handledBrands: model.handledBrands,
            handledSpecialist: model.handledSpecialist,
          ));
        },
        child: Container(
          height: SizeConfig.horizontal(62),
          padding: EdgeInsets.all(SizeConfig.horizontal(3)),
          margin: EdgeInsets.symmetric(
              horizontal: SizeConfig.horizontal(6),
              vertical: SizeConfig.horizontal(3)),
          decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    spreadRadius: 3,
                    blurRadius: 2,
                    offset: const Offset(0, 2),
                    color: AppColors.greyDisabled)
              ],
              borderRadius:
                  BorderRadius.all(Radius.circular(SizeConfig.horizontal(1)))),
          child: ResponsiveRowColumn(
            layout: ResponsiveRowColumnType.COLUMN,
            columnCrossAxisAlignment: CrossAxisAlignment.start,
            children: <ResponsiveRowColumnItem>[
              ResponsiveRowColumnItem(
                  child: SizedBox(
                      height: SizeConfig.horizontal(16),
                      child: model.homeServiceImage == '' ||
                              model.homeServiceImage == null
                          ? CustomShimmerPlaceHolder(
                              borderRadius: SizeConfig.horizontal(20),
                              width: SizeConfig.horizontal(16))
                          : ResponsiveRowColumn(
                              layout: ResponsiveRowColumnType.ROW,
                              children: <ResponsiveRowColumnItem>[
                                ResponsiveRowColumnItem(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            SizeConfig.horizontal(1))),
                                    child: SizedBox(
                                        height: SizeConfig.horizontal(25),
                                        width: SizeConfig.horizontal(25),
                                        child: CachedNetworkImage(
                                          memCacheHeight: 300,
                                          memCacheWidth: 300,
                                          imageUrl: model.homeServiceImage,
                                          fit: BoxFit.fill,
                                        )),
                                  ),
                                ),
                                const ResponsiveRowColumnItem(
                                    child: SpaceSizer(horizontal: 3)),
                                ResponsiveRowColumnItem(
                                    child: ResponsiveRowColumn(
                                  layout: ResponsiveRowColumnType.COLUMN,
                                  columnCrossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: <ResponsiveRowColumnItem>[
                                    ResponsiveRowColumnItem(
                                      child: InterTextView(
                                          value: model.homeServiceName,
                                          color: AppColors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    ResponsiveRowColumnItem(
                                      child: InterTextView(
                                        value: model.homeServiceAddress,
                                        color: AppColors.grey,
                                        fontWeight: FontWeight.w500,
                                        size: SizeConfig.safeBlockHorizontal *
                                            3.5,
                                      ),
                                    ),
                                    ResponsiveRowColumnItem(
                                        child: ResponsiveRowColumn(
                                      layout: ResponsiveRowColumnType.ROW,
                                      rowMainAxisSize: MainAxisSize.min,
                                      children: <ResponsiveRowColumnItem>[
                                        ResponsiveRowColumnItem(
                                          child: Icon(
                                            Icons.star,
                                            color: AppColors.gold,
                                          ),
                                        ),
                                        ResponsiveRowColumnItem(
                                            child: InterTextView(
                                                value:
                                                    model.userRating.toString(),
                                                size: SizeConfig
                                                        .safeBlockHorizontal *
                                                    3.5,
                                                color: AppColors.black)),
                                      ],
                                    )),
                                  ],
                                )),
                              ],
                            ))),
              const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 1)),
              ResponsiveRowColumnItem(
                  child: ResponsiveRowColumn(
                      layout: ResponsiveRowColumnType.ROW,
                      children: <ResponsiveRowColumnItem>[
                    ResponsiveRowColumnItem(
                        child: Icon(
                      Icons.collections_bookmark_rounded,
                      color: AppColors.blackBackground,
                      size: SizeConfig.horizontal(8),
                    )),
                    const ResponsiveRowColumnItem(
                        child: SpaceSizer(horizontal: 1.5)),
                    ResponsiveRowColumnItem(
                        child: ResponsiveRowColumn(
                      layout: ResponsiveRowColumnType.COLUMN,
                      columnCrossAxisAlignment: CrossAxisAlignment.start,
                      children: <ResponsiveRowColumnItem>[
                        ResponsiveRowColumnItem(
                          child: InterTextView(
                            value: 'Handled Brands',
                            color: AppColors.black,
                            size: SizeConfig.safeBlockHorizontal * 3,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        ResponsiveRowColumnItem(
                            child: SizedBox(
                          height: SizeConfig.horizontal(7.5),
                          width: SizeConfig.horizontal(62),
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: model.handledBrands.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) =>
                                  BrandsList(
                                    model: model.handledBrands[index],
                                  )),
                        )),
                      ],
                    ))
                  ])),
              const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 1)),
              ResponsiveRowColumnItem(
                  child: InterTextView(
                value: 'Description',
                color: AppColors.black,
                size: SizeConfig.safeBlockHorizontal * 3.5,
                fontWeight: FontWeight.w500,
              )),
              const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 0.5)),
              ResponsiveRowColumnItem(
                  child: SizedBox(
                width: SizeConfig.horizontal(80),
                height: SizeConfig.horizontal(19),
                child: InterTextView(
                  overFlow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w300,
                  maxLines: 4,
                  value: model.homeMechanicDescription,
                  color: AppColors.black,
                  size: SizeConfig.safeBlockHorizontal * 3,
                ),
              ))
            ],
          ),
        ));
  }
}

class BrandsList extends StatelessWidget {
  const BrandsList({
    super.key,
    required this.model,
  });

  final BrandsCarModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.horizontal(1)),
        child: CachedNetworkImage(
          imageUrl: model.brandImage,
          memCacheHeight: 90,
          memCacheWidth: 90,
          width: SizeConfig.horizontal(5),
          height: SizeConfig.horizontal(12),
        ));
  }
}
