import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../domain/models/about_automotive_model.dart';
import '../../domain/models/beresin_menu_model.dart';
import '../../presentation/pages/home/home_menu/ganti_oli_view.dart';

class HomeController extends GetxController {
  final FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getApplicationData();
    updateGreating();
    getContent();
    scrollController.addListener(() {
      listen();
    });
  }

  @override
  void onClose() {
    scrollController.dispose();
    scrollController.removeListener(() {
      listen();
    });
    super.onClose();
  }

  ScrollController scrollController = ScrollController();
  final CarouselController carouselController = CarouselController();
  final RxInt currentDot = RxInt(0);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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

  void updateGreating() {
    final int hour = DateTime.now().hour;
    if (hour >= 5 && hour < 10) {
      greetings.value = 'Selamat Pagi';
    } else if (hour >= 10 && hour < 15) {
      greetings.value = 'Selamat Siang';
    } else if (hour >= 15 && hour < 18) {
      greetings.value = 'Selamat Sore';
    } else {
      greetings.value = 'Selamat Malam';
    }
    update();
  }

  void listen() {
    final ScrollDirection direction =
        scrollController.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      isVisible.value = false;
    } else if (direction == ScrollDirection.reverse) {
      isVisible.value = true;
    } else {}
  }

  Future<void> getApplicationData() async {
    try {
      getPromoApps();
    } catch (error) {
      log(error.toString());
    }
  }

  dynamic refreshPage() async {
    await getContent();
  }

  dynamic getContent() async {
    isLoading.value = true;
    try {
      await _firestore
          .collection('home')
          .doc('data')
          .get()
          .then((DocumentSnapshot<dynamic> documentSnapshot) {
        final Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        aboutAutomotiveTitle.value = data['title'] as String;
        gridMenuTitle.value = data['beresin_title'] as String;
        final List<dynamic> beresinMenuData =
            data['beresin_menu'] as List<dynamic>;
        beresinMenuList.value = beresinMenuData
            .map((dynamic e) =>
                BeresinMenuModel.fromJson(e as Map<String, dynamic>))
            .toList();
        final List<dynamic> aboutAutomotiveData =
            data['about_automotive'] as List<dynamic>;
        aboutAutomotiveList.value = aboutAutomotiveData
            .map((dynamic e) =>
                AboutAutomotiveModel.fromJson(e as Map<String, dynamic>))
            .toList();
      });
      update();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }

  dynamic getPromoApps() async {
    isLoading.value = true;
    await _firestore
        .collection('home')
        .doc('promo')
        .get()
        .then((DocumentSnapshot<dynamic> documentSnapshot) {
      final Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;

      promoImage.value =
          List<String>.from(data['promo']['promo_image'] as List<dynamic>);
      promoTitle.value = data['promo']['promo_title'] as String;
    });
    update();
    isLoading.value = false;
  }
}
