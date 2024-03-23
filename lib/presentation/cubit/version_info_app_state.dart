part of 'version_info_app_cubit.dart';

class VersionInfoAppState extends Equatable {
  const VersionInfoAppState({
    required this.versionApp,
    required this.appName,
    required this.appYear,
  });
  factory VersionInfoAppState.inital() =>
      const VersionInfoAppState(versionApp: '', appName: '', appYear: 0);

  final String versionApp;
  final String appName;
  final int appYear;

  @override
  List<Object> get props => <Object>[versionApp, appName, appYear];

  @override
  String toString() =>
      'VersionInfoAppState(versionApp: $versionApp, appName: $appName, appYear: $appYear)';

  VersionInfoAppState copyWith({
    String? versionApp,
    String? appName,
    int? appYear,
  }) {
    return VersionInfoAppState(
      versionApp: versionApp ?? this.versionApp,
      appName: appName ?? this.appName,
      appYear: appYear ?? this.appYear,
    );
  }
}
