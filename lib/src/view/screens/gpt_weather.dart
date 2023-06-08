import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../utils/location_helper.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String location = '';
  double temperature = 0;
  String weatherDescription = '';

  LocationHelper locationHelper = LocationHelper();

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  void getCurrentLocation() async {
    await locationHelper.getCurrentLocation();
    setState(() {
      location = 'Konum alınıyor...';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hava Durumu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                getWeatherData(
                    locationHelper.latitude, locationHelper.longitude);
              },
              child: const Text('Hava Durumunu Al'),
            ),
            const SizedBox(height: 16),
            Text('Konum: $location'),
            const SizedBox(height: 16),
            Text('Sıcaklık: $temperature°C'),
            const SizedBox(height: 16),
            Text('Hava Durumu: $weatherDescription'),
          ],
        ),
      ),
    );
  }

  Future<void> getWeatherData(double latitude, double longitude) async {
    String apiKey = '00893a59672eedb536717886048143c1';
    String apiUrl =
        'http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      Map<String, dynamic> weatherData = jsonDecode(response.body);
      setState(() {
        location = weatherData['name'];
        temperature = weatherData['main']['temp'];
        weatherDescription = weatherData['weather'][0]['description'];
      });
    } else {
      setState(() {
        location = 'Hava durumu alınamadı.';
        temperature = 0;
        weatherDescription = '';
      });
    }
  }
}
