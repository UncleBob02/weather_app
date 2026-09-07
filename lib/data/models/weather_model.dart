import '../../domain/entities/weather.dart';
import '../../core/utils/weather_condition.dart';

class WeatherModel {
  final String city;
  final double temperature;
  final String condition;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final int weatherCode;

  const WeatherModel({
    required this.city,
    required this.temperature,
    required this.condition,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.weatherCode,
  });

  factory WeatherModel.fromJson(
    Map<String, dynamic> json, {
    required String city,
  }) {
    final weatherCode = (json['weather_code'] as num).toInt();

    return WeatherModel(
      city: city,
      temperature: (json['temperature_2m'] as num).toDouble(),
      condition: getWeatherCondition(weatherCode),
      feelsLike: (json['apparent_temperature'] as num).toDouble(),
      humidity: (json['relative_humidity_2m'] as num).toInt(),
      windSpeed: (json['wind_speed_10m'] as num).toDouble(),
      weatherCode: weatherCode,
    );
  }

  Weather toEntity() {
    return Weather(
      city: city,
      temperature: temperature,
      condition: condition,
      feelsLike: feelsLike,
      humidity: humidity,
      windSpeed: windSpeed,
      weatherCode: weatherCode,
    );
  }
}