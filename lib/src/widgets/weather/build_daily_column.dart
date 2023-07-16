// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:giyin/src/constants/color.dart';
import '../../constants/text_style.dart';
import '../../models/weather/weather_list.dart';
import '../../service/weather/weather_provider.dart';

class BuildDailyColumn extends StatelessWidget {
  BuildDailyColumn({
    Key? key,
    required this.height,
    required this.weatherList,
    required this.dayIndex,
    required this.width,
  }) : super(key: key);
  double width;
  double height;
  final List<WeatherList> weatherList;
  final int dayIndex;
  List<List<WeatherList>> dailyWeatherList = [];

  @override
  Widget build(BuildContext context) {
    WeatherProvider weatherProvider = WeatherProvider();

    return Column(
      children: [
        Text(
          weatherProvider.getDayOfWeek(weatherList[dayIndex].dtTxt!),
          style: mXXXLargeText,
        ),
        Container(
          width: width,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(3, 0),
              ),
            ],
            color: CustomColors.kKoyuBeyazBG,
            border: Border.all(
              color: Colors.white,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: weatherList.length,
            itemBuilder: (context, index) {
              WeatherList weather = weatherList[index];
              String weatherImage = weatherProvider.getWeatherImage(
                weather.weather![0].description!,
              );

              return ListTile(
                leading: ClipOval(
                  child: Image.asset(
                    weatherImage,
                  ),
                ),
                title: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            weatherProvider.formatTime(weather.dtTxt!),
                            style: mMediumText,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            weatherProvider.toFirstLetterUp(
                                weather.weather![0].description!),
                            style: mMediumText,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Text(
                            "${weather.main?.temp!.toInt()} °C",
                            style: kMediumText,
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: CustomColors.kDarkBlue,
                      thickness: 1,
                      height: 1,
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
