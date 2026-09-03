import 'package:flutter/material.dart';
import '../../domain/entities/forecast.dart';

class ForecastList extends StatelessWidget {
  final List<Forecast> forecasts;

  const ForecastList({
    super.key,
    required this.forecasts,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '7-Day Forecast',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 16),

        ...forecasts.map(
          (forecast) => _ForecastRow(
            forecast: forecast,
          ),
        ),
      ],
    );
  }
}

class _ForecastRow extends StatelessWidget {
  final Forecast forecast;

  const _ForecastRow({
    required this.forecast,
  });

  String _getDayLabel(DateTime date) {
    final today = DateTime.now();

    final forecastDate = DateTime(
      date.year,
      date.month,
      date.day,
    );

    final todayDate = DateTime(
      today.year,
      today.month,
      today.day,
    );

    if (forecastDate == todayDate) {
      return 'Today';
    }

    const days = [
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun',
    ];

    return days[date.weekday - 1];
  }

  IconData _getWeatherIcon(int code) {
    if (code == 0) {
      return Icons.wb_sunny;
    }

    if (code == 1 || code == 2 || code == 3) {
      return Icons.cloud;
    }

    if (code >= 45 && code <= 48) {
      return Icons.foggy;
    }

    if (code >= 51 && code <= 57) {
      return Icons.grain;
    }

    if (code >= 61 && code <= 67) {
      return Icons.water_drop;
    }

    if (code >= 71 && code <= 77) {
      return Icons.ac_unit;
    }

    if (code >= 80 && code <= 82) {
      return Icons.cloudy_snowing;
    }

    if (code >= 95 && code <= 99) {
      return Icons.thunderstorm;
    }

    return Icons.cloud;
  }

  String _getWeatherCondition(int code) {
    if (code == 0) {
      return 'Clear sky';
    }

    if (code == 1) {
      return 'Mainly clear';
    }

    if (code == 2) {
      return 'Partly cloudy';
    }

    if (code == 3) {
      return 'Overcast';
    }

    if (code >= 45 && code <= 48) {
      return 'Fog';
    }

    if (code >= 51 && code <= 57) {
      return 'Drizzle';
    }

    if (code >= 61 && code <= 67) {
      return 'Rain';
    }

    if (code >= 71 && code <= 77) {
      return 'Snow';
    }

    if (code >= 80 && code <= 82) {
      return 'Rain showers';
    }

    if (code >= 95 && code <= 99) {
      return 'Thunderstorm';
    }

    return 'Unknown';
  } 

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color:Theme.of(context).colorScheme.surfaceContainerLow,
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              _getDayLabel(forecast.date),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            )
          ),

          Expanded(
            child: Icon(
              _getWeatherIcon(forecast.weatherCode),
              size: 26,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),

          Expanded(
            child: Text(
              _getWeatherCondition(
                forecast.weatherCode
              ), 
              maxLines: 1, 
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                ), 
              textAlign: TextAlign.center,
            ),
          ),

          Expanded(
            child: Text(
              '${forecast.maxTemperature.round()}° /  ${forecast.minTemperature.round()}°',
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}