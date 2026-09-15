import '../entities/weather_data.dart';

abstract class WeatherRepository {
  Future<WeatherData> getWeather(String city);

  Future<WeatherData> getWeatherByCoordinates(
    double latitude,
    double longitude,
    String city, 
  );
}