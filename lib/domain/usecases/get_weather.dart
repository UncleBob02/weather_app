import '../entities/weather_data.dart';
import '../repositories/weather_repository.dart';

class GetWeather {
  final WeatherRepository repository;

  const GetWeather(this.repository);

  Future<WeatherData> call(String city) {
    return repository.getWeather(city);
  }
}