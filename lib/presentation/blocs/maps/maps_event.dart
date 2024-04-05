part of 'maps_bloc.dart';

sealed class MapsEvent extends Equatable {
  const MapsEvent();

  @override
  List<Object> get props => <Object>[];
}

class GetCoordinateUser extends MapsEvent {}

class UpdatedMap extends MapsEvent {
  const UpdatedMap({
    required this.lat,
    required this.long,
  });
  final String lat;
  final String long;
}

class OpenMap extends MapsEvent {
  const OpenMap({
    required this.lat,
    required this.long,
  });
  final String lat;
  final String long;
}
