import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class WeatherService {
  String _getWeatherCondition(int code) {
    if(code == 0) {
      return 'Clear sky';
    }
    else if (code == 1 || code == 2 || code == 3) {
      return 'Partly cloudy';
    }
    else if (code >= 45 && code <= 48) {
      return 'Fog';
    }
    else if (code >= 51 && code <= 57) {
      return 'Drizzle';
    }
    else if (code >= 61 && code <= 67) {
      return 'Rain';
    }
    else if (code >= 71 && code <= 77) {
      return 'Snow';
    }
    else if (code == 77) {
      return 'Snow grains';
    }
    else if (code >= 80 && code <= 82) {
      return 'Rain showers';
    }
    else if (code >= 85 && code <= 86) {
      return 'Snow showers';
    }
    else if (code >= 95 && code <= 99) {
      return 'Thunderstorm';
    }
    else {
      return 'Unknown weather condition';
    }
  }

  Future<WeatherData> getWeather(String city) async {
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

    print('Status: ${response.statusCode}');
    print('Response: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to find location');
    }

    final data = jsonDecode(response.body);

    final results = data['results'];

    if (results == null || results.isEmpty) {
      throw Exception('Location not found');
    }

    final location = results.firstWhere(
      (result) => result['country_code'] == 'ZA',
      orElse: () => results[0],
    );

    final latitude = location['latitude'];
    final longitude = location['longitude'];

    print('Latitude: $latitude');
    print('Longitude: $longitude');

    final weatherUrl = Uri.parse(
      'https://api.open-meteo.com/v1/forecast'
      '?latitude=$latitude'
      '&longitude=$longitude'
      '&current=temperature_2m,relative_humidity_2m,apparent_temperature,wind_speed_10m,weather_code'
      '&daily=weather_code,temperature_2m_max,temperature_2m_min'
      '&forecast_days=7'
      '&timezone=auto',
    );

    final weatherResponse = await http.get(weatherUrl);

    if (weatherResponse.statusCode != 200) {
      throw Exception('Failed to fetch weather data');
    }

    final weatherData = jsonDecode(weatherResponse.body);

    final current = weatherData['current'];
    final daily = weatherData['daily'];

    final weatherCode = current['weather_code'];
    final forecasts = <Forecast>[];

    for (int i = 0; i < daily['time'].length; i++) {
      forecasts.add(
        Forecast(
          date: DateTime.parse(daily['time'][i]),
          weatherCode: daily['weather_code'][i],
          maxTemperature: daily['temperature_2m_max'][i],
          minTemperature: daily['temperature_2m_min'][i],
        ),
      );
    }

    print('Weather Status: ${weatherResponse.statusCode}');
    print('Weather Response: ${weatherResponse.body}');
    print('Forecast count: ${forecasts.length}');
    print('First forecast: ${forecasts.first.date}');

    final currentWeather = Weather(
      city: location['name'],
      temperature: current['temperature_2m'],
      condition: _getWeatherCondition(weatherCode),
      feelsLike: current['apparent_temperature'],
      humidity: current['relative_humidity_2m'],
      windSpeed: current['wind_speed_10m'],
      weatherCode: weatherCode,
    );

    return WeatherData(
      current: currentWeather,
      forecast: forecasts,
    );
  }
}