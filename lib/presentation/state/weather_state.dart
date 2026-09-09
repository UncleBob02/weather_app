import '../../domain/entities/weather.dart';
import '../../domain/entities/forecast.dart';
import '../../core/error/failures.dart';

enum WeatherStatus {
  initial,
  loading,
  refreshing,
  success,
  failure,
}

class WeatherState {
  final Weather? weather;
  final List<Forecast> forecast;
  final WeatherStatus status;
  final String? errorMessage;
  final Failure? failure;

  const WeatherState({
    required this.weather,
    required this.forecast,
    required this.status,
    this.errorMessage,
    this.failure,
  });

  factory WeatherState.initial() {
    return const WeatherState(
      weather: null,
      forecast: [],
      status: WeatherStatus.initial,
      errorMessage: null,
      failure: null,
    );
  }

  WeatherState copyWith({
    Weather? weather,
    List<Forecast>? forecast,
    WeatherStatus? status,
    Object? errorMessage = _unset,
    Object? failure = _unset
  }) {
    return WeatherState(
      weather: weather ?? this.weather,
      forecast: forecast ?? this.forecast,
      status: status ?? this.status,
      errorMessage: identical(errorMessage, _unset)
        ? this.errorMessage
        : errorMessage as String?,
      failure: identical(failure, _unset)
        ? this.failure
        : failure as Failure?,
    );
  }

  static const _unset = Object();
}