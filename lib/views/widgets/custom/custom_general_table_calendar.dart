import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../controllers/custom_calendar_controller.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/size_config.dart';
import '../text/inter_text_view.dart';

class CustomGeneralTableCalendar extends StatelessWidget {
  const CustomGeneralTableCalendar({
    super.key,
    required this.customGeneralCalendarController,
  });

  final CustomGeneralCalendarController customGeneralCalendarController;

  @override
  Widget build(BuildContext context) {
    return TableCalendar<dynamic>(
      locale: 'en_US',
      firstDay: customGeneralCalendarController.firstDayCalendar,
      lastDay: customGeneralCalendarController.lastDayCalendar,
      focusedDay: customGeneralCalendarController.focusedDayGeneralCalendar,
      calendarFormat: customGeneralCalendarController.calendarFormat,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: const CalendarStyle(outsideDaysVisible: false),
      rangeStartDay: customGeneralCalendarController.rangeStartGeneralCalendar,
      rangeEndDay: customGeneralCalendarController.rangeEndGeneralCalendar,
      rangeSelectionMode: customGeneralCalendarController.onSetSelectionMode(),
      headerVisible: false,
      selectedDayPredicate: (DateTime day) {
        return isSameDay(
            customGeneralCalendarController.selectedDayGeneralCalendar, day);
      },
      onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
        customGeneralCalendarController.daySelectedGeneralCalendar(
            selectedDay, focusedDay);
      },
      onFormatChanged: (CalendarFormat format) =>
          customGeneralCalendarController.formatChangeGeneralCalendar(format),
      onPageChanged: (DateTime focusedDay) =>
          customGeneralCalendarController.pageChangeGeneralCalendar(focusedDay),
      onRangeSelected: (DateTime? start, DateTime? end, DateTime focusedDay) {
        customGeneralCalendarController.onRangeSelectedGeneralCalendar(
            start, end, focusedDay);
      },
      calendarBuilders: CalendarBuilders<dynamic>(
        dowBuilder: (BuildContext context, DateTime day) {
          return customDowbuilder(day);
        },
        defaultBuilder:
            (BuildContext context, DateTime day, DateTime focusedDay) {
          return customDefaultBuilder(day);
        },
        rangeStartBuilder:
            (BuildContext context, DateTime day, DateTime focusedDay) {
          return customRangeStartBuilder(day);
        },
        rangeEndBuilder:
            (BuildContext context, DateTime day, DateTime focusedDay) {
          return customRangeEndBuilder(day);
        },
        withinRangeBuilder:
            (BuildContext context, DateTime day, DateTime focusedDay) {
          return customwithinRangeBuilder(day);
        },
      ),
    );
  }

  // Custom day name
  Widget customDowbuilder(DateTime day) {
    final bool weekEnd = customGeneralCalendarController.isWeekend(day);
    final String weekday = DateFormat.E('en_US').format(day);
    return Center(
      child: ExcludeSemantics(
        child: InterTextView(
          value: weekday.substring(0, 1),
          color: weekEnd ? AppColors.redAlert : AppColors.blueDark,
          size: SizeConfig.safeBlockHorizontal * 4,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Custom cell calendar
  Widget customDefaultBuilder(DateTime day) {
    final bool weekEnd = customGeneralCalendarController.isWeekend(day);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.all(2.0),
      decoration: const BoxDecoration(shape: BoxShape.circle),
      alignment: Alignment.center,
      child: InterTextView(
        value: day.day.toString(),
        color: weekEnd ? AppColors.redAlert : Colors.black,
        size: SizeConfig.safeBlockHorizontal * 4.5,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget customRangeStartBuilder(DateTime day) {
    final bool weekEnd = customGeneralCalendarController.isWeekend(day);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.all(5.0),
      decoration:
          BoxDecoration(color: AppColors.blueDark, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: InterTextView(
        value: day.day.toString(),
        color: weekEnd ? AppColors.redAlert : Colors.white,
        size: SizeConfig.safeBlockHorizontal * 5.5,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget customRangeEndBuilder(DateTime day) {
    final bool weekEnd = customGeneralCalendarController.isWeekend(day);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.all(5.0),
      decoration:
          BoxDecoration(color: AppColors.redAlert, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: InterTextView(
        value: day.day.toString(),
        color: weekEnd ? AppColors.redAlert : Colors.white,
        size: SizeConfig.safeBlockHorizontal * 5.5,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Custom cell calendar
  Widget customwithinRangeBuilder(DateTime day) {
    final bool weekEnd = customGeneralCalendarController.isWeekend(day);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.all(2.0),
      alignment: Alignment.center,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: Text(
        day.day.toString(),
        style: TextStyle(
          color: weekEnd ? AppColors.redAlert : AppColors.blueDark,
          fontSize: SizeConfig.safeBlockHorizontal * 5,
        ),
      ),
    );
  }
}
