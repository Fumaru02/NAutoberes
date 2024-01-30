import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

abstract class IDeviceInfo {
  Future<AndroidDeviceInfo> initAndroid();
}

class DeviceInfo implements IDeviceInfo {
  @protected
  @override
  Future<AndroidDeviceInfo> initAndroid() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo;
  }

  /// Return device ID
  Future<String?> getDeviceId() async {
    String? result;
    if (Platform.isAndroid) {
      await const AndroidId().getId().then((String? id) {
        result = id;
      });
      return result;
    } else {
      return null;
    }
  }

  // get sdk version
  Future<int?> getDeviceSdkAndroid() async {
    final AndroidDeviceInfo androidInfo = await initAndroid();
    return androidInfo.version.sdkInt;
  }

  Future<String?> getVersionApp() async {
    final PackageInfo appInfo = await PackageInfo.fromPlatform();
    return appInfo.version;
  }

  Future<String?> getAppName() async {
    final PackageInfo appInfo = await PackageInfo.fromPlatform();
    return appInfo.appName;
  }
}
