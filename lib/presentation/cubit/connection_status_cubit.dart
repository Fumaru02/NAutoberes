import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

part 'connection_status_state.dart';

class ConnectionStatusCubit extends Cubit<ConnectionStatusState> {
  ConnectionStatusCubit() : super(ConnectionStatusState.inital());
  final Connectivity _connectivity = Connectivity();

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
        // connectionType = 1;
        log('Network Error 1');

      case ConnectivityResult.mobile:
        // connectionType = 2;
        log('Network Error 2');

      case ConnectivityResult.none:
        // connectionType = 0;
        log('Network Error 0');

      // ignore: no_default_cases
      default:
        log('Network Error');
        break;
    }
  }
}
