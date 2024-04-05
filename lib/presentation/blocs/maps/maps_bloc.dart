import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

import '../../../core/routes/app_routes.dart';
import '../../../domain/repositories/maps/maps_interface.dart';
import '../../../domain/repositories/maps/maps_repository.dart';

part 'maps_event.dart';
part 'maps_state.dart';

class MapsBloc extends Bloc<MapsEvent, MapsState> {
  MapsBloc() : super(MapsState.initial()) {
    on<OpenMap>(_onOpenMaps);
    on<GetCoordinateUser>(_onGetCoordinate);
    on<UpdatedMap>(_onGetNewCoordinate);
  }
  final IMapsRepository _mapsRepository = MapsRepository();

  Future<void> _onOpenMaps(OpenMap event, Emitter<MapsState> emit) async {
    await _mapsRepository.openGoogleMap(event.lat, event.long);
  }

  Future<void> _onGetCoordinate(
      GetCoordinateUser event, Emitter<MapsState> emit) async {
    emit(state.copyWith(mapsStatus: MapsStatus.loading));
    await _mapsRepository.onGetCoordinateUser().then((Position val) {
      if (val.isMocked) {
        emit(state.copyWith(mapsStatus: MapsStatus.failed));
        router.pop();
        return;
      } else {
        emit(state.copyWith(
          lat: val.latitude.toString(),
          long: val.longitude.toString(),
        ));
      }
    });
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position val) {
      if (val.isMocked) {
        emit(state.copyWith(mapsStatus: MapsStatus.failed));

        router.pop();
        return;
      } else {
        add(UpdatedMap(
            lat: val.latitude.toString(), long: val.longitude.toString()));
      }
    });
  }

  void _onGetNewCoordinate(UpdatedMap event, Emitter<MapsState> emit) {
    emit(state.copyWith(
      lat: event.lat,
      long: event.long,
    ));
  }
}
