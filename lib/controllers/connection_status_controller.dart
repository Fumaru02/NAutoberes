import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../helpers/snackbar.dart';
import '../utils/enums.dart';

class ConnectionStatusController extends GetxController {
  //this variable 0 = No Internet, 1 = connected to WIFI ,2 = connected to Mobile Data.
  int connectionType = 0;
  //Instance of Flutter Connectivity
  final Connectivity _connectivity = Connectivity();
  //Stream to keep listening to network change state
  StreamSubscription<dynamic>? _streamSubscription;
  @override
  void onInit() {
    getConnectionType();
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen(_updateState);
    super.onInit();
  }

  // a method to get which connection result, if you we connected to internet or no if yes then which network
  Future<void> getConnectionType() async {
    ConnectivityResult? connectivityResult;
    try {
      connectivityResult = await _connectivity.checkConnectivity();
      await _updateState(connectivityResult);
    } on PlatformException catch (e) {
      log(e.toString());
    }
    return _updateState(connectivityResult!);
  }

  dynamic _updateState(ConnectivityResult result) {
    switch (result) {
      
      case ConnectivityResult.wifi:
        connectionType = 1;
        update();
      case ConnectivityResult.mobile:
        connectionType = 2;
        update();
      case ConnectivityResult.none:
        connectionType = 0;
        update();
        Snack.show(
          SnackbarType.error,
          'Network_error'.tr,
          'Network Error please check your connection'.tr,
        );
      // ignore: no_default_cases
      default:
        Get.snackbar('Network Error', 'Failed to get Network Status');
        break;
    }
  }

  @override
  void onClose() {
    //stop listening to network state when app is closed
    _streamSubscription?.cancel();
    super.onClose();
  }
}
