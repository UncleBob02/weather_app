import 'package:flutter/material.dart';
import '../models/models.dart';
import '../widgets/weather_card.dart';
import '../services/weather_service.dart';
import '../widgets/forecast_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _cityController = TextEditingController();
  
  final WeatherService _weatherService = WeatherService();

  Weather _weather = const Weather(
    city: 'Midrand',
    temperature: 22,
    condition: 'Partly cloudy',
    feelsLike: 21,
    humidity: 58,
    windSpeed: 14,
    weatherCode: 2,
  );

  List<Forecast> _forecast = [];

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();

    _loadWeather('Midrand');
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  Future<void> _loadWeather(String city) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final weatherData = await _weatherService.getWeather(city);

      setState(() {
        _weather = weatherData.current;
        _forecast = weatherData.forecast;
        _isLoading = false;
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Could not find the weather for "$city".';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          
          final horizontalPadding = constraints.maxWidth < 600 ? 16.0 : 32.0;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 24,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 700,
                ),
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
                            ? null : () {
                              final city = _cityController.text.trim();

                              if (city.isEmpty) {
                                return;
                              }

                              _loadWeather(city);
                            }                          
                        ),
                        border: const OutlineInputBorder(),
                      ),
                    
                    
                    ),

                    const SizedBox(height: 24),

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

                      const SizedBox(height: 40),
                      
                      ForecastList(
                        forecasts: _forecast,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}