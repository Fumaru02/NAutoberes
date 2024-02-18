import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_row_column.dart';

import '../../controllers/home_services_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/asset_list.dart';
import '../../utils/size_config.dart';
import '../widgets/custom/custom_ripple_button.dart';
import '../widgets/custom/custom_text_field.dart';
import '../widgets/layouts/space_sizer.dart';
import '../widgets/text/inter_text_view.dart';

class HomeServicesView extends StatelessWidget {
  const HomeServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeServicesController>(
        init: HomeServicesController(),
        builder: (HomeServicesController homeServicesController) =>
            ResponsiveRowColumn(
              layout: ResponsiveRowColumnType.COLUMN,
              columnCrossAxisAlignment: CrossAxisAlignment.start,
              children: <ResponsiveRowColumnItem>[
                ResponsiveRowColumnItem(
                    child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: SizeConfig.horizontal(2)),
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
                    child: Obx(
                  () => homeServicesController.isTapped.isFalse
                      ? const SizedBox.shrink()
                      : Center(
                          child: Container(
                              margin: EdgeInsets.only(
                                  top: SizeConfig.horizontal(2)),
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        spreadRadius: 2.5,
                                        blurRadius: 2,
                                        offset: const Offset(0, 2),
                                        color: AppColors.greyDisabled)
                                  ],
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          SizeConfig.horizontal(4)))),
                              width: SizeConfig.horizontal(92),
                              child: ResponsiveRowColumn(
                                layout: ResponsiveRowColumnType.COLUMN,
                                columnPadding:
                                    EdgeInsets.all(SizeConfig.horizontal(1)),
                                children: <ResponsiveRowColumnItem>[
                                  ResponsiveRowColumnItem(
                                      child: ResponsiveRowColumn(
                                    layout: ResponsiveRowColumnType.ROW,
                                    rowPadding: EdgeInsets.only(
                                        left: SizeConfig.horizontal(8)),
                                    rowMainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: <ResponsiveRowColumnItem>[
                                      ResponsiveRowColumnItem(
                                          child: InterTextView(
                                              value: 'Hermawan Sumarwan',
                                              color: AppColors.black,
                                              fontWeight: FontWeight.bold)),
                                      ResponsiveRowColumnItem(
                                          child: IconButton(
                                              onPressed: () =>
                                                  homeServicesController
                                                      .hideHomeServices(),
                                              icon: Icon(
                                                Icons.close_sharp,
                                                size: SizeConfig.horizontal(8),
                                              ))),
                                    ],
                                  )),
                                  ResponsiveRowColumnItem(
                                      child: CircleAvatar(
                                          maxRadius: SizeConfig.horizontal(14),
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                                SizeConfig.horizontal(2)),
                                            child: Image.asset(
                                                fit: BoxFit.fill,
                                                AssetList.autoberesLogo),
                                          ))),
                                  const ResponsiveRowColumnItem(
                                      child: SpaceSizer(vertical: 1)),
                                  ResponsiveRowColumnItem(
                                      child: ResponsiveRowColumn(
                                    layout: ResponsiveRowColumnType.ROW,
                                    rowSpacing: 4,
                                    rowMainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: <ResponsiveRowColumnItem>[
                                      ResponsiveRowColumnItem(
                                          child: InterTextView(
                                              value: 'Shop And Drive',
                                              color: AppColors.black,
                                              fontWeight: FontWeight.bold)),
                                      ResponsiveRowColumnItem(
                                          child: Icon(Icons.check_circle_sharp,
                                              color: AppColors.blueDark))
                                    ],
                                  )),
                                  ResponsiveRowColumnItem(
                                      child: ResponsiveRowColumn(
                                    layout: ResponsiveRowColumnType.ROW,
                                    rowSpacing: 4,
                                    rowMainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: <ResponsiveRowColumnItem>[
                                      ResponsiveRowColumnItem(
                                          child: Icon(Icons.wifi_calling_3,
                                              color: AppColors.blueDark)),
                                      ResponsiveRowColumnItem(
                                          child: InterTextView(
                                              value: '0812-1232-2232',
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w600,
                                              size: SizeConfig
                                                      .safeBlockHorizontal *
                                                  3.5))
                                    ],
                                  )),
                                  ResponsiveRowColumnItem(
                                      child: ResponsiveRowColumn(
                                    layout: ResponsiveRowColumnType.ROW,
                                    rowSpacing: 4,
                                    rowMainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: <ResponsiveRowColumnItem>[
                                      ResponsiveRowColumnItem(
                                          child: Image.asset(
                                        height: SizeConfig.horizontal(7),
                                        AssetList.instagramIcon,
                                        color: AppColors.blackBackground,
                                      )),
                                      ResponsiveRowColumnItem(
                                          child: InterTextView(
                                              value: '@ShopAndDrive',
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w600,
                                              size: SizeConfig
                                                      .safeBlockHorizontal *
                                                  3.5))
                                    ],
                                  )),
                                  ResponsiveRowColumnItem(
                                      child: Icon(
                                    Icons.star,
                                    color: AppColors.gold,
                                  )),
                                  ResponsiveRowColumnItem(
                                      child: InterTextView(
                                          value: '5.0',
                                          size: SizeConfig.safeBlockHorizontal *
                                              3.5,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.black)),
                                  const ResponsiveRowColumnItem(
                                      child: SpaceSizer(vertical: 1)),
                                ],
                              )),
                        ),
                )),
                ResponsiveRowColumnItem(
                    child: Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.horizontal(6),
                      top: SizeConfig.horizontal(2)),
                  child: InterTextView(
                    value: 'Search Result :',
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    size: SizeConfig.safeBlockHorizontal * 4.5,
                  ),
                )),
                ResponsiveRowColumnItem(
                    child: Expanded(
                        child: ListView.builder(
                            itemCount: 4,
                            itemBuilder: (BuildContext context, int index) =>
                                CustomRippleButton(
                                    onTap: () => homeServicesController
                                        .showHomeServices(),
                                    child: Container(
                                        padding: EdgeInsets.all(
                                            SizeConfig.horizontal(4)),
                                        margin: EdgeInsets.symmetric(
                                            horizontal:
                                                SizeConfig.horizontal(6),
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
                                                Radius.circular(
                                                    SizeConfig.horizontal(4)))),
                                        child: ResponsiveRowColumn(
                                          layout: ResponsiveRowColumnType.ROW,
                                          children: <ResponsiveRowColumnItem>[
                                            ResponsiveRowColumnItem(
                                                child: SizedBox(
                                                    height:
                                                        SizeConfig.horizontal(
                                                            16),
                                                    child: const CircleAvatar(
                                                        minRadius: 30))),
                                            ResponsiveRowColumnItem(
                                                child: ResponsiveRowColumn(
                                              columnMainAxisSize:
                                                  MainAxisSize.min,
                                              layout: ResponsiveRowColumnType
                                                  .COLUMN,
                                              columnPadding: EdgeInsets.only(
                                                  left:
                                                      SizeConfig.horizontal(2)),
                                              columnCrossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <ResponsiveRowColumnItem>[
                                                ResponsiveRowColumnItem(
                                                    child: InterTextView(
                                                        value: 'Body Repair',
                                                        color: AppColors.black,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                ResponsiveRowColumnItem(
                                                    child: InterTextView(
                                                        value:
                                                            'Jl. Buahbatu no 38',
                                                        color: AppColors
                                                            .greyButton,
                                                        size: SizeConfig
                                                                .safeBlockHorizontal *
                                                            3.5)),
                                                ResponsiveRowColumnItem(
                                                    child: InterTextView(
                                                        value: 'Expert',
                                                        color: AppColors.black,
                                                        size: SizeConfig
                                                                .safeBlockHorizontal *
                                                            4,
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ],
                                            )),
                                            const ResponsiveRowColumnItem(
                                                child: Spacer()),
                                            ResponsiveRowColumnItem(
                                                child: Icon(
                                              Icons.star,
                                              color: AppColors.gold,
                                            )),
                                            ResponsiveRowColumnItem(
                                                child: InterTextView(
                                                    value: '4.7',
                                                    size: SizeConfig
                                                            .safeBlockHorizontal *
                                                        3.5,
                                                    color: AppColors.black))
                                          ],
                                        ))))))
              ],
            ));
  }
}
