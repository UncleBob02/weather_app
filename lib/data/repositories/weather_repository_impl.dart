import '../../domain/entities/weather_data.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_remote_data_source.dart';
import '../models/weather_model.dart';
import '../models/forecast_model.dart';
import '../models/weather_data_model.dart';
import '../../core/utils/weather_condition.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  const WeatherRepositoryImpl({
    required this.remoteDataSource
  });

  @override
  Future<WeatherData> getWeather(String city) async {
    final location = await remoteDataSource.getLocation(city);

    final latitude = (location['latitude'] as num).toDouble();
    final longitude = (location['longitude'] as num).toDouble();

    final weatherData = await remoteDataSource.getWeather(latitude, longitude);

    final current = weatherData['current'];
    final daily = weatherData['daily'];

    final weatherCode = current['weather_code'] as int;

    final currentWeather = WeatherModel.fromJson(
      current,
      city: location['name'],
      condition: getWeatherCondition(weatherCode),
    );

    final forecasts = <ForecastModel>[];

    for(int i = 0; i < daily['time'].length; i++) {
      forecasts.add(
        ForecastModel.fromJson(
          date: daily['time'][i],
          weatherCode: daily['weather_code'][i],
          maxTemperature: daily['temperature_2m_max'][i],
          minTemperature: daily['temperature_2m_min'][i],
        ),
      );
    }

    return WeatherDataModel(
      current: currentWeather,
      forecast: forecasts,
    ).toEntity();
  }
}