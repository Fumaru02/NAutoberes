import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../controllers/custom_calendar_controller.dart';
import '../../../controllers/home/ganti_oli_controller.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/enums.dart';
import '../../../utils/size_config.dart';
import '../frame/frame_scaffold.dart';
import '../layouts/space_sizer.dart';
import '../text/inter_text_view.dart';
import 'custom_general_table_calendar.dart';

class CalendarPreviewButton extends StatelessWidget {
  const CalendarPreviewButton({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.onTap,
    required this.gantiOliController,
  });

  final DateTime startDate;
  final DateTime endDate;
  final Function() onTap;
  final GantiOliController gantiOliController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ResponsiveRowColumn(
        layout: ResponsiveRowColumnType.ROW,
        rowPadding: EdgeInsets.only(
            top: SizeConfig.horizontal(4), right: SizeConfig.horizontal(2)),
        rowMainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <ResponsiveRowColumnItem>[
          ResponsiveRowColumnItem(
              child: _dateButton(startDate, 'Mulai',
                  gantiOliController.selectedStartTime.value.format(context))),
          ResponsiveRowColumnItem(
              child: Icon(
            Icons.arrow_right_alt_outlined,
            color: AppColors.blueDark,
            size: SizeConfig.horizontal(10),
          )),
          ResponsiveRowColumnItem(
              child: _dateButton(endDate, 'Selesai',
                  gantiOliController.selectedEndTime.value.format(context))),
        ],
      ),
    );
  }

  Widget _dateButton(DateTime format, String title, String selectedTime) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: () => onTap(),
        child: Ink(
          padding: EdgeInsets.symmetric(
            vertical: SizeConfig.blockSizeVertical * 1.5,
            horizontal: SizeConfig.blockSizeHorizontal * 5,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(
              color: AppColors.blackBackground,
              width: SizeConfig.blockSizeHorizontal * 0.4,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(SizeConfig.horizontal(2)),
            ),
          ),
          child: ResponsiveRowColumn(
            layout: ResponsiveRowColumnType.COLUMN,
            children: <ResponsiveRowColumnItem>[
              ResponsiveRowColumnItem(
                  child: InterTextView(
                value: title,
                size: SizeConfig.safeBlockHorizontal * 3.5,
                color: AppColors.blueDark,
                fontWeight: FontWeight.bold,
              )),
              ResponsiveRowColumnItem(
                child: InterTextView(
                  value: DateFormat('dd MMM y').format(format),
                  size: SizeConfig.safeBlockHorizontal * 3.5,
                  color: AppColors.blackBackground,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ResponsiveRowColumnItem(
                  child: InterTextView(
                value: selectedTime,
                size: SizeConfig.safeBlockHorizontal * 3.5,
                color: AppColors.blueDark,
                fontWeight: FontWeight.bold,
              )),
            ],
          ),
        ),
      ),
    );
  }
}

