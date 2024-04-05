import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

import 'maps_interface.dart';

class MapsRepository implements IMapsRepository {
  @override
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

  @override
  Future<Position> onGetCoordinateUser() async {
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future<Position>.error('Location Service are disabled');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      return Future<Position>.error(
          'Location permissions are permanently denied, we cannot request');
    }
    return Geolocator.getCurrentPosition();
  }
}
