import 'package:flutter/material.dart';

import '../../domain/entities/forecast.dart';
import '../../core/utils/weather_icon.dart';
import '../../core/utils/date_formatter.dart';
import '../../core/utils/weather_condition.dart';
import '../../core/utils/temperature_formatter.dart';

class ForecastList extends StatelessWidget {
  final List<Forecast> forecasts;
  final bool isCelsius;

  const ForecastList({
    super.key,
    required this.forecasts,
    required this.isCelsius,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '7-Day Forecast',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 16),

        ...forecasts.map(
          (forecast) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _ForecastRow(
              forecast: forecast,
              isCelsius: isCelsius,
            )          
          ),
        ),
      ],
    );
  }
}

class _ForecastRow extends StatelessWidget {
  final Forecast forecast;
  final bool isCelsius;

  const _ForecastRow({
    required this.forecast,
    required this.isCelsius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
              formatForecastDate(forecast.date),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            )
          ),

          Expanded(
            child: Icon(
              getWeatherIcon(forecast.weatherCode),
              size: 26,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),

          Expanded(
            child: Text(
              getWeatherCondition(
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
              '${formatTemperature(forecast.maxTemperature, isCelsius)} / '
              '${formatTemperature(forecast.minTemperature, isCelsius)}',
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