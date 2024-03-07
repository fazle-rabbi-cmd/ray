import 'package:flutter/material.dart';

class CurrentConditionsWidget extends StatelessWidget {
  final Map<String, dynamic> currentConditions;

  CurrentConditionsWidget({required this.currentConditions});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Conditions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              currentConditions.isNotEmpty
                  ? currentConditions['WeatherText']
                  : 'Loading...',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
