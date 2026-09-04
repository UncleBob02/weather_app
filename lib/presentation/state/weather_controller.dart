import '../../domain/entities/weather.dart';
import '../../domain/usecases/get_weather.dart';
import 'weather_state.dart';

class WeatherController {
  final GetWeather getWeather;
  final void Function(WeatherState state) onStateChanged;

  WeatherState state;

  WeatherController({
    required this.getWeather,
    required this.onStateChanged,
  }) : state = const WeatherState(
        weather: Weather(
          city: 'Midrand',
          temperature: 25,
          condition: 'Partly cloudy',
          feelsLike: 24,
          humidity: 58,
          windSpeed: 13,
          weatherCode: 2,
        ),
        forecast: const [],
        isLoading: false,
        errorMessage: null,
      );

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
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Could not find the weather for "$city".',
      );
      onStateChanged(state);
    }
  }
}