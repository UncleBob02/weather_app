import 'package:shared_preferences/shared_preferences.dart';

import '../data/datasources/weather_remote_data_source.dart';
import '../data/datasources/preferences_data_source.dart';
import '../data/repositories/preferences_repository_impl.dart';
import '../data/repositories/weather_repository_impl.dart';
import '../data/datasources/location_data_source.dart';
import '../data/repositories/location_repository_impl.dart';
import '../domain/repositories/preferences_repository.dart';

import '../domain/repositories/weather_repository.dart';
import '../domain/usecases/get_weather.dart';
import '../domain/usecases/get_city_name.dart';
import '../domain/usecases/get_last_city.dart';
import '../domain/usecases/save_last_city.dart';
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

  static final getCityName = GetCityName(
    locationRepository,
  );

  static late final SharedPreferences _preferences;

  static late final PreferencesDataSource _preferencesDataSource;

  static late final PreferencesRepository _preferencesRepository;

  static late final GetLastCity getLastCity;

  static late final SaveLastCity saveLastCity;

  static Future<void> initialize() async {
    _preferences = await SharedPreferences.getInstance();

    _preferencesDataSource = PreferencesDataSourceImpl(
      preferences: _preferences,
    );

    _preferencesRepository = PreferencesRepositoryImpl(
      dataSource: _preferencesDataSource,
    );

    getLastCity = GetLastCity(
      _preferencesRepository,
    );

    saveLastCity = SaveLastCity(
      _preferencesRepository,
    );
  }
}