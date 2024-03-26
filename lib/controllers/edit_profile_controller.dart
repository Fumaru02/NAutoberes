import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../domain/models/city_model.dart';
import '../domain/models/profiency_model.dart';
import '../domain/models/subdistrict_model.dart';
import 'akun_controller.dart';

class EditProfileController extends GetxController {
  @override
  void onInit() {
    getProfince();
    super.onInit();
  }

  TextEditingController usernameTextEditingController = TextEditingController();
  TextEditingController descriptionTextEditingController =
      TextEditingController();
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final AkunController akunController = AkunController();

  User? user;
  File? image;
  RxList<ProfiencyModel> profiencyList =
      RxList<ProfiencyModel>(<ProfiencyModel>[]);
  RxList<CityModel> cityList = RxList<CityModel>(<CityModel>[]);
  RxList<SubdistrictModel> subdistrictList =
      RxList<SubdistrictModel>(<SubdistrictModel>[]);
  RxString profince = RxString('');
  RxString city = RxString('');
  RxString subdistrict = RxString('');
  RxString userImage = RxString('');
  RxBool isChangeAddress = RxBool(false);

  Future<dynamic> updateData(String gender) async {
    try {
      user = FirebaseAuth.instance.currentUser;
      if (profince.value == '') {
        return;
      }
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update(<Object, Object?>{
        'profiency': profince.value,
        'city': city.value,
        'subdistrict': subdistrict.value,
        'gender': gender
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<dynamic> getProfince() async {
    final http.Response response = await http.get(Uri.parse(
        'https://fumaru02.github.io/api-wilayah-indonesia/api/provinces.json'));
    final List<dynamic> body = json.decode(response.body) as List<dynamic>;
    profiencyList.value = body
        .map((dynamic e) => ProfiencyModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<dynamic> getCity(String query) async {
    final http.Response response = await http.get(Uri.parse(
        'https://fumaru02.github.io/api-wilayah-indonesia/api/regencies/$query.json'));
    final List<dynamic> body = json.decode(response.body) as List<dynamic>;
    cityList.value = body
        .map((dynamic e) => CityModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<dynamic> getSubdistrict(String query) async {
    final http.Response response = await http.get(Uri.parse(
        'https://fumaru02.github.io/api-wilayah-indonesia/api/districts/$query.json'));
    final List<dynamic> body = json.decode(response.body) as List<dynamic>;
    subdistrictList.value = body
        .map(
            (dynamic e) => SubdistrictModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<dynamic> pickImage(ImageSource source) async {
    try {
      user = FirebaseAuth.instance.currentUser;

      final SettableMetadata metadata =
          SettableMetadata(contentType: 'image/jpeg');
      final XFile? image = await ImagePicker().pickImage(source: source);
      final Reference ref = firebaseStorage
          .ref('users')
          .child('user_gallery')
          .child(user!.displayName!)
          .child('${user!.uid}.jpeg');

      if (image == null) {
        return;
        // Snack.show(SnackbarType.error, 'Information', 'Failed to pick image');
      }
      final File imageTemp = File(image.path);
      await ref.putFile(imageTemp, metadata);
      final String url = await ref.getDownloadURL();
      Get.back();
      // Snack.show(SnackbarType.success, 'Image',
      //     'Image has been uploaded, Image will replaced after pressing Submit');
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update(<Object, Object?>{'user_image': url});
    } on PlatformException catch (e) {
      if (e.code != null) {
        // Snack.show(SnackbarType.error, 'Information', 'Failed to pick image');
      }
    }
    update();
  }
}
