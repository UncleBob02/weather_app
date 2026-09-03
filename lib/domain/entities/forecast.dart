class Forecast {
  final DateTime date;
  final double maxTemperature;
  final double minTemperature;
  final int weatherCode;

  const Forecast({
    required this.date,
    required this.maxTemperature,
    required this.minTemperature,
    required this.weatherCode,
  });
}