import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import '../models/current_location_model.dart';
import '../../core/error/failures.dart';

abstract class LocationDataSource {
  Future<Position> getCurrentPosition();

  Future<String> getCityName(
    double latitude,
    double longitude,
  );
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

  @override
  Future<String> getCityName(
    double latitude, 
    double longitude,
  ) async {
    final url = Uri.http(
      'api.bigdatacloud.net',
      '/data/reverse-geocode-client',
      {
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
        'localityLanguage': 'en',
      },
    );

    try {
      final response =  await http.get(url);

      if (response.statusCode !=200) {
        throw const LocationFailure(
          'Could not determine your city.',
        );
      }

      final data = jsonDecode(response.body);

      final location = CurrentLocationModel.fromJson(data);

      return location.city;
    } 
    catch (e) {
      if (e is Failure) {
        rethrow;
      }

      throw const LocationFailure(
        'Could not determine your city.'
      );
    }
  }
}