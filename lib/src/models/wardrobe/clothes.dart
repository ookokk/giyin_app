class Clothes {
  Clothes({
    required this.category,
    required this.color,
    required this.degreeOfLove,
    this.season,
    this.durationOfUse,
    this.name,
    this.material,
    this.notes,
    this.sizeOptions,
    this.clotheID,
  });
  String? clotheID;
  //clothe id yi firebasedeki doc id ile eşleyecez sonra
  String? name = '';
  String? notes = '';

  int? durationOfUse;

  List<String> color = [];

  List<int> degreeOfLove = [];
  List<String> category = [];
  List<String>? material = [];
  List<String>? season = [];
  List<String>? sizeOptions = [];

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'color': color,
      'material': material,
      'season': season,
      'degreeOfLove': degreeOfLove,
      'durationOfUse': durationOfUse,
      'notes': notes,
      'sizeOptions': sizeOptions,
      'name': name,
    };
  }

  factory Clothes.fromMap(Map<String, dynamic> map) {
    return Clothes(
      durationOfUse: map['durationOfUse'],
      name: map['name'],
      category: List<String>.from(map['category']),
      color: List<String>.from(map['color']),
      material: List<String>.from(map['material']),
      season: List<String>.from(map['season']),
      degreeOfLove: List<int>.from(map['degreeOfLove']),
      sizeOptions: List<String>.from(map['sizeOptions']),
      notes: map['notes'],
    );
  }
}