/// [GeneralCalendar] class used to represent Date Picker Page
class GeneralCalendar extends StatelessWidget {
  const GeneralCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    // AnalyticsHelper.analyticCurrentScreen(AnalyticsType.calendarScreen);
    return GetBuilder<CustomGeneralCalendarController>(
      init: CustomGeneralCalendarController(),
      id: 'generalCalendar',
      builder:
          (CustomGeneralCalendarController customgeneralCalendarController) {
        return FrameScaffold(
          titleScreen: 'Target',
          heightBar: SizeConfig.horizontal(12),
          color: AppColors.blackBackground,
          colorScaffold: AppColors.greyBackground,
          isCenter: true,
          elevation: 0,
          statusBarBrightness: Brightness.dark,
          view: _expandedSizedBox(customgeneralCalendarController),
        );
      },
    );
  }

  /// [_expandedSizedBox] widget used to wrapper all widget
  Widget _expandedSizedBox(
      CustomGeneralCalendarController customGeneralCalendarController) {
    return SizedBox(
      child: ResponsiveRowColumn(
        layout: ResponsiveRowColumnType.COLUMN,
        children: <ResponsiveRowColumnItem>[
          ResponsiveRowColumnItem(
              child: _headerDate(customGeneralCalendarController)),
          const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 2)),
          ResponsiveRowColumnItem(
              child: _calendar(customGeneralCalendarController)),
        ],
      ),
    );
  }

  /// [_headerDate] Widget used to represenst header section and
  /// container for widget wrapper [_dateDisplayWrapper]
  Widget _headerDate(
      CustomGeneralCalendarController customGeneralCalendarController) {
    return Container(
      color: AppColors.blackBackground,
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.blockSizeHorizontal * 3,
        vertical: SizeConfig.blockSizeVertical * 2,
      ),
      child: _dateDisplayWrapper(customGeneralCalendarController),
    );
  }

  /// [_dateDisplayWrapper] Widget used to wrapper widget [_startDate]
  ///  and [_endDate]
  Widget _dateDisplayWrapper(
      CustomGeneralCalendarController customGeneralCalendarController) {
    return ResponsiveRowColumn(
      layout: ResponsiveRowColumnType.ROW,
      children: <ResponsiveRowColumnItem>[
        ResponsiveRowColumnItem(
            child: _startDate(customGeneralCalendarController)),
        ResponsiveRowColumnItem(
          child: SizedBox(
            height: SizeConfig.blockSizeVertical * 6,
            child: VerticalDivider(
              color: AppColors.white,
              thickness: 1,
            ),
          ),
        ),
        ResponsiveRowColumnItem(
            child: _endDate(customGeneralCalendarController)),
      ],
    );
  }

  /// [_startDate] Widget used to repersent Start Date
  Widget _startDate(
      CustomGeneralCalendarController customGeneralCalendarController) {
    return Expanded(
      child: ResponsiveRowColumn(
        layout: ResponsiveRowColumnType.COLUMN,
        children: <ResponsiveRowColumnItem>[
          ResponsiveRowColumnItem(
            child: InterTextView(
                value: 'Start Date',
                color: Colors.white,
                size: SizeConfig.safeBlockHorizontal * 4),
          ),
          ResponsiveRowColumnItem(
            child: SizedBox(height: SizeConfig.blockSizeVertical * 1),
          ),
          ResponsiveRowColumnItem(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 3,
                vertical: SizeConfig.blockSizeVertical * 1,
              ),
              decoration: BoxDecoration(
                color: AppColors.blueDark,
                borderRadius: BorderRadius.circular(
                  SizeConfig.blockSizeHorizontal * 2,
                ),
              ),
              child: InterTextView(
                value: customGeneralCalendarController.startDateText(),
                size: SizeConfig.safeBlockHorizontal * 4,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// [_endDate] Widget used to represent End Date
  Widget _endDate(
      CustomGeneralCalendarController customGeneralCalendarController) {
    return Expanded(
      child: ResponsiveRowColumn(
        layout: ResponsiveRowColumnType.COLUMN,
        children: <ResponsiveRowColumnItem>[
          ResponsiveRowColumnItem(
            child: Text(
              'End Date',
              style: TextStyle(
                color: AppColors.white,
                fontSize: SizeConfig.safeBlockHorizontal * 4,
              ),
            ),
          ),
          const ResponsiveRowColumnItem(child: SpaceSizer(vertical: 1)),
          ResponsiveRowColumnItem(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal * 3,
                  vertical: SizeConfig.blockSizeVertical * 1),
              decoration: BoxDecoration(
                color: AppColors.blueDark,
                borderRadius: BorderRadius.circular(
                  SizeConfig.blockSizeHorizontal * 2,
                ),
              ),
              child: InterTextView(
                value: customGeneralCalendarController.endDateText(),
                size: SizeConfig.safeBlockHorizontal * 4,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// [_calendar] Widget used to represent calendar section
  Widget _calendar(
      CustomGeneralCalendarController customGeneralCalendarController) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                blurRadius: 2,
                color: AppColors.greyDisabled,
                offset: const Offset(0, 2),
                spreadRadius: 2)
          ],
          borderRadius:
              BorderRadius.all(Radius.circular(SizeConfig.horizontal(4)))),
      width: SizeConfig.horizontal(90),
      height: SizeConfig.horizontal(90),
      child: ResponsiveRowColumn(
        layout: ResponsiveRowColumnType.COLUMN,
        children: <ResponsiveRowColumnItem>[
          ResponsiveRowColumnItem(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical * 2.5),
              child: InterTextView(
                value: DateFormat('MMMM y').format(
                    customGeneralCalendarController.focusedDayGeneralCalendar),
                alignText: AlignTextType.center,
                size: SizeConfig.safeBlockHorizontal * 5,
                fontWeight: FontWeight.bold,
                color: AppColors.blackBackground,
              ),
            ),
          ),
          ResponsiveRowColumnItem(
            child: CustomGeneralTableCalendar(
              customGeneralCalendarController: customGeneralCalendarController,
            ),
          ),
          // CustomFlatButton(onTap: .submitSetDate, text: "text", brightness: BrightnessType.dark)
        ],
      ),
    );
  }
}
