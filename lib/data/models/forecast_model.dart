import '../../domain/entities/forecast.dart';

class ForecastModel {
  final DateTime date;
  final double maxTemperature;
  final double minTemperature;
  final int weatherCode;

  const ForecastModel({
    required this.date,
    required this.maxTemperature,
    required this.minTemperature,
    required this.weatherCode,
  });

  factory ForecastModel.fromJson({
    required String date,
    required num maxTemperature,
    required num minTemperature,
    required num weatherCode,
  }) {
    return ForecastModel(
      date: DateTime.parse(date),
      maxTemperature: maxTemperature.toDouble(),
      minTemperature: minTemperature.toDouble(),
      weatherCode: weatherCode.toInt(),
    );
  }

  Forecast toEntity() {
    return Forecast(
      date: date,
      maxTemperature: maxTemperature,
      minTemperature: minTemperature,
      weatherCode: weatherCode,
    );
  }
}