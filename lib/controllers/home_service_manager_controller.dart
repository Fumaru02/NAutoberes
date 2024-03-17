import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../helpers/snackbar.dart';
import '../models/brands_car/brands_car_model.dart';
import '../utils/enums.dart';

class HomeServiceManagerController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getBrands();
  }

  final TextEditingController hsName = TextEditingController();
  final TextEditingController hsAddress = TextEditingController();
  final TextEditingController hsSkill = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? user;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  RxBool isLoading = RxBool(false);
  RxBool isSelected = RxBool(false);
  File? workshopImage;
  RxList<BrandsCarModel> brandsCarList =
      RxList<BrandsCarModel>(<BrandsCarModel>[]);
  RxList<BrandsCarModel> foundedBrand =
      RxList<BrandsCarModel>(<BrandsCarModel>[]);
  // RxList<BrandsCarModel> selectedBrand =
  //     RxList<BrandsCarModel>(<BrandsCarModel>[]);

  void searchBrand(String query) {
    final List<BrandsCarModel> suggestions =
        brandsCarList.where((BrandsCarModel brandKey) {
      final String brandName = brandKey.brand.toLowerCase();
      final String input = query.toLowerCase();
      return brandName.contains(input);
    }).toList();

    foundedBrand.value = suggestions;
    update();
  }

  Future<void> getBrands() async {
    isLoading.value = true;
    try {
      await _firestore
          .collection('data')
          .doc('brands')
          .get()
          .then((DocumentSnapshot<dynamic> documentSnapshot) {
        final Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        final List<dynamic> carBrands = data['brands_car'] as List<dynamic>;
        brandsCarList.value = carBrands
            .map((dynamic e) =>
                BrandsCarModel.fromJson(e as Map<String, dynamic>))
            .toList();
        log(data.toString());
      });
      update();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }

  Future<dynamic> pickImage(ImageSource source) async {
    isLoading.value = true;
    try {
      user = FirebaseAuth.instance.currentUser;
      final SettableMetadata metadata =
          SettableMetadata(contentType: 'image/jpeg');
      final XFile? image = await ImagePicker().pickImage(source: source);
      final Reference ref = firebaseStorage
          .ref('users')
          .child('user_gallery')
          .child(user!.displayName!)
          .child('home_service')
          .child('${user!.uid}.jpeg');

      if (image == null) {
        return Snack.show(
            SnackbarType.error, 'Information', 'Failed to pick image');
      }
      final File imageTemp = File(image.path);
      await ref.putFile(imageTemp, metadata);
      final String url = await ref.getDownloadURL();
      workshopImage = imageTemp;
      await FirebaseFirestore.instance
          .collection('mechanic')
          .doc('${user!.displayName}${user!.uid}')
          .set(<String, dynamic>{
        'home_service_image': url,
      });
      Get.back();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update(<String, dynamic>{
        'home_service_image': url,
      });
      update();
      Snack.show(SnackbarType.success, 'Image',
          'Image has been uploaded, Image will replaced after pressing Submit');
      isLoading.value = false;
    } on PlatformException catch (e) {
      isLoading.value = false;
      if (e.code != null) {
        Snack.show(SnackbarType.error, 'Information', 'Failed to pick image');
      }
    }
    update();
  }

  Future<void> onConfirm(String lat, String long) async {
    isLoading.value = true;
    user = FirebaseAuth.instance.currentUser;
    log('$lat test1');
    if (lat == '' && long == '') {
      isLoading.value = false;

      return Snack.show(SnackbarType.error, 'ERROR Upload Data',
          'Pastikan kamu sudah klik pada icon radius');
    } else {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update(<String, dynamic>{
        'mechanic': 1,
        'home_service': <String, dynamic>{
          'home_service_lat': lat,
          'home_service_long': long,
          'home_service_name': hsName.text.trim(),
          'home_service_address': hsAddress.text.trim(),
          'home_service_skill': hsSkill.text.trim(),
        }
      });
      await FirebaseFirestore.instance
          .collection('mechanic')
          .doc('${user!.displayName}${user!.uid}')
          .update(<String, dynamic>{
        'id': '${DateTime.now()}+${user!.uid}',
        'name': user!.displayName,
        'user_rating': 0.0,
        'user_level': 'Beginner',
        'user_email': user!.email,
        'user_uid': user!.uid,
        'home_service_lat': lat,
        'home_service_long': long,
        'home_service_name': hsName.text.trim(),
        'home_service_address': hsAddress.text.trim(),
        'home_service_skill': hsSkill.text.trim(),
      });
      isLoading.value = false;
      Get.back();
    }
  }
}
