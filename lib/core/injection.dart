import '../data/datasources/weather_remote_data_source.dart';
import '../data/repositories/weather_repository_impl.dart';
import '../domain/usecases/get_weather.dart';

final getWeather = GetWeather(
  WeatherRepositoryImpl(
    remoteDataSource: WeatherRemoteDataSource(),
  ),
);