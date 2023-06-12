import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import 'location_helper.dart';
import 'weather_forecast.dart';

class WeatherData with ChangeNotifier {
  List<WeatherForecast> forecasts = []; // 5 günlük hava durumu
  String city = '';
  DateTime dt = DateTime(2023);
  double temperature = 0;
  double feelslike = 0;
  String location = '';
  String weatherDescriptionToday = '';
  String weatherDescription1 = '';
  String weatherDescription2 = '';
  String weatherDescription3 = '';
  String weatherDescription4 = '';
  double latitude = 0;
  double longitude = 0;
  int humidity = 0;
  double windSpeed = 0;
  double rainAmount = 0;

  Future<void> getWeatherData(double latitude, double longitude) async {
    String apiKey = '00893a59672eedb536717886048143c1';
    String apiUrl =
        'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      Map<String, dynamic> weatherData = jsonDecode(response.body);

      location = weatherData['city']['name'];

      forecasts = List<WeatherForecast>.from(
              weatherData['list'].map((item) => WeatherForecast.fromJson(item)))
          .take(5)
          .toList();

      Map<DateTime, List<WeatherForecast>> dailyForecasts = {};

      for (int i = 0; i < forecasts.length; i++) {
        int timestamp = forecasts[i].dt;
        DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
        DateTime day = DateTime(date.year, date.month, date.day);

        if (!dailyForecasts.containsKey(day)) {
          dailyForecasts[day] = [];
        }
        dailyForecasts[day]!.add(forecasts[i]);
      }

      temperature = weatherData['list'][3]['main']['temp'];

      feelslike = weatherData['list'][0]['main']['feels_like'];

      weatherDescriptionToday =
          capitalize(weatherData['list'][0]['weather'][0]['description']);
      weatherDescription1 =
          capitalize(weatherData['list'][1]['weather'][0]['description']);
      weatherDescription2 =
          capitalize(weatherData['list'][2]['weather'][0]['description']);
      weatherDescription3 =
          capitalize(weatherData['list'][3]['weather'][0]['description']);
      weatherDescription4 =
          capitalize(weatherData['list'][4]['weather'][0]['description']);
      humidity = weatherData['list'][0]['main']['humidity'];
      windSpeed = weatherData['list'][0]['wind']['speed'];
      rainAmount = weatherData['list'][0]['rain'] != null
          ? weatherData['list'][0]['rain']['3h']
          : 0;
    } else {
      location = 'Weather not available.';
      temperature = 0;
      feelslike = 0;
      weatherDescriptionToday = '';
      weatherDescription1 = '';
      weatherDescription2 = '';
      weatherDescription3 = '';
      weatherDescription4 = '';
      humidity = 0;
      windSpeed = 0;
      rainAmount = 0;
    }
    notifyListeners();
  }

  String getFormattedDayName(int daysToAdd) {
    DateTime now = DateTime.now();
    DateTime futureDate = now.add(Duration(days: daysToAdd));

    String formattedDate = DateFormat('EEEE').format(futureDate);
    return formattedDate;
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

  double getTemperatureForDay(int dayIndex) {
    if (dayIndex >= 1 && dayIndex <= forecasts.length) {
      return forecasts[dayIndex - 1].temperature;
    } else {
      return 0.0; // Hata durumu için varsayılan değer
    }
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
