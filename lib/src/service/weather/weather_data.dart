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

  Future<void> getCurrentLocation() async {
    LocationHelper locationHelper = LocationHelper();
    await locationHelper.getCurrentLocation();
    latitude = locationHelper.latitude;
    longitude = locationHelper.longitude;
    location = 'Konum alınıyor...';
    notifyListeners();
  }

  Future<void> getWeatherData(double latitude, double longitude) async {
    String apiKey = '00893a59672eedb536717886048143c1';
    String apiUrl =
        'http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      Map<String, dynamic> weatherData = jsonDecode(response.body);
      location = weatherData['name'];
      temperature = weatherData['main']['temp'];
      feelslike = double.parse(weatherData['main']['feels_like'].toString());
      weatherDescription = weatherData['weather'][0]['description'];
    } else {
      location = 'Hava durumu alınamadı.';
      temperature = 0;
      feelslike = 0;
      weatherDescription = '';
    }
    notifyListeners();
  }
}
