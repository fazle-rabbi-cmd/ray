// weather_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey;
  final String baseUrl = 'http://dataservice.accuweather.com/';
  final String locationUrl = 'locations/v1/cities/search';
  final String currentConditionsUrl = 'currentconditions/v1/';
  final String hourlyForecastUrl = 'forecasts/v1/hourly/12hour/';
  final String dailyForecastUrl = 'forecasts/v1/daily/5day/';

  WeatherService({required this.apiKey});

  Future<String> getLocationKeyByQuery(String locationQuery) async {
    final Uri locationUri =
        Uri.parse('$baseUrl$locationUrl?q=$locationQuery&apikey=$apiKey');
    final response = await http.get(locationUri);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data[0]['Key'];
    } else {
      throw Exception('Failed to fetch location key');
    }
  }

  Future<String> getLocationKey(double latitude, double longitude) async {
    final Uri locationUri =
        Uri.parse('$baseUrl$locationUrl?q=$latitude,$longitude&apikey=$apiKey');
    final response = await http.get(locationUri);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data[0]['Key'];
    } else {
      throw Exception('Failed to fetch location key');
    }
  }

  Future<Map<String, dynamic>> getCurrentConditions(String locationKey) async {
    final Uri currentConditionsUri =
        Uri.parse('$baseUrl$currentConditionsUrl$locationKey?apikey=$apiKey');
    final response = await http.get(currentConditionsUri);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data[0];
    } else {
      throw Exception('Failed to load current conditions');
    }
  }

  Future<List<dynamic>> getHourlyForecast(String locationKey) async {
    final Uri hourlyForecastUri =
        Uri.parse('$baseUrl$hourlyForecastUrl$locationKey?apikey=$apiKey');
    final response = await http.get(hourlyForecastUri);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load hourly forecast');
    }
  }

  Future<List<dynamic>> getDailyForecast(String locationKey) async {
    final Uri dailyForecastUri =
        Uri.parse('$baseUrl$dailyForecastUrl$locationKey?apikey=$apiKey');
    final response = await http.get(dailyForecastUri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['DailyForecasts'];
    } else {
      throw Exception('Failed to load daily forecast');
    }
  }
}
