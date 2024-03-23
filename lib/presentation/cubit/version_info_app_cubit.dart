import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../core/helpers/device_info.dart';

part 'version_info_app_state.dart';

class VersionInfoAppCubit extends Cubit<VersionInfoAppState> {
  VersionInfoAppCubit() : super(VersionInfoAppState.inital());
  Future<void> getApplicationInfo() async {
    final String? versionApp = await DeviceInfo().getVersionApp();
    final String? appName = await DeviceInfo().getAppName();
    emit(
      VersionInfoAppState(
        appYear: DateTime.now().year,
        versionApp: versionApp!,
        appName: appName!,
      ),
    );
  }
}
