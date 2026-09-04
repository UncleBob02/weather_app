import '../../domain/entities/weather.dart';
import '../../domain/entities/forecast.dart';

class WeatherState {
  final Weather weather;
  final List<Forecast> forecast;
  final bool isLoading;
  final String? errorMessage;

  const WeatherState({
    required this.weather,
    required this.forecast,
    required this.isLoading,
    this.errorMessage,
  });

  WeatherState copyWith({
    Weather? weather,
    List<Forecast>? forecast,
    bool? isLoading,
    Object? errorMessage = _unset,
  }) {
    return WeatherState(
      weather: weather ?? this.weather,
      forecast: forecast ?? this.forecast,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: identical(errorMessage, _unset)
        ? this.errorMessage
        : errorMessage as String?,
    );
  }

  static const _unset = Object();
}