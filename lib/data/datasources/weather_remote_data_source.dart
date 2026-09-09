import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/location_model.dart';
import '../models/weather_data_model.dart';
import '../models/weather_model.dart';
import '../models/forecast_model.dart';
import '../../core/error/failures.dart';

class WeatherRemoteDataSource {
  Future<LocationModel> getLocation(String city) async {
    final url = Uri.https(
      'geocoding-api.open-meteo.com',
      '/v1/search',
      {
        'name': city,
        'count': '5',
        'language': 'en',
        'format': 'json',
      }
    );

    try{

      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw ServerFailure('Failed to find location');
      }

      final data = jsonDecode(response.body);

      final results = data['results'];

      if (results == null || results.isEmpty) {
        throw LocationFailure('Location not found');
      }

      final location = results.firstWhere(
        (result) => result['country_code'] == 'ZA',
        orElse: () => results[0],
      );

      return LocationModel.fromJson(location);

    } catch (e) {
      if (e is Failure) {
        rethrow;
      } 
        
      if (e is SocketException) {
        throw NetworkFailure(
          'Could not connect to the network.'
        );
      }

      throw UnexpectedFailure(
        'An unexpected error occurred while finding the location.'
      );
    }
  }

  Future<WeatherDataModel> getWeather(
    double latitude, 
    double longitude,
    String city,
  ) async {
    final url = Uri.parse(
      'https://api.open-meteo.com/v1/forecast'
      '?latitude=$latitude'
      '&longitude=$longitude'
      '&current=temperature_2m,relative_humidity_2m,apparent_temperature,wind_speed_10m,weather_code'
      '&daily=weather_code,temperature_2m_max,temperature_2m_min'
      '&forecast_days=7'
      '&timezone=auto',
    );

    try {

      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw ServerFailure('Failed to fetch weather data');
      }

      final data = jsonDecode(response.body);

      final current = data['current'];
      final daily = data['daily'];

      final currentWeather = WeatherModel.fromJson(
        current,
        city: '$city',
      );

      final forecasts = ForecastModel.fromDailyJson(daily);

      return WeatherDataModel.fromModels(
        current: currentWeather,
        forecast: forecasts,
      );
    } catch (e) {
      if (e is Failure) {
        rethrow;
      }

      if (e is SocketException) {
        throw NetworkFailure(
          'Could not connect to the weather service.'
        );
      }

      throw UnexpectedFailure(
        'An unexpected error occurred while fetching weather data.'
      );
    }
  }
}