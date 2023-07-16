import 'package:flutter/material.dart';

import '../../constants/color.dart';
import '../../constants/text_style.dart';
import '../../service/weather/weather_provider.dart';

Container buildCityRow(WeatherProvider weatherProvider) {
  return Container(
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
    child: Row(
      children: [
        const Icon(
          Icons.location_on_outlined,
          size: 40,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Text(
            weatherProvider.currentWeather!.city!.name!,
            style: mXXXLargeText,
          ),
        ),
        IconButton(
          onPressed: () {
            weatherProvider.getWeather();
          },
          icon: const Icon(
            Icons.refresh,
            color: Colors.black,
            size: 35,
          ),
        )
      ],
    ),
  );
}
