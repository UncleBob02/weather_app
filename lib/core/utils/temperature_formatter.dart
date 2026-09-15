String formatTemperature(double temperature, bool isCelsius) {
  if (isCelsius) {
    return '${temperature.round()}°C';
  }

  final fahrenheit = (temperature * 9 / 5) + 32;
  return '${fahrenheit.round()}°F';
}