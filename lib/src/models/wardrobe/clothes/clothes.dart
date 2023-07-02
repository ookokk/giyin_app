import 'dart:math';

class Clothes {
  Clothes({
    required this.category,
    required this.color,
    required this.degreeOfLove,
    required this.clotheID,
    required this.imagePath,
    this.seasonOptions,
    this.durationOfUse,
    this.name,
    this.material,
    this.notes,
    this.sizeOptions,
  });
  List<String>? seasonOptions;
  int? durationOfUse;
  String? degreeOfLove;

  String? color;
  String? category;
  String? material;
  String clotheID;
  String? name = '';
  String? notes = '';
  String imagePath;

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
      'season': seasonOptions,
      'sizeOptions': sizeOptions,
    };
  }

  void setClotheID() {
    Random random = Random();
    clotheID = random.nextInt(1000000).toString();
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
    if (seasonOptions == null) {
      seasonOptions = [];
    }

    if (!seasonOptions!.contains(season)) {
      seasonOptions!.add(season);
    }
  }

  void setMaterial(String material) {
    this.material = material;
  }
}
