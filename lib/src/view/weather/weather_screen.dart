import 'package:flutter/material.dart';
import 'package:giyin/src/models/weather/json_weather.dart';
import 'package:giyin/src/service/weather/location_helper.dart';
import 'package:provider/provider.dart';
import '../../constants/color.dart';
import '../../constants/default_padding.dart';
import '../../constants/text_style.dart';
import '../../models/weather/weather_list.dart';
import '../../service/weather/weather_provider.dart';
import '../../widgets/weather/build_daily_container.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({Key? key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  LocationHelper locationHelper = LocationHelper();
  WeatherProvider weatherProvider = WeatherProvider();

  @override
  void initState() {
    super.initState();
    weatherProvider.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(builder: (context, weatherProvider, _) {
      double kWidth = MediaQuery.of(context).size.width;
      return Scaffold(
        backgroundColor: CustomColors.kKoyuBeyazBG,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: kDefaultPadding,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () async {
                      await weatherProvider.getWeather();
                    },
                    child: Text(
                      "BUTON",
                      style: kMediumText,
                    ),
                  ),
                  Column(
                    children: [
                      BuildDailyContainer(
                        width: kWidth,
                        dayIndex: 0,
                        weatherList: weatherProvider.getWeatherForDay(
                          weatherProvider.currentWeather,
                          0,
                        ),
                      ),
                      BuildDailyContainer(
                        width: kWidth,
                        dayIndex: 1,
                        weatherList: weatherProvider.getWeatherForDay(
                          weatherProvider.currentWeather,
                          1,
                        ),
                      ),
                      BuildDailyContainer(
                        width: kWidth,
                        dayIndex: 2,
                        weatherList: weatherProvider.getWeatherForDay(
                          weatherProvider.currentWeather,
                          2,
                        ),
                      ),
                      BuildDailyContainer(
                        width: kWidth,
                        dayIndex: 3,
                        weatherList: weatherProvider.getWeatherForDay(
                          weatherProvider.currentWeather,
                          3,
                        ),
                      ),
                      BuildDailyContainer(
                        width: kWidth,
                        dayIndex: 4,
                        weatherList: weatherProvider.getWeatherForDay(
                          weatherProvider.currentWeather,
                          4,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
