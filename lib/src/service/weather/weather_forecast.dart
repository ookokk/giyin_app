import 'package:flutter/material.dart';

class WeatherForecast {
  int dt;
  double temperature;
  double feelslike;
  String weatherDescription;
  double windSpeed;
  double rainAmount;
  String icon;
  String image;

  static List<WeatherForecast> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => WeatherForecast.fromJson(json)).toList();
  }

  static WeatherForecast fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      dt: json['dt'],
      temperature: (json['main'] != null && json['main']['temp'] != null)
          ? (json['main']['temp'] as num).toDouble()
          : 0.0,
      feelslike: (json['main'] != null && json['main']['feels_like'] != null)
          ? (json['main']['feels_like'] as num).toDouble()
          : 0.0,
      weatherDescription: capitalize(json['weather'][0]['description']),
      windSpeed: (json['wind'] != null && json['wind']['speed'] != null)
          ? (json['wind']['speed'] as num).toDouble()
          : 0.0,
      rainAmount: (json['rain'] != null && json['rain']['3h'] != null)
          ? (json['rain']['3h'] as num).toDouble()
          : 0.0,
      icon: json['weather'][0]['icon'],
      image: getWeatherImageForecast(json['weather'][0]['description']),
    );
  }

  WeatherForecast({
    required this.dt,
    required this.temperature,
    required this.feelslike,
    required this.weatherDescription,
    required this.windSpeed,
    required this.rainAmount,
    required this.icon,
    required this.image,
  });

  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  static String getWeatherImageForecast(String weatherDescription) {
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

// Örnek kodu buraya ekleyin
List<dynamic> jsonList = []; // JSON veri listesi
List<WeatherForecast> forecastList = WeatherForecast.fromJsonList(jsonList);
WeatherForecast tomorrowForecast = forecastList[1]; // Yarının hava durumu
WeatherForecast secondDayForecast = forecastList[2]; // 2. günün hava durumu
WeatherForecast thirdDayForecast = forecastList[3]; // 3. günün hava durumu
WeatherForecast fourthDayForecast = forecastList[4]; // 4. günün hava durumu
