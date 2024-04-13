import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../helpers/snackbar.dart';
import '../models/brands_car/brands_car_model.dart';
import '../models/city/city_model.dart';
import '../models/profiency/profiency_model.dart';
import '../models/specialist/specialist_model.dart';
import '../models/subdistrict/subdistrict_model.dart';
import '../utils/enums.dart';
import '../views/akun/widgets/select_cars.dart';
import '../views/akun/widgets/select_specialist.dart';

class RegisterHomeServiceManagerController extends GetxController {
  @override
  void onInit() {
    getProfince();
    super.onInit();
  }

  final TextEditingController hsName = TextEditingController();
  final TextEditingController hsAddress = TextEditingController();
  final TextEditingController hsSkill = TextEditingController();
  final TextEditingController hsDescription = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? user;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  RxBool isLoading = RxBool(false);
  RxBool isLoadingBrands = RxBool(false);
  RxBool isSelected = RxBool(false);
  RxInt defaultStepIndex = RxInt(0);
  RxString urlImage = RxString('');
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

  RxList<ProfiencyModel> profiencyList =
      RxList<ProfiencyModel>(<ProfiencyModel>[]);
  RxList<CityModel> cityList = RxList<CityModel>(<CityModel>[]);
  RxList<SubdistrictModel> subdistrictList =
      RxList<SubdistrictModel>(<SubdistrictModel>[]);
  RxString profince = RxString('');
  RxString city = RxString('');
  RxString subdistrict = RxString('');
  RxBool isChangeAddress = RxBool(false);

  String selectedBrandWrapper() {
    return selectedBrand.isEmpty
        ? 'Pilih brand yang kamu kuasai'
        : 'Brand yang kamu kuasai';
  }

  String selectedSpecialistWrapper() {
    return selectedBrand.isEmpty
        ? 'Pilih spesialis yang kamu kuasai'
        : 'Spesialis yang kamu kuasai';
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

  void verifySpecialist() {
    if (selectedDropDownMenu.isEmpty) {
      Snack.show(SnackbarType.error, 'Error Getting Data',
          'Jenis kendaraan tidak boleh kosong');
    } else {
      Get.to(const SelectSpecialist());
    }
  }

  void verifyBrands() {
    if (selectedDropDownMenu.isEmpty) {
      Snack.show(SnackbarType.error, 'Error Getting Data',
          'Jenis kendaraan tidak boleh kosong');
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
        isLoading.value = false;
        return Snack.show(
            SnackbarType.error, 'Information', 'Failed to pick image');
      }
      final File imageTemp = File(image.path);
      await ref.putFile(imageTemp, metadata);
      final String url = await ref.getDownloadURL();
      urlImage.value = url;
      workshopImage = imageTemp;
      Get.back();
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
    final List<Map<String, dynamic>> selectedBrandsData =
        selectedBrand.map((BrandsCarModel brand) => brand.toJson()).toList();
    final List<Map<String, dynamic>> specialistData = specialistSelected
        .map((SpecialistModel specialist) => specialist.toJson())
        .toList();
    if (lat == ''.trim() &&
        long == ''.trim() &&
        workshopImage == null &&
        hsName.text.trim() == null) {
      isLoading.value = false;
      return Snack.show(SnackbarType.error, 'ERROR Upload Data',
          'Pastikan kamu sudah mengisi form pendaftaran');
    } else {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('mechanic')
          .doc(selectedDropDownMenu.value)
          .set(<String, dynamic>{
        'handled_brands': selectedBrandsData,
        'handled_specialist': specialistData,
        'home_service': <String, dynamic>{
          'home_service_lat': lat,
          'home_service_long': long,
          'home_service_profince': profince.value,
          'home_service_city': city.value,
          'home_service_subdistrict': subdistrict.value,
          'home_service_name': hsName.text.trim(),
          'home_service_address': hsAddress.text.trim(),
          'home_service_skill': hsSkill.text.trim(),
          'home_mechanic_description': hsDescription.text.trim(),
        }
      });
      await FirebaseFirestore.instance
          .collection('mechanic')
          .doc(selectedDropDownMenu.value)
          .collection('name')
          .doc('${user!.displayName}${user!.uid}')
          .set(<String, dynamic>{
        'id': '${DateTime.now()}+${user!.uid}',
        'name': user!.displayName,
        'user_rating': 0.0,
        'user_level': 'Beginner',
        'user_email': user!.email,
        'user_uid': user!.uid,
        'home_service_lat': lat,
        'home_service_long': long,
        'home_service_image': urlImage.value,
        'home_service_profince': profince.value,
        'home_service_city': city.value,
        'home_service_subdistrict': subdistrict.value,
        'home_service_name': hsName.text.trim(),
        'home_service_address': hsAddress.text.trim(),
        'home_mechanic_description': hsDescription.text.trim(),
        'home_service_skill': hsSkill.text.trim(),
        'handled_brands': selectedBrandsData,
        'handled_specialist': specialistData,
      });
      isLoading.value = false;
      Get.back();
      Get.back();
    }
  }
}
