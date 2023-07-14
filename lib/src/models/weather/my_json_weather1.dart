import 'package:giyin/src/models/weather/json_weather.dart';

import 'city.dart';
import 'coord.dart';

JsonWeather myJsonWeather1 = JsonWeather(
  message: 0,
  cnt: 0,
  cod: "",
  list: [],
  city: City(
    id: 1,
    name: "mersin",
    coord: Coord(),
    country: "",
    population: 0,
    sunrise: 0,
    sunset: 0,
    timezone: 0,
  ),
);
