import 'package:f6_bootcamp/src/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../constants/color.dart';
import '../../constants/default_padding.dart';
import '../../service/weather/weather_data.dart';
import '../../service/weather/weather_forecast.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(builder: (context, weatherData, _) {
      String weatherImage =
          weatherData.getWeatherImage(weatherData.weatherDescriptionToday);

      return Scaffold(
        backgroundColor: CustomColors.kBlueWeatherBG,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: kDefaultPadding,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildLocationCityRow(weatherData),
                  const SizedBox(
                    height: 16,
                  ),
                  buildUpdateButton(weatherData),
                  const SizedBox(
                    height: 16,
                  ),
                  Image.asset(
                    weatherImage,
                    width: MediaQuery.of(context).size.width * 0.5,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${weatherData.temperature.toInt()}°',
                    style: kXXLargeText,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    weatherData.weatherDescriptionToday,
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
                  buildWindHumidityRainRow(weatherData),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      buildNextDayWeatherContainer(context, weatherData),
                      const SizedBox(
                        width: 8,
                      ),
                      buildNextSecondDayWeatherContainer(context, weatherData),
                      const SizedBox(
                        width: 8,
                      ),
                      buildNextThirdDayWeatherContainer(context, weatherData),
                      const SizedBox(
                        width: 8,
                      ),
                      buildNextFourthDayWeatherContainer(context, weatherData),
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
      BuildContext context, WeatherProvider weatherData) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
            color: CustomColors.kMorGibi,
            borderRadius: BorderRadius.circular(16)),
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                '${weatherData.getTemperatureForDay(4).toInt()}°',
                style: kMediumText,
              ),
              const SizedBox(height: 8),
              Image.asset(
                WeatherForecast.getWeatherImageForecast(
                    weatherData.weatherDescription4),
              ),
              const SizedBox(height: 8),
              Text(weatherData.getFormattedDayName(4), style: kSmallText),
            ],
          ),
        )),
      ),
    );
  }

  Expanded buildNextThirdDayWeatherContainer(
      BuildContext context, WeatherProvider weatherData) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
            color: CustomColors.kMorGibi,
            borderRadius: BorderRadius.circular(16)),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  '${weatherData.getTemperatureForDay(3).toInt()}°',
                  style: kMediumText,
                ),
                const SizedBox(height: 8),
                Image.asset(
                  WeatherForecast.getWeatherImageForecast(
                      weatherData.weatherDescription3),
                ),
                const SizedBox(height: 8),
                Text(weatherData.getFormattedDayName(3), style: kSmallText),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded buildNextSecondDayWeatherContainer(
      BuildContext context, WeatherProvider weatherData) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
            color: CustomColors.kMorGibi,
            borderRadius: BorderRadius.circular(16)),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  '${weatherData.getTemperatureForDay(2).toInt()}°',
                  style: kMediumText,
                ),
                const SizedBox(height: 8),
                Image.asset(
                  WeatherForecast.getWeatherImageForecast(
                      weatherData.weatherDescription2),
                ),
                const SizedBox(height: 8),
                Text(weatherData.getFormattedDayName(2), style: kSmallText),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded buildNextDayWeatherContainer(
      BuildContext context, WeatherProvider weatherData) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
            color: CustomColors.kMorGibi,
            borderRadius: BorderRadius.circular(16)),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  '${weatherData.getTemperatureForDay(1).toInt()}°',
                  style: kMediumText,
                ),
                const SizedBox(height: 8),
                Image.asset(
                  WeatherForecast.getWeatherImageForecast(
                      weatherData.weatherDescription1),
                ),
                const SizedBox(height: 8),
                Text(weatherData.getFormattedDayName(1), style: kSmallText),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildWindHumidityRainRow(WeatherProvider weatherData) {
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
                '${weatherData.windSpeed.toInt()} km/h',
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
                '${weatherData.humidity.toInt()}%',
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
                ' ${weatherData.rainAmount.toInt()}%',
                style: kMediumText,
              ),
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

  ElevatedButton buildUpdateButton(WeatherProvider weatherData) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          side: const BorderSide(width: 1, color: Colors.white),
          backgroundColor: CustomColors.kBlueWeatherBG,
          fixedSize: const Size(130, 40),
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 16)),
      onPressed: () async {
        await weatherData.getCurrentLocation();
        await weatherData.getWeatherData(
          weatherData.latitude,
          weatherData.longitude,
        );
      },
      child: Text(
        'Update',
        style: kMediumText,
      ),
    );
  }

  Row buildLocationCityRow(WeatherProvider weatherData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.location_on_outlined),
        const SizedBox(width: 10),
        Text(weatherData.location, style: kMediumLargeBText),
      ],
    );
  }
}
