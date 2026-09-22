import '../data/datasources/weather_remote_data_source.dart';
import '../data/repositories/weather_repository_impl.dart';
import '../data/datasources/location_data_source.dart';
import '../data/repositories/location_repository_impl.dart';
import '../domain/repositories/weather_repository.dart';
import '../domain/usecases/get_weather.dart';
import '../domain/usecases/get_current_location.dart';
import '../domain/usecases/get_weather_by_coordinates.dart';
import '../domain/repositories/location_repository.dart';

class Injection {
  static final WeatherRemoteDataSource remoteDataSource =
      WeatherRemoteDataSourceImpl();

  static final WeatherRepository weatherRepository =
      WeatherRepositoryImpl(
        remoteDataSource: remoteDataSource,
      );

  static final GetWeather getWeather =
      GetWeather(weatherRepository);

  static final GetWeatherByCoordinates getWeatherByCoordinates = 
    GetWeatherByCoordinates(weatherRepository);

  static final LocationDataSource locationDataSource =
    LocationDataSourceImpl();

  static final LocationRepository locationRepository =
      LocationRepositoryImpl(
        dataSource: locationDataSource,
      );

  static final GetCurrentLocation getCurrentLocation =
      GetCurrentLocation(locationRepository);
}