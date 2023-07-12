// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../constants/color.dart';
import '../../constants/default_padding.dart';
import '../../constants/text_style.dart';
import '../../service/weather/weather_provider.dart';
import '../../service/weather/weather_forecast.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(builder: (context, weatherProvider, _) {
      String weatherImage = weatherProvider
          .getWeatherImage(weatherProvider.weatherDescriptionToday);

      return Scaffold(
        backgroundColor: Colors.white54,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: kDefaultPadding,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildLocationCityRow(weatherProvider),
                  const SizedBox(
                    height: 8,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  buildRefreshButton(weatherProvider),
                  Image.asset(
                    weatherImage,
                    width: MediaQuery.of(context).size.width * 0.35,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${weatherProvider.temperature.toInt()}°',
                    style: kXXLargeText,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    weatherProvider.weatherDescriptionToday,
                    style: kLargeText,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    DateFormat('EEEE, d MMMM').format(DateTime.now()),
                    style: kMediumText,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Divider(
                    height: 0.3,
                    thickness: 0.5,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  Container(
                      decoration: BoxDecoration(
                          color: CustomColors.kLightBlue,
                          borderRadius: BorderRadiusDirectional.circular(18)),
                      child: buildWindHumidityRainRow(weatherProvider)),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      buildNextDayWeatherContainer(context, weatherProvider),
                      const SizedBox(
                        width: 8,
                      ),
                      buildNextSecondDayWeatherContainer(
                          context, weatherProvider),
                      const SizedBox(
                        width: 8,
                      ),
                      buildNextThirdDayWeatherContainer(
                          context, weatherProvider),
                      const SizedBox(
                        width: 8,
                      ),
                      buildNextFourthDayWeatherContainer(
                          context, weatherProvider),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Expanded buildNextFourthDayWeatherContainer(
      BuildContext context, WeatherProvider weatherProvider) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
            color: CustomColors.kLightBlue,
            borderRadius: BorderRadius.circular(16)),
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                '${weatherProvider.getTemperatureForDay(4).toInt()}°',
                style: kMediumText,
              ),
              const SizedBox(height: 8),
              Image.asset(
                WeatherForecast.getWeatherImageForecast(
                    weatherProvider.weatherDescription4),
              ),
              const SizedBox(height: 8),
              Text(weatherProvider.getFormattedDayName(4), style: kSmallText),
            ],
          ),
        )),
      ),
    );
  }

  Expanded buildNextThirdDayWeatherContainer(
      BuildContext context, WeatherProvider weatherProvider) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
            color: CustomColors.kLightBlue,
            borderRadius: BorderRadius.circular(16)),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  '${weatherProvider.getTemperatureForDay(3).toInt()}°',
                  style: kMediumText,
                ),
                const SizedBox(height: 8),
                Image.asset(
                  WeatherForecast.getWeatherImageForecast(
                      weatherProvider.weatherDescription3),
                ),
                const SizedBox(height: 8),
                Text(weatherProvider.getFormattedDayName(3), style: kSmallText),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded buildNextSecondDayWeatherContainer(
      BuildContext context, WeatherProvider weatherProvider) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
            color: CustomColors.kLightBlue,
            borderRadius: BorderRadius.circular(16)),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  '${weatherProvider.getTemperatureForDay(2).toInt()}°',
                  style: kMediumText,
                ),
                const SizedBox(height: 8),
                Image.asset(
                  WeatherForecast.getWeatherImageForecast(
                      weatherProvider.weatherDescription2),
                ),
                const SizedBox(height: 8),
                Text(weatherProvider.getFormattedDayName(2), style: kSmallText),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded buildNextDayWeatherContainer(
      BuildContext context, WeatherProvider weatherProvider) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
            color: CustomColors.kLightBlue,
            borderRadius: BorderRadius.circular(16)),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  '${weatherProvider.getTemperatureForDay(1).toInt()}°',
                  style: kMediumText,
                ),
                const SizedBox(height: 8),
                Image.asset(
                  WeatherForecast.getWeatherImageForecast(
                      weatherProvider.weatherDescription1),
                ),
                const SizedBox(height: 8),
                Text(weatherProvider.getFormattedDayName(1), style: kSmallText),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildWindHumidityRainRow(WeatherProvider weatherProvider) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Image.asset(
                'assets/images/wind_info.png',
                height: 46,
              ),
              Text(
                '${weatherProvider.windSpeed.toInt()} km/h',
                style: kMediumText,
              ),
              Text(
                'Wind',
                style: kSmallText,
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Image.asset('assets/images/humidity.png', height: 46),
              Text(
                '${weatherProvider.humidity.toInt()}%',
                style: kMediumText,
              ),
              Text(
                'Humidity',
                style: kSmallText,
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Image.asset(
                'assets/images/rain_percent.png',
                height: 46,
              ),
              Text(
                ' ${weatherProvider.rainAmount.toInt()}%',
                style: kMediumText,
              ),
              IconButton(
                  onPressed: () {
                    print(weatherProvider.rainAmount);
                    print(weatherProvider
                        .getWeatherImage(weatherProvider.weatherDescription2));
                    print(weatherProvider
                        .getWeatherImage(weatherProvider.weatherDescription3));
                    print(weatherProvider
                        .getWeatherImage(weatherProvider.weatherDescription4));
                  },
                  icon: Icon(Icons.add)),
              Text(
                'Chance of rain',
                style: kSmallText,
              )
            ],
          ),
        ),
      ],
    );
  }

  ElevatedButton buildRefreshButton(WeatherProvider weatherProvider) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            maximumSize: const Size(200, 150),
            minimumSize: const Size(150, 50),
            foregroundColor: Colors.black,
            side: const BorderSide(width: 1, color: Colors.white),
            backgroundColor: CustomColors.kGrimsi,
            fixedSize: const Size(130, 40),
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(horizontal: 16)),
        onPressed: () async {
          await weatherProvider.getCurrentLocation();
          await weatherProvider.getWeatherData(
            weatherProvider.latitude,
            weatherProvider.longitude,
          );
          weatherProvider.notifyListeners();
        },
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Refresh',
                style: kMediumText,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.refresh)
          ],
        ));
  }

  Row buildLocationCityRow(WeatherProvider weatherProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.location_on_outlined),
        const SizedBox(width: 10),
        Text(weatherProvider.location, style: kMediumLargeBText),
      ],
    );
  }
}
