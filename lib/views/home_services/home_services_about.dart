import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../controllers/home_services_controller.dart';
import '../../controllers/maps_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/asset_list.dart';
import '../../utils/size_config.dart';
import '../widgets/custom/custom_bordered_container.dart';
import '../widgets/custom/custom_flat_button.dart';
import '../widgets/custom/custom_ripple_button.dart';
import '../widgets/frame/frame_scaffold.dart';
import '../widgets/layouts/space_sizer.dart';
import '../widgets/text/inter_text_view.dart';

class HomeServicesAbout extends StatelessWidget {
  const HomeServicesAbout({
    super.key,
    required this.mechanicEmail,
    required this.mechanicAlias,
    required this.mechanicName,
    required this.mechanicPic,
    required this.mechanicLevel,
    required this.mechanicId,
    required this.mechanicLat,
    required this.mechanicLong,
    required this.mechanicRating,
    required this.homeServicesController,
  });

  final String mechanicEmail;
  final String mechanicAlias;
  final String mechanicName;
  final String mechanicPic;
  final String mechanicLevel;
  final String mechanicId;
  final String mechanicLat;
  final String mechanicLong;

  final double mechanicRating;
  final HomeServicesController homeServicesController;

  @override
  Widget build(BuildContext context) {
    final MapsController mapsController = Get.put(MapsController());
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            systemNavigationBarColor: AppColors.black,
            systemNavigationBarIconBrightness: Brightness.dark),
        child: FrameScaffold(
            heightBar: 0,
            elevation: 0,
            statusBarColor: AppColors.blackBackground,
            colorScaffold: AppColors.greyBackground,
            statusBarBrightness: Brightness.light,
            view: SingleChildScrollView(
              child: ResponsiveRowColumn(
                layout: ResponsiveRowColumnType.COLUMN,
                children: <ResponsiveRowColumnItem>[
                  ResponsiveRowColumnItem(
                    child: ResponsiveRowColumn(
                      layout: ResponsiveRowColumnType.ROW,
                      rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <ResponsiveRowColumnItem>[
                        ResponsiveRowColumnItem(
                            child: IconButton(
                                icon: const Icon(Icons.arrow_back),
                                onPressed: () => Get.back())),
                        ResponsiveRowColumnItem(
                            child: IconButton(
                          icon: Icon(
                            Icons.favorite_border_outlined,
                            color: AppColors.blackBackground,
                          ),
                          onPressed: () {},
                        )),
                      ],
                    ),
                  ),
                  ResponsiveRowColumnItem(
                      child: InterTextView(
                          value: mechanicAlias,
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                          size: SizeConfig.safeBlockHorizontal * 5)),
                  const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 2)),
                  ResponsiveRowColumnItem(
                      child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColors.blueDark,
                            width: SizeConfig.horizontal(1.5)),
                        shape: BoxShape.circle,
                        color: AppColors.redAlert),
                    height: SizeConfig.horizontal(50),
                    width: SizeConfig.horizontal(50),
                    child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        child: CachedNetworkImage(
                            imageUrl: mechanicPic, fit: BoxFit.cover)),
                  )),
                  const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 1)),
                  ResponsiveRowColumnItem(
                      child: InterTextView(
                    value: mechanicName,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    size: SizeConfig.safeBlockHorizontal * 4.5,
                  )),
                  const ResponsiveRowColumnItem(
                      child: SpaceSizer(vertical: 0.5)),
                  ResponsiveRowColumnItem(
                      child: ResponsiveRowColumn(
                    layout: ResponsiveRowColumnType.ROW,
                    rowMainAxisAlignment: MainAxisAlignment.center,
                    children: <ResponsiveRowColumnItem>[
                      ResponsiveRowColumnItem(
                        child: Icon(
                          Icons.star,
                          color: AppColors.gold,
                        ),
                      ),
                      ResponsiveRowColumnItem(
                          child: InterTextView(
                        value: mechanicRating.toString(),
                        size: SizeConfig.safeBlockHorizontal * 4,
                        fontWeight: FontWeight.w600,
                        color: AppColors.gold,
                      ))
                    ],
                  )),
                  const ResponsiveRowColumnItem(
                      child: SpaceSizer(vertical: 0.5)),
                  ResponsiveRowColumnItem(
                      child: InterTextView(
                    value: 'Operational Hour\n  08:00 - 20:00',
                    size: SizeConfig.safeBlockHorizontal * 3.5,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  )),
                  const ResponsiveRowColumnItem(
                      child: SpaceSizer(vertical: 1.5)),
                  ResponsiveRowColumnItem(
                      child: CustomFlatButton(
                          width: 30,
                          height: 5,
                          text: 'Message',
                          textSize: 3.5,
                          onTap: () {
                            homeServicesController.addConncectionChat(
                                mechanicName, mechanicId, mechanicPic);
                          })),
                  const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 1)),
                  ResponsiveRowColumnItem(
                      child: CustomRippleButton(
                    onTap: () =>
                        mapsController.openGoogleMap(mechanicLat, mechanicLong),
                    child: CustomBorderedContainer(
                        child: ResponsiveRowColumn(
                      layout: ResponsiveRowColumnType.COLUMN,
                      children: <ResponsiveRowColumnItem>[
                        ResponsiveRowColumnItem(
                            child: Padding(
                          padding: EdgeInsets.all(SizeConfig.horizontal(2)),
                          child: SizedBox(
                            height: SizeConfig.horizontal(40),
                            width: SizeConfig.horizontal(80),
                            child: Image.asset(
                              AssetList.trashMap,
                              fit: BoxFit.fill,
                            ),
                          ),
                        )),
                        ResponsiveRowColumnItem(
                            child: Padding(
                          padding: EdgeInsets.all(SizeConfig.horizontal(2)),
                          child: InterTextView(
                            value:
                                'Detail alamat:\nJl.Raya Pendidikan 4 No 2599, Bekasi Timur,Jawa Barat,Indonesia',
                            color: AppColors.greyTextDisabled,
                          ),
                        ))
                      ],
                    )),
                  )),
                  ResponsiveRowColumnItem(
                      child: CustomBorderedContainer(
                          child: ResponsiveRowColumn(
                    layout: ResponsiveRowColumnType.ROW,
                    children: <ResponsiveRowColumnItem>[
                      ResponsiveRowColumnItem(
                          child: Padding(
                        padding: EdgeInsets.all(SizeConfig.horizontal(2)),
                        child: Icon(
                          Icons.book,
                          color: AppColors.blackBackground,
                          size: SizeConfig.horizontal(12),
                        ),
                      )),
                      ResponsiveRowColumnItem(
                          child: ResponsiveRowColumn(
                        layout: ResponsiveRowColumnType.COLUMN,
                        columnCrossAxisAlignment: CrossAxisAlignment.start,
                        children: <ResponsiveRowColumnItem>[
                          ResponsiveRowColumnItem(
                              child: InterTextView(
                            value: 'Experienced level',
                            size: SizeConfig.safeBlockHorizontal * 3.5,
                            color: AppColors.black,
                          )),
                          ResponsiveRowColumnItem(
                              child: InterTextView(
                            value: mechanicLevel,
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                          )),
                        ],
                      ))
                    ],
                  ))),
                  ResponsiveRowColumnItem(
                      child: CustomBorderedContainer(
                          child: ResponsiveRowColumn(
                    layout: ResponsiveRowColumnType.ROW,
                    children: <ResponsiveRowColumnItem>[
                      ResponsiveRowColumnItem(
                          child: Padding(
                        padding: EdgeInsets.all(SizeConfig.horizontal(2)),
                        child: Icon(
                          Icons.recommend,
                          color: AppColors.blackBackground,
                          size: SizeConfig.horizontal(12),
                        ),
                      )),
                      ResponsiveRowColumnItem(
                          child: ResponsiveRowColumn(
                        layout: ResponsiveRowColumnType.COLUMN,
                        columnCrossAxisAlignment: CrossAxisAlignment.start,
                        children: <ResponsiveRowColumnItem>[
                          ResponsiveRowColumnItem(
                              child: InterTextView(
                            value: 'Skilled',
                            size: SizeConfig.safeBlockHorizontal * 3.5,
                            color: AppColors.black,
                          )),
                          ResponsiveRowColumnItem(
                              child: InterTextView(
                            value: '-Mobil',
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                          )),
                        ],
                      ))
                    ],
                  ))),
                  ResponsiveRowColumnItem(
                      child: CustomBorderedContainer(
                          child: ResponsiveRowColumn(
                    layout: ResponsiveRowColumnType.ROW,
                    rowCrossAxisAlignment: CrossAxisAlignment.start,
                    children: <ResponsiveRowColumnItem>[
                      ResponsiveRowColumnItem(
                          child: Padding(
                        padding: EdgeInsets.all(SizeConfig.horizontal(2)),
                        child: Icon(
                          Icons.event_note,
                          color: AppColors.blackBackground,
                          size: SizeConfig.horizontal(12),
                        ),
                      )),
                      ResponsiveRowColumnItem(
                          child: ResponsiveRowColumn(
                        layout: ResponsiveRowColumnType.COLUMN,
                        columnCrossAxisAlignment: CrossAxisAlignment.start,
                        columnPadding: EdgeInsets.symmetric(
                            vertical: SizeConfig.horizontal(1)),
                        children: <ResponsiveRowColumnItem>[
                          ResponsiveRowColumnItem(
                              child: InterTextView(
                            value: 'Review',
                            size: SizeConfig.safeBlockHorizontal * 3.5,
                            color: AppColors.black,
                          )),
                          ResponsiveRowColumnItem(
                              child: SizedBox(
                            width: SizeConfig.horizontal(60),
                            child: InterTextView(
                              value:
                                  '@Fumaru : Boleh lah (Y), lupa masang baut olinya, jadinya tumpah tumpah ke tete saya mas',
                              color: AppColors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                        ],
                      ))
                    ],
                  ))),
                  const ResponsiveRowColumnItem(
                      child: SpaceSizer(vertical: 1.5)),
                ],
              ),
            )));
  }
}
