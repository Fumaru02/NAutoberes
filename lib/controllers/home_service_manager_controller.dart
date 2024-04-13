import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

class HomeServiceManagerController extends GetxController {
  RxInt touchedDefaultIndex = RxInt(0);

  Future<void> getMechanicData() async {
//lanjut bikin data
  }

  void touchCallBack(FlTouchEvent event, PieTouchResponse? pieTouchResponse) {
    if (!event.isInterestedForInteractions ||
        pieTouchResponse == null ||
        pieTouchResponse.touchedSection == null) {
      touchedDefaultIndex.value = -1;
      update();
      return;
    }
    touchedDefaultIndex.value =
        pieTouchResponse.touchedSection!.touchedSectionIndex;
    update();
  }
}
