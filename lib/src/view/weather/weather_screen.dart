import 'package:flutter/material.dart';
import 'package:giyin/src/service/weather/location_helper.dart';
import 'package:provider/provider.dart';
import '../../constants/color.dart';
import '../../constants/default_padding.dart';
import '../../service/weather/weather_provider.dart';
import '../../widgets/weather/build_daily_column.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({Key? key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  LocationHelper locationHelper = LocationHelper();
  WeatherProvider weatherProvider = WeatherProvider();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    await weatherProvider.getWeather();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(builder: (context, weatherProvider, _) {
      double kWidth = MediaQuery.of(context).size.width;
      double kHeight = MediaQuery.of(context).size.height;
      return Scaffold(
        backgroundColor: CustomColors.kKoyuBeyazBG,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: kDefaultPadding,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isLoading)
                    const CircularProgressIndicator()
                  else
                    Column(
                      children: [
                        BuildDailyColumn(
                          height: kHeight * 0.5,
                          width: kWidth,
                          dayIndex: 0,
                          weatherList: weatherProvider.getWeatherForDay(
                            weatherProvider.currentWeather,
                            0,
                          ),
                        ),
                        BuildDailyColumn(
                          height: kHeight * 0.5,
                          width: kWidth,
                          dayIndex: 1,
                          weatherList: weatherProvider.getWeatherForDay(
                            weatherProvider.currentWeather,
                            1,
                          ),
                        ),
                        BuildDailyColumn(
                          height: kHeight * 0.5,
                          width: kWidth,
                          dayIndex: 2,
                          weatherList: weatherProvider.getWeatherForDay(
                            weatherProvider.currentWeather,
                            2,
                          ),
                        ),
                        BuildDailyColumn(
                          height: kHeight * 0.5,
                          width: kWidth,
                          dayIndex: 3,
                          weatherList: weatherProvider.getWeatherForDay(
                            weatherProvider.currentWeather,
                            3,
                          ),
                        ),
                        BuildDailyColumn(
                          height: kHeight * 0.5,
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
