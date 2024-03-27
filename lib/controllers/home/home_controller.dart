import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../domain/models/about_automotive_model.dart';
import '../../domain/models/beresin_menu_model.dart';
import '../../presentation/pages/home/home_menu/ganti_oli_view.dart';

class HomeController extends GetxController {
  final FirebaseStorage storage = FirebaseStorage.instance;

  ScrollController scrollController = ScrollController();
  final CarouselController carouselController = CarouselController();
  final RxInt currentDot = RxInt(0);
  RxString username = RxString('');
  RxString userStatus = RxString('');
  RxString specialOffersTitle = RxString('');
  RxString aboutAutomotiveTitle = RxString('');
  RxString gridMenuTitle = RxString('');
  RxString promoTitle = RxString('');
  RxString greetings = RxString('');
  RxList<String> promoImage = RxList<String>(<String>[]);
  RxList<AboutAutomotiveModel> aboutAutomotiveList =
      RxList<AboutAutomotiveModel>(<AboutAutomotiveModel>[]);
  RxList<BeresinMenuModel> beresinMenuList =
      RxList<BeresinMenuModel>(<BeresinMenuModel>[]);
  RxBool isLoading = RxBool(false);
  RxBool isVisible = RxBool(false);

  List<Widget> listRouter = <Widget>[
    const GantiOliView(),
  ];

  // dynamic refreshPage() async {
  //   await getContent();
  // }

  // dynamic getContent() async {
  //   isLoading.value = true;
  //   try {
  //     await _firestore
  //         .collection('home')
  //         .doc('data')
  //         .get()
  //         .then((DocumentSnapshot<dynamic> documentSnapshot) {
  //       final Map<String, dynamic> data =
  //           documentSnapshot.data() as Map<String, dynamic>;
  //       aboutAutomotiveTitle.value = data['title'] as String;
  //       gridMenuTitle.value = data['beresin_title'] as String;
  //       final List<dynamic> beresinMenuData =
  //           data['beresin_menu'] as List<dynamic>;
  //       beresinMenuList.value = beresinMenuData
  //           .map((dynamic e) =>
  //               BeresinMenuModel.fromJson(e as Map<String, dynamic>))
  //           .toList();
  //       final List<dynamic> aboutAutomotiveData =
  //           data['about_automotive'] as List<dynamic>;
  //       aboutAutomotiveList.value = aboutAutomotiveData
  //           .map((dynamic e) =>
  //               AboutAutomotiveModel.fromJson(e as Map<String, dynamic>))
  //           .toList();
  //     });
  //     update();
  //     isLoading.value = false;
  //   } catch (e) {
  //     isLoading.value = false;
  //     log(e.toString());
  //   }
  // }
}
