import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getApplicationData();
    getDataUser();
  }

  final CarouselController carouselController = CarouselController();
  final RxInt currentDot = RxInt(0);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RxString username = RxString('');
  RxString userStatus = RxString('');
  RxList<String> imageUrl = RxList<String>(<String>[]);

  Future<void> getApplicationData() async {
    try {
      final ListResult result =
          await storage.ref().child('landing_image/').listAll();

      for (final Reference ref in result.items) {
        imageUrl.add(await storage.ref(ref.fullPath).getDownloadURL());
      }
      log(imageUrl.toList().toString());
    } catch (error) {
      print('Error fetching image URL: $error');
    }
  }

  dynamic getDataUser() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot<dynamic> documentSnapshot) {
      username.value = documentSnapshot.data()['username'] as String;
      userStatus.value = documentSnapshot.data()['status'] as String;
    });
    update();
  }
}
