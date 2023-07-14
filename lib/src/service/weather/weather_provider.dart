import 'package:flutter/material.dart';
import 'package:giyin/src/models/weather/weather_list.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:giyin/src/models/weather/json_weather.dart';
import 'package:giyin/src/service/weather/location_helper.dart';
import 'package:intl/intl.dart';
import '../../../ignore.dart';

class WeatherProvider with ChangeNotifier {
  JsonWeather _currentWeather = JsonWeather();
  final LocationHelper _locationHelper = LocationHelper();
  double latitude = 0;
  double longitude = 0;
  JsonWeather? get currentWeather => _currentWeather;

  Future<void> getWeather() async {
    try {
      await _locationHelper.getCurrentLocation();
      latitude = _locationHelper.latitude;
      longitude = _locationHelper.longitude;

      String apiUrl =
          'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';

      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        JsonWeather weather = JsonWeather.fromJson(json.decode(response.body));
        print(weather);
        _currentWeather = weather;
        notifyListeners();
      } else {
        throw Exception('Failed to fetch weather data');
      }
    } catch (error) {
      print('Error occurred in getWeather(): $error');
    }
  }

  String capitalize(String text) {
    try {
      if (text.isEmpty) return text;
      return text[0].toUpperCase() + text.substring(1);
    } catch (error) {
      print('Error occurred in capitalize(): $error');

      return text;
    }
  }

  List<List<WeatherList>> getDailyWeatherList(JsonWeather jsonWeather) {
    List<List<WeatherList>> dailyWeatherList = [];
    List<WeatherList>? weatherList = jsonWeather.list;

    if (weatherList != null && weatherList.isNotEmpty) {
      DateTime currentDate = DateTime.parse(weatherList[0].dtTxt!);
      List<WeatherList> dailyList = [];

      void addDailyList() {
        dailyWeatherList.add(dailyList);
        dailyList = [];
      }

      try {
        for (int i = 0; i < weatherList.length; i++) {
          WeatherList weather = weatherList[i];
          DateTime? weatherDate = DateTime.tryParse(weather.dtTxt!);

          if (weatherDate != null) {
            dailyList.add(weather);

            if (weatherDate.day != currentDate.day) {
              addDailyList();
              currentDate = weatherDate;
              dailyList = [weather];
            }
          }
        }

        addDailyList();
      } catch (error) {
        print('Error occurred in getDailyWeatherList(): $error');
      }
    }

    return dailyWeatherList;
  }

  List<WeatherList> getWeatherForDay(JsonWeather? jsonWeather, int dayIndex) {
    if (jsonWeather != null) {
      List<List<WeatherList>> dailyWeatherList =
          getDailyWeatherList(jsonWeather);

      if (dayIndex >= 0 && dayIndex < dailyWeatherList.length) {
        return dailyWeatherList[dayIndex];
      }
    }

    return [];
  }

  String getDayOfWeek(String dtTxt) {
    DateTime dateTime = DateTime.parse(dtTxt);
    String dayOfWeek = DateFormat('EEEE').format(dateTime);
    return dayOfWeek;
  }

  String formatTime(String dateTime) {
    DateTime parsedDateTime = DateTime.parse(dateTime);
    String formattedTime =
        '${parsedDateTime.hour.toString().padLeft(2, '0')}:00';
    return formattedTime;
  }

  String getWeatherImage(String weatherDescription) {
    if (weatherDescription.contains('rain')) {
      return 'assets/images/rainy.png';
    } else if (weatherDescription.contains('sun')) {
      return 'assets/images/sunny.png';
    } else if (weatherDescription.contains('cloud')) {
      return 'assets/images/cloudy_sunny.png';
    } else if (weatherDescription.contains('storm')) {
      return 'assets/images/thunderstorm.png';
    } else if (weatherDescription.contains('wind')) {
      return 'assets/images/windy.png';
    } else if (weatherDescription.contains('clear')) {
      return 'assets/images/clear.png';
    } else {
      return 'assets/images/season.png';
    }
  }
}
