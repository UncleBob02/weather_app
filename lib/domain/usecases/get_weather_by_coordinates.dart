import 'package:weather_app/domain/entities/weather_data.dart';

import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

class GetWeatherByCoordinates {
  final WeatherRepository repository;

  const GetWeatherByCoordinates(this.repository);

  Future<WeatherData> call(
    double latitude,
    double longitude,
    String city,
  ) {
    return repository.getWeatherByCoordinates(
      latitude,
      longitude,
      city,
    );
  }
}