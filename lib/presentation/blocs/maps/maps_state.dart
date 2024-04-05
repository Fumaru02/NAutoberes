part of 'maps_bloc.dart';

enum MapsStatus { initial, loading, success, failed }

class MapsState extends Equatable {
  const MapsState({
    required this.mapsStatus,
    required this.lat,
    required this.long,
  });

  factory MapsState.initial() =>
      const MapsState(mapsStatus: MapsStatus.initial, lat: '', long: '');

  final MapsStatus mapsStatus;
  final String lat;
  final String long;

  @override
  List<Object> get props => <Object>[mapsStatus, lat, long];

  MapsState copyWith({
    MapsStatus? mapsStatus,
    String? lat,
    String? long,
  }) {
    return MapsState(
      mapsStatus: mapsStatus ?? this.mapsStatus,
      lat: lat ?? this.lat,
      long: long ?? this.long,
    );
  }

  @override
  String toString() =>
      'MapsState(mapsStatus: $mapsStatus, lat: $lat, long: $long)';
}
