import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'home/ganti_oli_controller.dart';

class CustomGeneralCalendarController extends GetxController {
  @override
  void onInit() {
    // sign value
    super.onInit();
    assignValue();
  }

  final GantiOliController gantiOliController = Get.find();

  DateTime? startDayValidation;
  bool isSingleDate = false;

  // default first day calendar
  DateTime firstDayCalendar = DateTime.utc(2010, 10, 16);
  // default last day calendar
  DateTime lastDayCalendar = DateTime.utc(2030, 10, 16);
  // default format calendar
  CalendarFormat calendarFormat = CalendarFormat.month;
  RangeSelectionMode rangeSelectionMode = RangeSelectionMode
      .toggledOn; // Can be toggled on/off by longpressing a daPte
  DateTime focusedDayGeneralCalendar = DateTime.now();
  DateTime? selectedDayGeneralCalendar;
  DateTime? rangeStartGeneralCalendar;
  DateTime? rangeEndGeneralCalendar;

  // list event date
  List<dynamic> eventsDate = <dynamic>[];
  // list when selected date
  List<dynamic> filteredEventDate = <dynamic>[];

  bool isWeekend(
    DateTime day, {
    List<int> weekendDays = const <int>[DateTime.sunday],
  }) {
    return weekendDays.contains(day.weekday);
  }

  void assignValue() {
    final dynamic date = Get.arguments;
    if (date['start_date'] != null && date['end_date'] != null) {
      rangeStartGeneralCalendar = date['start_date'] as DateTime;
      rangeEndGeneralCalendar = date['end_date'] as DateTime;
    }
    // startDayValidation = DateTime(2019, 1, 1);
    startDayValidation = DateTime(2019);
    update(<Object>['generalCalendar']);
  }

  // selected day
  void daySelectedGeneralCalendar(DateTime selectedDay, DateTime focusedDay) {
    rangeEndGeneralCalendar = selectedDay;
    update(<Object>['generalCalendar']);

    if (selectedDay.isBefore(rangeStartGeneralCalendar!)) {
      rangeStartGeneralCalendar = selectedDay;
      rangeEndGeneralCalendar = null;
      update(<Object>['generalCalendar']);
    } else {
      if (rangeStartGeneralCalendar == rangeEndGeneralCalendar) {
        Future<void>.delayed(const Duration(milliseconds: 100), () {
          Get.back(
            result: <DateTime?>[
              rangeStartGeneralCalendar,
              rangeEndGeneralCalendar
            ],
          );
          gantiOliController.showTimePickerDialog(
            gantiOliController.selectedEndTime,
          );
          gantiOliController.showTimePickerDialog(
            gantiOliController.selectedStartTime,
          );
        });
      } else {
        Future<void>.delayed(const Duration(milliseconds: 100), () {
          Get.back(
            result: <DateTime?>[
              rangeStartGeneralCalendar,
              rangeEndGeneralCalendar
            ],
          );
        });
      }
    }
  }

  // format Change
  void formatChangeGeneralCalendar(CalendarFormat format) {
    if (calendarFormat != format) {
      calendarFormat = format;
      update(<Object>['generalCalendar']);
    }
  }

  // page change
  void pageChangeGeneralCalendar(DateTime focusedDay) {
    focusedDayGeneralCalendar = focusedDay;
    // update widget
    update(<Object>['generalCalendar']);
  }

  // range change
  void onRangeSelectedGeneralCalendar(
    DateTime? start,
    DateTime? end,
    DateTime focusedDay,
  ) {
    selectedDayGeneralCalendar = null;
    focusedDayGeneralCalendar = focusedDay;
    rangeStartGeneralCalendar = start;
    rangeEndGeneralCalendar = end;
    update(<Object>['generalCalendar']);
  }

  RangeSelectionMode onSetSelectionMode() {
    if (rangeEndGeneralCalendar == null) {
      return RangeSelectionMode.disabled;
    } else {
      return RangeSelectionMode.enforced;
    }
  }

  String startDateText() {
    return rangeStartGeneralCalendar != null
        ? DateFormat(
            "d ${isSingleDate ? "MMMM" : 'MMM'} y",
          ).format(
            rangeStartGeneralCalendar!,
          )
        : 'Select Date';
  }

  String endDateText() {
    return rangeEndGeneralCalendar != null
        ? DateFormat('d MMM y').format(
            rangeEndGeneralCalendar!,
          )
        : 'Select Date';
  }
}
