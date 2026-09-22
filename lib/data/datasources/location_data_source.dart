import 'package:geolocator/geolocator.dart';
import '../../core/error/failures.dart';

abstract class LocationDataSource {
  Future<Position> getCurrentPosition();
}

class LocationDataSourceImpl implements LocationDataSource {
  @override
  Future<Position> getCurrentPosition() async {
    final serviceEnabled = 
      await Geolocator.isLocationServiceEnabled();

    if(!serviceEnabled) {
      throw const LocationServiceFailure(
        'Location services are disabled.'
      );
    }

    LocationPermission permission = 
      await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      throw const LocationPermissionFailure(
        'Location permission was denied'
      );
    }

    if (permission == LocationPermission.deniedForever) {
      throw const LocationPermissionPermanentlyDeniedFailure(
        'Location permission was permanently denied.',
      );
    }

    try {
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      throw const LocationFailure(
        'Could not determine your location'
      );
    }
  }
}