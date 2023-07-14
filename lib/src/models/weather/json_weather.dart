import 'dart:convert';

import 'city.dart';
import 'weather_list.dart';

class JsonWeather {
  String? cod;
  int? message;
  int? cnt;
  List<WeatherList>? list;
  City? city;

  JsonWeather({this.cod, this.message, this.cnt, this.list, this.city});
  @override
  String toString() {
    return json.encode(toJson());
  }

  JsonWeather.fromJson(Map<String, dynamic> json) {
    cod = json['cod'];
    message = json['message'];
    cnt = json['cnt'];
    if (json['list'] != null) {
      list = <WeatherList>[];
      json['list'].forEach((v) {
        list!.add(WeatherList.fromJson(v));
      });
    }
    city = json['city'] != null ? City.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cod'] = cod;
    data['message'] = message;
    data['cnt'] = cnt;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    if (city != null) {
      data['city'] = city!.toJson();
    }
    return data;
  }
}
