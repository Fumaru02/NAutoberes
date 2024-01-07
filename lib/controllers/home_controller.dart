import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getDataUser();
  }

  final CarouselController carouselController = CarouselController();
  final RxInt currentDot = RxInt(0);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RxString username = RxString('');
  RxString userStatus = RxString('');

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
