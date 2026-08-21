import 'package:flutter/material.dart';
import '../models/models.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _cityController = TextEditingController();
  
  String _city = 'Johannesburg';

  Weather _weather = const Weather(
    city: 'Johannesburg',
    temperature: 22,
    condition: 'Partly cloudy',
    feelsLike: 21,
    humidity: 58,
    windSpeed: 14,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                hintText: 'Enter a city',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _city = _cityController.text;
                    });
                  },
                ),
                border: const OutlineInputBorder(),
              ),
            ),

            Text(
              _city,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              _weather.condition,
              style: TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 32),

            Center(
              child: Text(
                '${_weather.temperature}°C',
                style: TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 8),

            Center(
              child: Text(
                'Feels like ${_weather.feelsLike}°C',
                style: TextStyle(
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
                  value: '${_weather.humidity}%',
                ),
                _WeatherDetails(
                  label: 'Wind',
                  value: '${_weather.windSpeed} km/h',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
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
            fontSize: 14
          )
        ),

        const SizedBox(height: 4),

        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          )
        ),
      ],
    );
  }
}