import 'package:geolocator/geolocator.dart';

abstract class LocationRepository {
  Future<Position> getCurrentPosition();

  Future<String> getCityName(
    double latitude,
    double longitude,
  );
}