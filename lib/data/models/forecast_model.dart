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

  static List<ForecastModel> fromDailyJson(
    Map<String, dynamic> daily,
  ) {
    final forecasts = <ForecastModel>[];

    for (int i = 0; i < daily['time'].length; i++) {
      forecasts.add(
        ForecastModel.fromJson(
          date: daily['time'][i],
          weatherCode: daily['weather_code'][i],
          maxTemperature: daily['temperature_2m_max'][i],
          minTemperature: daily['temperature_2m_min'][i],
        ),
      );
    }

    return forecasts;
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