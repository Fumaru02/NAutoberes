part of 'shared_cubit.dart';

class SharedState extends Equatable {
  const SharedState({
    this.connectionType = 0,
    this.versionApp = '',
    this.appName = '',
    this.appYear = 0,
  });

  factory SharedState.inital() => const SharedState();

  final int connectionType;
  final String versionApp;
  final String appName;
  final int appYear;

  @override
  List<Object> get props =>
      <Object>[connectionType, versionApp, appName, appYear];

  SharedState copyWith({
    int? connectionType,
    String? versionApp,
    String? appName,
    int? appYear,
  }) {
    return SharedState(
      connectionType: connectionType ?? this.connectionType,
      versionApp: versionApp ?? this.versionApp,
      appName: appName ?? this.appName,
      appYear: appYear ?? this.appYear,
    );
  }

  @override
  String toString() {
    return 'SharedState(connectionType: $connectionType, versionApp: $versionApp, appName: $appName, appYear: $appYear)';
  }
}
