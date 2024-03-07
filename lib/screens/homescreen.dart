// homescreen.dart
import 'package:flutter/material.dart';
import 'package:ray/services/weather_service.dart';
import 'package:ray/widgets/current_conditions_widget.dart';
import 'package:ray/widgets/daily_forecast_widget.dart';
import 'package:ray/widgets/hourly_forecast_widget.dart';
import 'package:ray/services/location_service.dart';
import 'package:ray/widgets/search_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late WeatherService weatherService;
  late LocationService locationService;
  final TextEditingController _searchController = TextEditingController();
  final String apiKey =
      'dX0qiOJQv9lgaba1QGpfb02EvI91haAm'; // Replace with your AccuWeather API key

  @override
  void initState() {
    super.initState();
    weatherService = WeatherService(apiKey: apiKey);
    locationService = LocationService();
    fetchWeatherData();
  }

  Map<String, dynamic> currentConditions = {};
  List<dynamic> hourlyForecast = [];
  List<dynamic> dailyForecast = [];

  Future<void> fetchWeatherData() async {
    try {
      final position = await locationService.getCurrentLocation();
      final locationKey = await weatherService.getLocationKey(
          position.latitude, position.longitude);
      final currentConditionsData =
          await weatherService.getCurrentConditions(locationKey);
      final hourlyForecastData =
          await weatherService.getHourlyForecast(locationKey);
      final dailyForecastData =
          await weatherService.getDailyForecast(locationKey);

      setState(() {
        currentConditions = currentConditionsData;
        hourlyForecast = hourlyForecastData;
        dailyForecast = dailyForecastData;
      });
    } catch (e) {
      print('Error fetching weather data: $e');
      // Handle error
    }
  }

  Future<void> searchLocation(String locationQuery) async {
    try {
      final locationKey =
          await weatherService.getLocationKeyByQuery(locationQuery);
      final currentConditionsData =
          await weatherService.getCurrentConditions(locationKey);
      final hourlyForecastData =
          await weatherService.getHourlyForecast(locationKey);
      final dailyForecastData =
          await weatherService.getDailyForecast(locationKey);

      setState(() {
        currentConditions = currentConditionsData;
        hourlyForecast = hourlyForecastData;
        dailyForecast = dailyForecastData;
      });
    } catch (e) {
      print('Error fetching weather data: $e');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SearchWidget(
                controller: _searchController,
                onSearch: searchLocation,
              ),
              SizedBox(height: 16),
              CurrentConditionsWidget(currentConditions: currentConditions),
              SizedBox(height: 16),
              HourlyForecastWidget(hourlyForecast: hourlyForecast),
              SizedBox(height: 16),
              DailyForecastWidget(dailyForecast: dailyForecast),
            ],
          ),
        ),
      ),
    );
  }
}
