// settings_screen.dart
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkModeEnabled = false; // Example setting for dark mode
  bool _useCelsius = true; // Example setting for temperature unit

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Dark Mode'),
            value: _darkModeEnabled,
            onChanged: (value) {
              setState(() {
                _darkModeEnabled = value;
                // Implement logic to update theme
              });
            },
          ),
          SwitchListTile(
            title: Text('Use Celsius'),
            value: _useCelsius,
            onChanged: (value) {
              setState(() {
                _useCelsius = value;
                // Implement logic to update temperature unit
              });
            },
          ),
          // Add more settings as needed
        ],
      ),
    );
  }
}
