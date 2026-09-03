import 'forecast.dart';
import 'weather.dart';

class WeatherData {
  final Weather current;
  final List<Forecast> forecast;

  const WeatherData({
    required this.current,
    required this.forecast,
  });
}