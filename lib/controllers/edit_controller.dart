import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../helpers/snackbar.dart';
import '../models/profiency/profiency_model.dart';
import '../utils/enums.dart';

class EditController extends GetxController {
  @override
  void onInit() {
    getProfiency();
    super.onInit();
  }

  TextEditingController usernameTextEditingController = TextEditingController();
  TextEditingController descriptionTextEditingController =
      TextEditingController();
  File? image;
  RxList<ProfiencyModel> profiencyList =
      RxList<ProfiencyModel>(<ProfiencyModel>[]);

  Future<dynamic> getProfiency() async {
    final http.Response response = await http.get(Uri.parse(
        'https://fumaru02.github.io/api-wilayah-indonesia/api/provinces.json'));
    final List<dynamic> body = json.decode(response.body) as List<dynamic>;
    profiencyList.value = body
        .map((e) => ProfiencyModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<dynamic> pickImageFromGallery() async {
    try {
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return Snack.show(
            SnackbarType.error, 'Information', 'Failed to pick image');
      }
      final File imageTemp = File(image.path);
      this.image = imageTemp;
    } on PlatformException catch (e) {
      if (e.code != null) {
        Snack.show(SnackbarType.error, 'Information', 'Failed to pick image');
      }
    }
    update();
  }

  Future<dynamic> pickImageFromCamera() async {
    try {
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) {
        return Snack.show(
            SnackbarType.error, 'Information', 'Failed to pick image');
      }
      final File imageTemp = File(image.path);
      this.image = imageTemp;
    } on PlatformException catch (e) {
      if (e.code != null) {
        Snack.show(SnackbarType.error, 'Information', 'Failed to pick image');
      }
    }
    update();
  }
}
