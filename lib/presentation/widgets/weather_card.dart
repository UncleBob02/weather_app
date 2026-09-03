import 'package:flutter/material.dart';

import '../../domain/entities/weather.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;

  const WeatherCard({
    super.key,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          const SizedBox(height: 8),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                _getWeatherIcon(weather.weatherCode),
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),

              const SizedBox(width: 24),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    weather.city,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    weather.condition,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 32),

          Center(
            child: Text(
              '${weather.temperature.round()}°C',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),

          const SizedBox(height: 8),

          Center(
            child: Text(
              'Feels like ${weather.feelsLike.round()}°C',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),

          const SizedBox(height: 32),

          Row(
            children: [
              Expanded(
                child: _WeatherDetails(
                  label: 'Humidity',
                  value: '${weather.humidity}%',
                ),
              ),

              Expanded(
                child: _WeatherDetails(
                  label: 'Wind',
                  value: '${weather.windSpeed} km/h',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

IconData _getWeatherIcon(int code) {
  if (code == 0) {
    return Icons.wb_sunny; // Clear sky
  }

  if (code == 1) {
    return Icons.wb_cloudy_outlined; // Mostly clear
  }

  if (code == 2 || code == 3) {
    return Icons.cloud; // Cloudy
  }

  if (code >= 45 && code <= 48) {
    return Icons.foggy; // Foggy
  }

  if (code >= 51 && code <= 57) {
    return Icons.grain; // Drizzle
  }

  if (code >= 61 && code <= 67) {
    return Icons.cloudy_snowing; // Rainy
  }

  if (code >= 71 && code <= 77) {
    return Icons.ac_unit; // Snowy
  }

  if (code >= 80 && code <= 82) {
    return Icons.cloudy_snowing; // Rain showers
  }

  if (code >= 95 && code <= 99) {
    return Icons.thunderstorm;  // Thunderstorm
  }

  return Icons.cloud;
}

class _WeatherDetails extends StatelessWidget {
  final String label;
  final String value;

  const _WeatherDetails({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),

        const SizedBox(height: 4),

        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}