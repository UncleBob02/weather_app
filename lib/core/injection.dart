import '../data/datasources/weather_remote_data_source.dart';
import '../data/repositories/weather_repository_impl.dart';
import '../domain/repositories/weather_repository.dart';
import '../domain/usecases/get_weather.dart';

class Injection {
  static final WeatherRemoteDataSource remoteDataSource =
      WeatherRemoteDataSource();

  static final WeatherRepository weatherRepository =
      WeatherRepositoryImpl(
        remoteDataSource: remoteDataSource,
      );

  static final GetWeather getWeather =
      GetWeather(weatherRepository);
}