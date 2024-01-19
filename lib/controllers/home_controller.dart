import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Future<void> onInit() async {
    super.onInit();
    getApplicationData();
  }

  final CarouselController carouselController = CarouselController();
  final RxInt currentDot = RxInt(0);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxString username = RxString('');
  RxString userStatus = RxString('');
  RxString specialOffersTitle = RxString('');
  RxString aboutAutomotive = RxString('');
  RxString promoTitle = RxString('');
  RxList<String> promoImage = RxList<String>(<String>[]);
  RxList<String> contentImg = RxList<String>(<String>[]);
  RxList<String> contentTitle = RxList<String>(<String>[]);

  Future<void> getApplicationData() async {
    try {
      getContent();
      getPromoApps();
    } catch (error) {
      log(error.toString());
    }
  }

  dynamic refreshPage() async {
    getContent();
  }

  dynamic getContent() async {
    await _firestore
        .collection('home')
        .doc('data')
        .get()
        .then((DocumentSnapshot<dynamic> documentSnapshot) {
      final Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      aboutAutomotive.value = data['title'] as String;
      contentImg.value =
          List<String>.from(data['content']['content_img'] as List<dynamic>);
      contentTitle.value =
          List<String>.from(data['content']['content_title'] as List<dynamic>);
      update();
    });
  }

  dynamic getPromoApps() async {
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
  }
}
