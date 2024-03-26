import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../domain/models/brands_car_model.dart';
import '../domain/models/specialist_model.dart';
import '../presentation/pages/akun/widgets/select_cars.dart';
import '../presentation/pages/akun/widgets/select_specialist.dart';

class HomeServiceManagerController extends GetxController {
  final TextEditingController hsName = TextEditingController();
  final TextEditingController hsAddress = TextEditingController();
  final TextEditingController hsSkill = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? user;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  RxBool isLoading = RxBool(false);
  RxBool isLoadingBrands = RxBool(false);
  RxBool isSelected = RxBool(false);
  RxString selectedDropDownMenu = RxString('');
  File? workshopImage;
  ScrollController specialistScrollbar = ScrollController();
  //select brand list
  RxList<BrandsCarModel> brandsCarList =
      RxList<BrandsCarModel>(<BrandsCarModel>[]);
  RxList<BrandsCarModel> foundedBrand =
      RxList<BrandsCarModel>(<BrandsCarModel>[]);
  RxList<BrandsCarModel> selectedBrand =
      RxList<BrandsCarModel>(<BrandsCarModel>[]);
  //select specialist list
  RxList<SpecialistModel> specialistList =
      RxList<SpecialistModel>(<SpecialistModel>[]);
  RxList<SpecialistModel> specialistSelected =
      RxList<SpecialistModel>(<SpecialistModel>[]);
  RxList<SpecialistModel> foundedSpecialist =
      RxList<SpecialistModel>(<SpecialistModel>[]);

  String selectedBrandWrapper() {
    return selectedBrand.isEmpty
        ? 'Pilih brand yang kamu kuasai'
        : 'Brand yang kamu kuasai';
  }

  String selectedSpecialistWrapper() {
    return selectedBrand.isEmpty
        ? 'Pilih specialis yang kamu kuasai'
        : 'specialis yang kamu kuasai';
  }

  void verifySpecialist() {
    if (selectedDropDownMenu.isEmpty) {
      // Snack.show(SnackbarType.error, 'Error Getting Data',
      //     'Jenis kendaraan tidak boleh kosong');
    } else {
      Get.to(const SelectSpecialist());
    }
  }

  void verifyBrands() {
    if (selectedDropDownMenu.isEmpty) {
      // Snack.show(SnackbarType.error, 'Error Getting Data',
      //     'Jenis kendaraan tidak boleh kosong');
    } else {
      Get.to(const SelectCars());
    }
  }

  void toggleSelectionSpecialist(SpecialistModel item) {
    if (item.isSelected) {
      specialistSelected.remove(item);
    } else {
      specialistSelected.add(item);
    }
    item.isSelected = !item.isSelected;
    update();
  }

  void toggleSelectionBrand(BrandsCarModel item) {
    if (item.isSelected) {
      selectedBrand.remove(item);
    } else {
      selectedBrand.add(item);
    }
    item.isSelected = !item.isSelected;
    update();
  }

  void searchSpecialist(String query) {
    final List<SpecialistModel> suggestions =
        specialistList.where((SpecialistModel brandKey) {
      final String brandName = brandKey.brand.toLowerCase();
      final String input = query.toLowerCase();
      return brandName.contains(input);
    }).toList();

    foundedSpecialist.value = suggestions;
    update();
  }

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

  Future<void> getSpecialist(String type) async {
    try {
      selectedDropDownMenu.value = '';
      await _firestore
          .collection('data')
          .doc('specialist')
          .get()
          .then((DocumentSnapshot<dynamic> documentSnapshot) {
        final Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        final List<dynamic> specialistData = data[type] as List<dynamic>;
        specialistList.value = specialistData
            .map((dynamic e) =>
                SpecialistModel.fromJson(e as Map<String, dynamic>))
            .toList();
      });

      update();
      isLoadingBrands.value = false;
    } catch (e) {
      isLoadingBrands.value = false;

      log(e.toString());
    }
  }

  Future<void> getBrands(String type) async {
    isLoadingBrands.value = true;
    try {
      selectedDropDownMenu.value = '';
      await _firestore
          .collection('data')
          .doc('brands')
          .get()
          .then((DocumentSnapshot<dynamic> documentSnapshot) {
        final Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        final List<dynamic> carBrands = data[type] as List<dynamic>;
        brandsCarList.value = carBrands
            .map((dynamic e) =>
                BrandsCarModel.fromJson(e as Map<String, dynamic>))
            .toList();
      });
      if (type == 'brands_bike') {
        selectedDropDownMenu.value = 'Motor';
      } else {
        selectedDropDownMenu.value = 'Mobil';
      }
      selectedBrand.clear();
      update();
      isLoadingBrands.value = false;
    } catch (e) {
      isLoadingBrands.value = false;

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
        // return Snack.show(
        //     SnackbarType.error, 'Information', 'Failed to pick image');
      }
      final File imageTemp = File(image!.path);
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
      // Snack.show(SnackbarType.success, 'Image',
      //     'Image has been uploaded, Image will replaced after pressing Submit');
      isLoading.value = false;
    } on PlatformException catch (e) {
      isLoading.value = false;
      if (e.code != null) {
        // Snack.show(SnackbarType.error, 'Information', 'Failed to pick image');
      }
    }
    update();
  }

  Future<void> onConfirm(String lat, String long) async {
    isLoading.value = true;
    user = FirebaseAuth.instance.currentUser;
    log('$lat test1');
    if (lat == ''.trim() &&
        long == ''.trim() &&
        workshopImage == null &&
        hsName.text.trim() == null) {
      isLoading.value = false;

      return;
      // Snack.show(SnackbarType.error, 'ERROR Upload Data',
      //     'Pastikan kamu sudah mengisi form pendaftaran');
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
