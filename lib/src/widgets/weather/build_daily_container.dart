import 'package:flutter/material.dart';
import '../../constants/text_style.dart';
import '../../models/weather/json_weather.dart';
import '../../models/weather/weather_list.dart';
import '../../service/weather/weather_provider.dart';

class BuildDailyContainer extends StatefulWidget {
  BuildDailyContainer({
    Key? key,
    required this.weatherList,
    required this.dayIndex,
    required this.width,
  }) : super(key: key);
  double width;
  final List<WeatherList> weatherList;
  final int dayIndex;

  @override
  State<BuildDailyContainer> createState() => _BuildDailyContainerState();
}

class _BuildDailyContainerState extends State<BuildDailyContainer> {
  List<List<WeatherList>> dailyWeatherList = [];

  void initializeDailyWeatherList() {
    dailyWeatherList = List.generate(7, (_) => []);
  }

  @override
  Widget build(BuildContext context) {
    WeatherProvider weatherProvider = WeatherProvider();
    initializeDailyWeatherList();

    return Column(
      children: [
        Text(
          weatherProvider
              .getDayOfWeek(widget.weatherList[widget.dayIndex].dtTxt!),
          style: mXXLargeText,
        ),
        Container(
          width: widget.width,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(5, 0),
              ),
            ],
            color: Colors.grey,
            border: Border.all(
              color: Colors.black,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: widget.weatherList.length,
            itemBuilder: (context, index) {
              WeatherList weather = widget.weatherList[index];
              String weatherImage = weatherProvider.getWeatherImage(
                weather.weather![0].description!,
              );

              return ListTile(
                leading: Image.asset(weatherImage),
                title: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          weatherProvider.formatTime(weather.dtTxt!),
                          style: mMediumText,
                        ),
                      ),
                    ),
                    Text(
                      weather.weather![0].description!,
                      style: mMediumText,
                    ),
                    Text(
                      "${weather.main?.temp!.toInt()} °C",
                      style: kMediumText,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
