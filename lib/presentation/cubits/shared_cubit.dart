import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

import '../../core/helpers/device_info.dart';

part 'shared_state.dart';

class SharedCubit extends Cubit<SharedState> {
  SharedCubit() : super(SharedState.inital());
  final Connectivity _connectivity = Connectivity();

  Future<void> getApplicationInfo() async {
    final String? versionApp = await DeviceInfo().getVersionApp();
    final String? appName = await DeviceInfo().getAppName();
    emit(state.copyWith(
        appName: appName,
        versionApp: versionApp,
        appYear: DateTime.now().year));
  }

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
        emit(state.copyWith(connectionType: 1));
      case ConnectivityResult.mobile:
        emit(state.copyWith(connectionType: 2));
      case ConnectivityResult.none:
        emit(state.copyWith(connectionType: 3));
      // ignore: no_default_cases
      default:
        emit(state.copyWith(connectionType: 4));
    }
  }

  late StreamSubscription<ConnectivityResult> _subscription;

  void trackConnectiviftyChange() {
    _subscription = _connectivity.onConnectivityChanged.listen(_updateState);
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
