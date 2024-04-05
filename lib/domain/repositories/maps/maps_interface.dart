import 'package:geolocator/geolocator.dart';

abstract class IMapsRepository {
  Future<void> openGoogleMap(String lat, String long);
  Future<Position> onGetCoordinateUser();
}
