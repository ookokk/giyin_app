import 'dart:math';

class Clothes {
  Clothes({
    required this.category,
    required this.color,
    required this.degreeOfLove,
    required this.clotheID,
    required this.imagePath,
    this.season,
    this.durationOfUse,
    this.name,
    this.material,
    this.notes,
    this.sizeOptions,
  });
  String clotheID = Random().nextInt(1000).toString();
  String? name = '';
  String? notes = '';
  String imagePath;

  int? durationOfUse;
  String? degreeOfLove;

  String? color;
  String? category;
  String? material;
  String? season;
  String? sizeOptions;

  Map<String, dynamic> toJson() {
    return {
      'clotheID': clotheID,
      'name': name,
      'notes': notes,
      'durationOfUse': durationOfUse,
      'color': color,
      'degreeOfLove': degreeOfLove,
      'category': category,
      'material': material,
      'season': season,
      'sizeOptions': sizeOptions,
    };
  }

  void setDegreeOfLove(String degreeOfLove) {
    this.degreeOfLove = degreeOfLove;
  }

  void setCategory(String category) {
    this.category = category;
  }

  void setName(String name) {
    this.name = name;
  }

  void setNotes(String notes) {
    this.notes = notes;
  }

  void setColor(String color) {
    this.color = color;
  }

  void setDurationOfUse(int durationOfUse) {
    this.durationOfUse = durationOfUse;
  }

  void setSizeOptions(String sizeOptions) {
    this.sizeOptions = sizeOptions;
  }

  void setSeason(String season) {
    this.season = season;
  }

  void setMaterial(String material) {
    this.material = material;
  }
}
