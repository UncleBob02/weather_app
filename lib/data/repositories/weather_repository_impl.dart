import '../../domain/entities/weather_data.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_remote_data_source.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  const WeatherRepositoryImpl({
    required this.remoteDataSource
  });

  @override
  Future<WeatherData> getWeather(String city) async {
    final location = await remoteDataSource.getLocation(city);

    final weatherData = await remoteDataSource.getWeather(
      location.latitude, 
      location.longitude,
      location.name,
    );

    return weatherData.toEntity();
  }

  @override
  Future<WeatherData> getWeatherByCoordinates(
    double latitude,
    double longitude,
    String city,
  ) async {
    final weatherData = await remoteDataSource.getWeather(
      latitude, 
      longitude, 
      city,
    );

    return weatherData.toEntity();
  }
}