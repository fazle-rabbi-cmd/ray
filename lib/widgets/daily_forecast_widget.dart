import 'package:flutter/material.dart';

class DailyForecastWidget extends StatelessWidget {
  final List<dynamic> dailyForecast;

  DailyForecastWidget({required this.dailyForecast});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daily Forecast',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: dailyForecast.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ListTile(
                    title: Text(
                      '${dailyForecast[index]['Date']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Temperature: ${dailyForecast[index]['Temperature']['Minimum']['Value']}-${dailyForecast[index]['Temperature']['Maximum']['Value']}°${dailyForecast[index]['Temperature']['Minimum']['Unit']}-${dailyForecast[index]['Temperature']['Maximum']['Unit']}',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
