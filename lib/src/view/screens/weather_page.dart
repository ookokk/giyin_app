import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../service/weather/weather_data.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherData>(builder: (context, weatherData, _) {
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.location_on_outlined),
                      Text(weatherData.location),
                    ],
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      await weatherData.getCurrentLocation();
                      await weatherData.getWeatherData(
                        weatherData.latitude,
                        weatherData.longitude,
                      );
                      print("${weatherData.feelslike}");
                    },
                    child: const Text('Güncelle'),
                  ),
                  Image.asset("assets/cloudy.png", width: 150),
                  const SizedBox(height: 16),
                  Text('${weatherData.temperature}°C'),
                  const SizedBox(height: 16),
                  Text('Hissedilen: ${weatherData.feelslike}'),
                  const SizedBox(height: 16),
                  Text('Hava Durumu: ${weatherData.weatherDescription}'),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
