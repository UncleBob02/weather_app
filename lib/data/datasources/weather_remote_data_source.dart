import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherRemoteDataSource {
  Future<Map<String, dynamic>> getLocation(String city) async {
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

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to find location');
    }

    final data = jsonDecode(response.body);
    final results = data['results'];

    if (results == null || results.isEmpty) {
      throw Exception('Location not found');
    }

    return results.firstWhere(
      (result) => result['country_code'] == 'ZA',
      orElse: () => results[0],
    );
  }

  Future<Map<String, dynamic>> getWeather(double latitude, double longitude) async {
    final url = Uri.parse(
      'https://api.open-meteo.com/v1/forecast'
      '?latitude=$latitude'
      '&longitude=$longitude'
      '&current=temperature_2m,relative_humidity_2m,apparent_temperature,wind_speed_10m,weather_code'
      '&daily=weather_code,temperature_2m_max,temperature_2m_min'
      '&forecast_days=7'
      '&timezone=auto',
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch weather data');
    }

    return jsonDecode(response.body);
  }
}