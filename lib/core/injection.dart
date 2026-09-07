import '../data/datasources/weather_remote_data_source.dart';
import '../data/repositories/weather_repository_impl.dart';
import '../domain/repositories/weather_repository.dart';
import '../domain/usecases/get_weather.dart';

final weatherRemoteDataSource = WeatherRemoteDataSource();

final WeatherRepository weatherRepository = WeatherRepositoryImpl(
  remoteDataSource: weatherRemoteDataSource,
);

final getWeather = GetWeather(weatherRepository);