import '../../domain/entities/weather_data.dart';
import '../../domain/entities/weather.dart';
import '../../domain/entities/forecast.dart';
import 'weather_model.dart';
import 'forecast_model.dart';

class WeatherDataModel {
  final WeatherModel current;
  final List<ForecastModel> forecast;

  const WeatherDataModel({
    required this.current,
    required this.forecast,
  });

  WeatherData toEntity() {
    return WeatherData(
      current: current.toEntity(),
      forecast: forecast
          .map((forecast) => forecast.toEntity())
          .toList(),
    );
  }
}