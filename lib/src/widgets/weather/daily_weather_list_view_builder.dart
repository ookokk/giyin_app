/*
import 'package:flutter/material.dart';
import 'package:giyin/src/service/weather/weather_provider.dart';

import '../../constants/text_style.dart';
import '../../models/weather/weather_list.dart';

class DailyWeatherListViewBuilder extends StatelessWidget {
  final List<WeatherList> weatherList;

  DailyWeatherListViewBuilder({required this.weatherList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: weatherList.length,
      itemBuilder: (context, index) {
        WeatherList weather = weatherList[index];
        String weatherImage =
            WeatherProvider().getWeatherImage(weather.weather![0].description!);

        return ListTile(
          leading: Image.asset(weatherImage),
          title: Text(
            "${weather.dtTxt}",
            style: kMediumText,
          ),
          subtitle: Text(
            "${weather.main?.temp} °C",
            style: kMediumText,
          ),
        );
      },
    );
  }
}
*/
