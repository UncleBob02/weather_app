import 'package:flutter/material.dart';
import '../models/models.dart';
import '../widgets/weather_card.dart';
import '../services/weather_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _cityController = TextEditingController();
  
  final WeatherService _weatherService = WeatherService();

  String _city = 'Johannesburg';

  Weather _weather = const Weather(
    city: 'Johannesburg',
    temperature: 22,
    condition: 'Partly cloudy',
    feelsLike: 21,
    humidity: 58,
    windSpeed: 14,
    weatherCode: 2,
  );

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

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
                  onPressed: _isLoading 
                    ? null : () 
                    async {
                      final city = _cityController.text.trim();

                      if (city.isEmpty) {
                        return;
                      }

                      setState(() {
                        _isLoading = true;
                        _errorMessage = null;
                      });

                      try {
                        final weather = await _weatherService.getWeather(city);

                        setState(() {
                          _city = city;
                          _weather = weather;
                          _isLoading = false;
                        });
                      } catch (e) {
                        setState(() {
                          _isLoading = false;
                          _errorMessage = 'Could not find the weather for "$city".';
                        });
                      }
                    },
                ),
                border: const OutlineInputBorder(),
              ),
            
            
            ),

            if (_isLoading) ...[
              const SizedBox(height: 24),
              const Center(
                child: CircularProgressIndicator(),
              ),
            ],

            if (_errorMessage != null) ...[
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
            ],

            if (!_isLoading && _errorMessage == null) ...[

              WeatherCard(
                weather: _weather,
              ),
            ],
          ],
        ),
      ),
    );
  }
}