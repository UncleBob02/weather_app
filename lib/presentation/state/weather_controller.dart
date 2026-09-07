import '../../domain/usecases/get_weather.dart';
import '../../core/error/failures.dart';
import 'weather_state.dart';

class WeatherController {
  final GetWeather getWeather;
  final void Function(WeatherState state) onStateChanged;

  WeatherState state;

  WeatherController({
    required this.getWeather,
    required this.onStateChanged,
  }) : state = WeatherState.initial();

  Future<void> loadWeather(String city) async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
    );
    onStateChanged(state);

    try {
      final weatherData = await getWeather(city);

      state = state.copyWith(
        weather: weatherData.current,
        forecast: weatherData.forecast,
        isLoading: false,
        errorMessage: null,
      );
      onStateChanged(state);
    } catch (e) {
      print('Weather Error: $e');

      String message;

      if (e is LocationFailure) {
        message = 'Location not found.';
      } else if (e is ServerFailure) {
        message = 'Could not connect to the weather service.';
      } else if(e is NetworkFailure) {
        message = 'Network error occurred.';
      } else {
        message = 'Something went wrong.';
      }

      state = state.copyWith(
        isLoading: false,
        errorMessage: message,
      );
      
      onStateChanged(state);
    }
  }
}