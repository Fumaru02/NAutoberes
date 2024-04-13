import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../controllers/home_service_manager_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/asset_list.dart';
import '../../utils/size_config.dart';
import '../widgets/custom/custom_bordered_container.dart';
import '../widgets/frame/frame_scaffold.dart';
import '../widgets/layouts/space_sizer.dart';
import '../widgets/text/inter_text_view.dart';

class HomeServiceManagerView extends StatelessWidget {
  const HomeServiceManagerView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            systemNavigationBarColor: AppColors.black,
            systemNavigationBarIconBrightness: Brightness.dark),
        child: FrameScaffold(
            heightBar: 60,
            isUseLeading: true,
            titleScreen: 'Home Service Manager',
            isCenter: true,
            elevation: 0,
            color: AppColors.blackBackground,
            statusBarColor: AppColors.blackBackground,
            colorScaffold: AppColors.greyBackground,
            statusBarBrightness: Brightness.light,
            view: GetBuilder<HomeServiceManagerController>(
              init: HomeServiceManagerController(),
              builder:
                  (HomeServiceManagerController homeServiceManagerController) =>
                      Center(
                child: CustomBorderedContainer(
                    child: ResponsiveRowColumn(
                  layout: ResponsiveRowColumnType.COLUMN,
                  children: <ResponsiveRowColumnItem>[
                    const ResponsiveRowColumnItem(
                        child: SpaceSizer(vertical: 2)),
                    ResponsiveRowColumnItem(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(SizeConfig.horizontal(20))),
                            // ignore: use_if_null_to_convert_nulls_to_bools
                            border: Border.all(
                                color: AppColors.white,
                                width: SizeConfig.horizontal(1))),
                        width: SizeConfig.horizontal(50),
                        height: SizeConfig.horizontal(50),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                              Radius.circular(SizeConfig.horizontal(20))),
                          child: CachedNetworkImage(
                              imageUrl: 'akunController.userImage.value',
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    const ResponsiveRowColumnItem(
                        child: SpaceSizer(vertical: 2)),
                    ResponsiveRowColumnItem(
                      child: myActifity(homeServiceManagerController),
                    ),
                  ],
                )),
              ),
            )));
  }

  CustomBorderedContainer myActifity(
      HomeServiceManagerController homeServiceManagerController) {
    return CustomBorderedContainer(
      child: ExpansionTile(
        title: InterTextView(
          value: 'Aktifitas ku',
          color: AppColors.black,
        ),
        children: <Widget>[
          ResponsiveRowColumn(
            layout: ResponsiveRowColumnType.COLUMN,
            columnPadding: EdgeInsets.all(SizeConfig.horizontal(4)),
            columnCrossAxisAlignment: CrossAxisAlignment.start,
            children: <ResponsiveRowColumnItem>[
              ResponsiveRowColumnItem(
                child: Center(
                  child: SizedBox(
                    height: SizeConfig.horizontal(50),
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                            touchCallback: (FlTouchEvent event,
                                    PieTouchResponse? pieTouchResponse) =>
                                homeServiceManagerController.touchCallBack(
                                    event, pieTouchResponse)),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 0,
                        sections: showingSections(homeServiceManagerController),
                      ),
                    ),
                  ),
                ),
              ),
              const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 2)),
              ResponsiveRowColumnItem(
                  child: BoxColoredText(
                title: 'Viewed Profile',
                color: AppColors.redAlert,
              )),
              const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 1)),
              ResponsiveRowColumnItem(
                  child: BoxColoredText(
                title: 'My Subscriber',
                color: AppColors.gold,
              )),
              const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 1)),
              ResponsiveRowColumnItem(
                  child: BoxColoredText(
                title: 'Total Chats',
                color: AppColors.blackBackground,
              )),
              const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 1)),
              ResponsiveRowColumnItem(
                  child: BoxColoredText(
                title: 'Total Trx',
                color: AppColors.blueDark,
              ))
            ],
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections(
      HomeServiceManagerController homeServiceManagerController) {
    return List<PieChartSectionData>.generate(4, (int i) {
      final bool isTouched =
          i == homeServiceManagerController.touchedDefaultIndex.value;
      final double fontSize = isTouched ? 20.0 : 16.0;
      final double radius = isTouched ? 110.0 : 100.0;
      final double widgetSize = isTouched ? 55.0 : 40.0;
      const List<Shadow> shadows = <Shadow>[Shadow(blurRadius: 2)];

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: AppColors.redAlert,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              AssetList.appleLogo,
              size: widgetSize,
              borderColor: AppColors.greenDRT,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: AppColors.gold,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              AssetList.googleLogo,
              size: widgetSize,
              borderColor: AppColors.orangeActive,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: AppColors.blackBackground,
            value: 16,
            title: '16%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              AssetList.emailLogo,
              size: widgetSize,
              borderColor: AppColors.yellow,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 3:
          return PieChartSectionData(
            color: AppColors.blueDark,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              AssetList.facebookLogo,
              size: widgetSize,
              borderColor: AppColors.black,
            ),
            badgePositionPercentageOffset: .98,
          );
        default:
          throw Exception('Oh no');
      }
    });
  }
}

class BoxColoredText extends StatelessWidget {
  const BoxColoredText({
    super.key,
    required this.title,
    required this.color,
  });

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ResponsiveRowColumn(
      layout: ResponsiveRowColumnType.ROW,
      children: <ResponsiveRowColumnItem>[
        ResponsiveRowColumnItem(
            child: Container(
                width: SizeConfig.horizontal(6),
                height: SizeConfig.horizontal(5),
                color: color)),
        const ResponsiveRowColumnItem(child: SpaceSizer(horizontal: 1)),
        ResponsiveRowColumnItem(
          child: InterTextView(
            value: title,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge(
    this.imageAsset, {
    required this.size,
    required this.borderColor,
  });
  final String imageAsset;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(SizeConfig.horizontal(2)),
      child: Center(
        child: Image.asset(
          imageAsset,
        ),
      ),
    );
  }
}
