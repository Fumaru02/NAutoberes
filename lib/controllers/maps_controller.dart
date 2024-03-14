import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helpers/snackbar.dart';
import '../utils/enums.dart';

class MapsController extends GetxController {
  final RxString lat = RxString('');
  final RxString long = RxString('');
  final RxBool isLoading = RxBool(false);

  Future<Position> getCurrentLocation() async {
    isLoading.value = true;
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future<Position>.error('Location Service are disabled');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      isLoading.value = false;
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      isLoading.value = false;
      return Future<Position>.error(
          'Location permissions are permanently denied, we cannot request');
    }
    isLoading.value = false;
    return Geolocator.getCurrentPosition();
  }

  void liveLocation() {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      if (position.isMocked) {
        Snack.show(
          SnackbarType.error,
          'ERROR'.tr,
          'Mohon matikan Fake GPS'.tr,
        );
        Get.back();
        return;
      } else {
        lat.value = '${position.latitude}';
        long.value = '${position.longitude}';
      }
    });
    log(lat.toString());
  }

  Future<void> openGoogleMap(String lat, String long) async {
    final Uri googleMapsUrl =
        Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$long');
    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl, mode: LaunchMode.inAppBrowserView);
    } else {
      // ignore: only_throw_errors
      log(googleMapsUrl.toString());
    }
  }

  Future<void> getCoordinateUser() async {
    isLoading.value = true;
    await getCurrentLocation().then((Position val) {
      if (val.isMocked) {
        Snack.show(
          SnackbarType.error,
          'ERROR'.tr,
          'Mohon matikan Fake GPS'.tr,
        );
        Get.back();
        return;
      } else {
        update();
        lat.value = '${val.latitude}';
        long.value = '${val.longitude}';
      }
    });
    liveLocation();
    isLoading.value = false;
  }
}
