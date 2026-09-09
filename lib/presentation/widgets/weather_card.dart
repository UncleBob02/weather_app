import 'package:flutter/material.dart';

import '../../domain/entities/weather.dart';
import '../../core/utils/weather_icon.dart';

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
                getWeatherIcon(weather.weatherCode),
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
                  icon: Icons.water_drop_outlined,
                  label: 'Humidity',
                  value: '${weather.humidity}%',
                ),
              ),

              Expanded(
                child: _WeatherDetails(
                  icon: Icons.air,
                  label: 'Wind',
                  value: '${weather.windSpeed.round()} km/h',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WeatherDetails extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _WeatherDetails({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),

        const SizedBox(height: 8),

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