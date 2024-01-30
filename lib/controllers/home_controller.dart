import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../models/about_automotive/about_automotive_model.dart';

class HomeController extends GetxController {
  final FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getApplicationData();
    getContent();
  }

  final CarouselController carouselController = CarouselController();
  final RxInt currentDot = RxInt(0);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxString username = RxString('');
  RxString userStatus = RxString('');
  RxString specialOffersTitle = RxString('');
  RxString aboutAutomotiveTitle = RxString('');
  RxString promoTitle = RxString('');
  RxList<String> promoImage = RxList<String>(<String>[]);
  RxList<AboutAutomotiveModel> aboutAutomotiveList =
      RxList<AboutAutomotiveModel>(<AboutAutomotiveModel>[]);

  Future<void> getApplicationData() async {
    try {
      getPromoApps();
    } catch (error) {
      log(error.toString());
    }
  }

  dynamic refreshPage() async {
    getContent();
  }

  dynamic getContent() async {
    try {
      await _firestore
          .collection('home')
          .doc('data')
          .get()
          .then((DocumentSnapshot<dynamic> documentSnapshot) {
        final Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        aboutAutomotiveTitle.value = data['title'] as String;

        final List<dynamic> aboutAutomotiveData =
            data['about_automotive'] as List<dynamic>;
        aboutAutomotiveList.value = aboutAutomotiveData
            .map((dynamic e) =>
                AboutAutomotiveModel.fromJson(e as Map<String, dynamic>))
            .toList();
        log(aboutAutomotiveList.toString());
        update();
      });
    } catch (e) {
      log(e.toString());
    }
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
