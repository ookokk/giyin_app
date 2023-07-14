import 'package:giyin/src/models/weather/wind.dart';

import 'clouds.dart';
import 'main.dart';
import 'sys.dart';
import 'weather.dart';

class WeatherList {
  int? dt;
  Main? main;
  List<Weather>? weather;
  Clouds? clouds;
  Wind? wind;
  int? visibility;

  Sys? sys;
  String? dtTxt;

  WeatherList({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.visibility,
    this.sys,
    this.dtTxt,
  });

  WeatherList.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    main = json['main'] != null ? Main.fromJson(json['main']) : null;
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather!.add(Weather.fromJson(v));
      });
    }
    clouds = json['clouds'] != null ? Clouds.fromJson(json['clouds']) : null;
    wind = json['wind'] != null ? Wind.fromJson(json['wind']) : null;
    visibility = json['visibility'];

    sys = json['sys'] != null ? Sys.fromJson(json['sys']) : null;
    dtTxt = json['dt_txt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dt'] = dt;
    if (main != null) {
      data['main'] = main!.toJson();
    }
    if (weather != null) {
      data['weather'] = weather!.map((v) => v.toJson()).toList();
    }
    if (clouds != null) {
      data['clouds'] = clouds!.toJson();
    }
    if (wind != null) {
      data['wind'] = wind!.toJson();
    }
    data['visibility'] = visibility;

    if (sys != null) {
      data['sys'] = sys!.toJson();
    }
    data['dt_txt'] = dtTxt;
    return data;
  }
}
