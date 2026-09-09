import 'package:flutter/material.dart';
import 'package:weather_app/core/error/failures.dart';
import '../../widgets/forecast_list.dart';
import '../../widgets/weather_card.dart';
import '../../state/weather_state.dart';
import '../../../domain/entities/weather.dart';
import '../../../core/injection.dart';
import '../../state/weather_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _cityController = TextEditingController();
  
  late final WeatherController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WeatherController(
      getWeather: Injection.getWeather,
      onStateChanged: () {
        if (!mounted) {
          return;
        }

        setState(() {});
      },
    );

    _loadWeather('Midrand');
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  Future<void> _loadWeather(String city) async {
    await _controller.loadWeather(city);

    if (mounted) {
      _cityController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = _controller.state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh weather',
            onPressed: state.status == WeatherStatus.loading
              ? null
              : () {
                _controller.refreshWeather();
              },
          ),
        ],
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
                      onSubmitted: (value) {
                        final city = value.trim();

                        if (city.isEmpty || state.status == WeatherStatus.loading) {
                          return;
                        }

                        _loadWeather(city);
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter a city...',
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
                            alpha: 0.5,
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: state.status == WeatherStatus.loading
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

                    if (state.status == WeatherStatus.loading) ...[
                      const SizedBox(height: 24),
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ] else if (state.status == WeatherStatus.failure) ...[
                      const SizedBox(height: 16),
                      
                      Text(
                        state.errorMessage!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),

                      const SizedBox(height: 12),

                    ] else if ((state.status == WeatherStatus.success ||
                                state.status == WeatherStatus.refreshing) &&
                        state.weather != null) ...[
                          if (state.status == WeatherStatus.refreshing)
                          const Padding(
                            padding: EdgeInsets.only(bottom: 12),
                            child: LinearProgressIndicator(),
                          ),
                          
                          WeatherCard(
                            weather: state.weather!,
                          ),

                          const SizedBox(height: 40),
                          
                          ForecastList(
                            forecasts: state.forecast,
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