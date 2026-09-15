import 'package:geolocator/geolocator.dart';

import '../repositories/location_repository.dart';

class GetCurrentLocation {
  final LocationRepository repository;

  const GetCurrentLocation(this.repository);

  Future<Position> call() {
    return repository.getCurrentPosition();
  }
}