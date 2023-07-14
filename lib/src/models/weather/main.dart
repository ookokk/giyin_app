class Main {
  double? temp;

  double? tempMin;
  double? tempMax;
  int? pressure;
  int? seaLevel;
  int? grndLevel;
  int? humidity;

  Main({
    this.temp,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.seaLevel,
    this.grndLevel,
    this.humidity,
  });

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp']?.toDouble();

    tempMin = json['temp_min']?.toDouble();
    tempMax = json['temp_max']?.toDouble();
    pressure = json['pressure'];
    seaLevel = json['sea_level'];
    grndLevel = json['grnd_level'];
    humidity = json['humidity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['temp'] = temp;

    data['temp_min'] = tempMin;
    data['temp_max'] = tempMax;
    data['pressure'] = pressure;
    data['sea_level'] = seaLevel;
    data['grnd_level'] = grndLevel;
    data['humidity'] = humidity;

    return data;
  }
}
