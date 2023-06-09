import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'location_helper.dart';

class WeatherData with ChangeNotifier {
  String location = '';
  double temperature = 0;
  double feelslike = 0;
  String weatherDescription = '';
  double latitude = 0;
  double longitude = 0;
  int humidity = 0;
  double windSpeed = 0;
  double rainAmount = 0;

  Future<void> getWeatherData(double latitude, double longitude) async {
    String apiKey = '00893a59672eedb536717886048143c1';
    String apiUrl =
        'http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      Map<String, dynamic> weatherData = jsonDecode(response.body);
      location = weatherData['name'];
      temperature = weatherData['main']['temp'];
      feelslike = weatherData['main']['feels_like'];
      weatherDescription = capitalize(weatherData['weather'][0]['description']);
      humidity = weatherData['main']['humidity'];
      windSpeed = weatherData['wind']['speed'];
      rainAmount = weatherData['rain'] != null ? weatherData['rain']['1h'] : 0;
    } else {
      location = 'Weather not available.';
      temperature = 0;
      feelslike = 0;
      weatherDescription = '';
      humidity = 0;
      windSpeed = 0;
      rainAmount = 0;
    }
    notifyListeners();
  }

  Future<void> getCurrentLocation() async {
    LocationHelper locationHelper = LocationHelper();
    await locationHelper.getCurrentLocation();
    latitude = locationHelper.latitude;
    longitude = locationHelper.longitude;
    location = 'Getting location...';
    notifyListeners();
  }

  void convertToInteger() {
    temperature = temperature.toInt() as double;
    feelslike = feelslike.toInt() as double;
    windSpeed = windSpeed.toInt() as double;
    rainAmount = rainAmount.toInt() as double;
    notifyListeners();
  }

  String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  String getWeatherImage(String weatherDescription) {
    if (weatherDescription.toLowerCase().contains('rain')) {
      return 'assets/images/rainy.png';
    } else if (weatherDescription.toLowerCase().contains('sun')) {
      return 'assets/images/sunny.png';
    } else if (weatherDescription.toLowerCase().contains('cloud')) {
      return 'assets/images/cloudy.png';
    } else if (weatherDescription.toLowerCase().contains('storm')) {
      return 'assets/images/thunderstorm.png';
    } else if (weatherDescription.toLowerCase().contains('wind')) {
      return 'assets/images/windy.png';
    } else {
      return 'assets/images/default_weather.png';
    }
  }
}
