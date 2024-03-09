import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_row_column.dart';

import '../../controllers/home_services_controller.dart';
import '../../models/list_mechanics/list_mechanics_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/size_config.dart';
import '../widgets/custom/custom_ripple_button.dart';
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
                          title: '',
                          hintText: 'Search...',
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppColors.greyDisabled,
                          ),
                        )),
                        const ResponsiveRowColumnItem(
                            child: SpaceSizer(
                          horizontal: 2,
                        )),
                        ResponsiveRowColumnItem(
                            child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8))),
                          child: Icon(
                            Icons.sort,
                            size: SizeConfig.horizontal(11),
                            color: AppColors.blackBackground,
                          ),
                        ))
                      ],
                    ),
                  )),
                  ResponsiveRowColumnItem(
                      child: Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.horizontal(6),
                        top: SizeConfig.horizontal(2)),
                    child: InterTextView(
                      value: 'Hasil Pencarian :',
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                      size: SizeConfig.safeBlockHorizontal * 4.5,
                    ),
                  )),
                  ResponsiveRowColumnItem(
                      child: Expanded(
                          child: ListView.builder(
                              itemCount: homeServicesController
                                  .listMechanicsModel.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  ListMechanics(
                                    model: homeServicesController
                                        .listMechanicsModel[index],
                                    homeServicesController:
                                        homeServicesController,
                                  ))))
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
            mechanicId: model.userUid,
            homeServicesController: homeServicesController,
            mechanicEmail: model.userEmail,
            mechanicPic: model.homeServiceImage,
            mechanicName: model.name,
            mechanicAlias: model.homeServiceName,
            mechanicRating: model.userRating,
            mechanicLevel: model.userLevel,
          ));
        },
        child: Container(
            padding: EdgeInsets.all(SizeConfig.horizontal(4)),
            margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.horizontal(6),
                vertical: SizeConfig.horizontal(3)),
            decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      spreadRadius: 3,
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                      color: AppColors.greyDisabled)
                ],
                borderRadius: BorderRadius.all(
                    Radius.circular(SizeConfig.horizontal(4)))),
            child: ResponsiveRowColumn(
              layout: ResponsiveRowColumnType.ROW,
              children: <ResponsiveRowColumnItem>[
                ResponsiveRowColumnItem(
                    child: SizedBox(
                        height: SizeConfig.horizontal(16),
                        child: CircleAvatar(
                          minRadius: 30,
                          backgroundImage: NetworkImage(
                            model.homeServiceImage,
                          ),
                        ))),
                ResponsiveRowColumnItem(
                    child: ResponsiveRowColumn(
                  columnMainAxisSize: MainAxisSize.min,
                  layout: ResponsiveRowColumnType.COLUMN,
                  columnPadding:
                      EdgeInsets.only(left: SizeConfig.horizontal(2)),
                  columnCrossAxisAlignment: CrossAxisAlignment.start,
                  children: <ResponsiveRowColumnItem>[
                    ResponsiveRowColumnItem(
                        child: InterTextView(
                            value: model.homeServiceName,
                            color: AppColors.black,
                            fontWeight: FontWeight.bold)),
                    ResponsiveRowColumnItem(
                        child: InterTextView(
                            value: model.homeServiceAddress,
                            color: AppColors.greyButton,
                            size: SizeConfig.safeBlockHorizontal * 3.5)),
                    ResponsiveRowColumnItem(
                        child: InterTextView(
                            value: model.userLevel,
                            color: AppColors.black,
                            size: SizeConfig.safeBlockHorizontal * 4,
                            fontWeight: FontWeight.bold))
                  ],
                )),
                const ResponsiveRowColumnItem(child: Spacer()),
                ResponsiveRowColumnItem(
                    child: Icon(
                  Icons.star,
                  color: AppColors.gold,
                )),
                ResponsiveRowColumnItem(
                    child: InterTextView(
                        value: model.userRating.toString(),
                        size: SizeConfig.safeBlockHorizontal * 3.5,
                        color: AppColors.black)),
              ],
            )));
  }
}
