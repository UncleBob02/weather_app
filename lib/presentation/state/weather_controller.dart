import 'package:flutter/animation.dart';
import 'package:geolocator/geolocator.dart';
import '../../domain/usecases/get_current_location.dart';
import '../../domain/usecases/get_weather.dart';
import '../../core/error/failures.dart';
import 'weather_state.dart';

class WeatherController {
  final GetWeather getWeather;
  final GetCurrentLocation getCurrentLocation;
  final void Function() onStateChanged;

  String? _currentCity;

  String? get currentCity => _currentCity; 

  WeatherState _state;

  WeatherState get state => _state;

  WeatherController({
    required this.getWeather,
    required this.getCurrentLocation,
    required this.onStateChanged,
  }) : _state = WeatherState.initial();

  Future<void> loadWeather(
    String city, {
    bool isRefreshing = false,
    }) async {
    _currentCity = city;

    _state = _state.copyWith(
      status: isRefreshing
        ? WeatherStatus.refreshing
        : WeatherStatus.loading,
      errorMessage: null,
      failure: null,
    );

    onStateChanged();

    try {
      final weatherData = await getWeather(city);

      _state = _state.copyWith(
        weather: weatherData.current,
        forecast: weatherData.forecast,
        status: WeatherStatus.success,
        errorMessage: null,
        failure: null,
      );

      onStateChanged();
    } catch (e) {
      print('Weather Error: $e');

      String message;

      if (e is LocationFailure) {
        message = 'Location not found.';
      } else if (e is ServerFailure) {
        message = 'Could not connect to the weather service.';
      } else if(e is NetworkFailure) {
        message = 'Network error occurred.';
      } else if(e is UnexpectedFailure) {
        message = 'An unexpected error occurred.';
      } else {
        message = 'Something went wrong.';
      }

      _state = _state.copyWith(
        status: WeatherStatus.failure,
        errorMessage: message,
        failure: e is Failure ? e : null,
      );
      
      onStateChanged();
    }
  }

  Future<void> loadWeatherByCurrentLocation() async {
    _state = _state.copyWith(
      status: WeatherStatus.loading,
      errorMessage: null,
      failure: null,
    );

    onStateChanged();

    try {
      final position = await getCurrentLocation();
    } catch (e) {
      _state = _state.copyWith(
        status: WeatherStatus.failure,
        errorMessage: 'Could not get your location',
        failure: e is Failure ? e : null,
      );

      onStateChanged();
    }
  }

  Future<void> refreshWeather() async {
    final city =  _currentCity;

    if(city == null || 
      city.isEmpty || 
      _state.status == WeatherStatus.loading ||
      _state.status == WeatherStatus.refreshing) {
      return;
    }
    
    await loadWeather(
      city, 
      isRefreshing: true,
    );
  }
}