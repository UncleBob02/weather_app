import 'package:flutter/material.dart';

import '../models/models.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;

  const WeatherCard({
    super.key,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          weather.city,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        Icon(
          _getWeatherIcon(weather.weatherCode),
          size: 80,
        ),

        Text(
          weather.condition,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),

        const SizedBox(height: 32),

        Center(
          child: Text(
            '${weather.temperature}°C',
            style: const TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 8),

        Center(
          child: Text(
            'Feels like ${weather.feelsLike}°C',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 40),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _WeatherDetails(
              label: 'Humidity',
              value: '${weather.humidity}%',
            ),
            _WeatherDetails(
              label: 'Wind',
              value: '${weather.windSpeed} km/h',
            ),
          ],
        ),
      ],
    );
  }
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

  if (code >= 51 && code <= 67) {
    return Icons.water_drop;
  }

  if (code >= 71 && code <= 77) {
    return Icons.ac_unit;
  }

  if (code >= 80 && code <= 82) {
    return Icons.grain;
  }

  if (code >= 95 && code <= 99) {
    return Icons.thunderstorm;
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
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}