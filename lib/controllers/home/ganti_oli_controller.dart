import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/app_colors.dart';
import '../../presentation/widgets/custom/custom_calendar_picker.dart';

class GantiOliController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getListData();
  }

  Rx<DateTime> rangeStartGeneralCalendar = DateTime.now().obs;
  Rx<DateTime> rangeEndGeneralCalendar =
      DateTime.now().add(const Duration(days: 1)).obs;
  RxBool isCheckedJagoan = RxBool(false);
  RxDouble sliderVal = RxDouble(5);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<String> pilihKendaraanText = RxList<String>(<String>[]);
  RxString jenisKendaraanText = RxString('');
  final Rx<TimeOfDay> selectedStartTime = TimeOfDay.now().obs;
  final Rx<TimeOfDay> selectedEndTime =
      const TimeOfDay(hour: 11, minute: 0).obs;

  Future<void> showTimePickerDialog(Rx<TimeOfDay> selectedTime) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: Get.context!,
      initialTime: selectedTime.value,
    );

    if (timeOfDay != null) {
      selectedTime(timeOfDay);
    }
  }

  dynamic onChangeSlider(double val) {
    sliderVal.value = val;
  }

  dynamic onChangeKendaraan(String jenisKendaraan) {
    jenisKendaraanText.value = jenisKendaraan;
    Get.back();
  }

  Color onChangeTextColor() {
    return jenisKendaraanText.value != ''
        ? AppColors.black
        : AppColors.greyTextDisabled;
  }

  String onChangeText() {
    return jenisKendaraanText.value != ''
        ? jenisKendaraanText.value
        : 'Pilih Kendaraan';
  }

  dynamic onOpenCalendar() async {
    final dynamic result = await Get.to(
      const GeneralCalendar(),
      arguments: <String, dynamic>{
        'start_date': rangeStartGeneralCalendar.value,
        'end_date': rangeEndGeneralCalendar.value,
      },
    );

    if (result != null) {
      rangeStartGeneralCalendar.value = result[0] as DateTime;
      rangeEndGeneralCalendar.value = result[1] as DateTime;
    }
  }

  dynamic getListData() async {
    await _firestore
        .collection('data')
        .doc('text')
        .get()
        .then((DocumentSnapshot<dynamic> documentSnapshot) {
      final Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      pilihKendaraanText.value =
          List<String>.from(data['pilih_kendaraan'] as List<dynamic>);
      log(data.toString());
    });
  }
}
