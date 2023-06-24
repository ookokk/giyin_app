import 'categories/bags.dart';
import 'categories/dresses.dart';
import 'categories/headwear.dart';
import 'categories/hijab.dart';
import 'categories/outer.dart';
import 'categories/pants.dart';
import 'categories/shoes.dart';
import 'categories/tops.dart';

class Clothes {
  String? clotheID;
  //clothe id yi firebasedeki doc id ile eşleyecez sonra
  String? name = '';
  String? notes = '';

  int? durationOfUse;

  List<Map<String, dynamic>> color = [];

  List<int> degreeOfLove = [];
  List<Type> category = [];
  List<String>? material = [];
  List<String>? season = [];
  List<String>? sizeOptions = [];
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
  Map<String, dynamic> toMap() {
    return {
      'category': category.toString(),
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

  Clothes fromMap(Map<String, dynamic> map) {
    return Clothes(
      durationOfUse: map['durationOfUse'],
      name: map['name'],
      category: parseCategory(map['category']),
      color: List<Map<String, dynamic>>.from(map['color']),
      material: List<String>.from(map['material']),
      season: List<String>.from(map['season']),
      degreeOfLove: List<int>.from(map['degreeOfLove']),
      sizeOptions: map.containsKey('sizeOptions')
          ? (map['sizeOptions'] as String).split(',')
          : null,
      notes: map['notes'],
    );
  }

  List<Type> parseCategory(String categoryString) {
    List<Type> categories = [];
    List<String> categoryList = categoryString.split(',');

    for (String categoryName in categoryList) {
      switch (categoryName) {
        case 'Bags':
          categories.add(Bags);
          break;
        case 'Dresses':
          categories.add(Dresses);
          break;
        case 'Headwear':
          categories.add(Headwear);
          break;
        case 'Hijab':
          categories.add(Hijab);
          break;
        case 'Outer':
          categories.add(Outer);
          break;
        case 'Pants':
          categories.add(Pants);
          break;
        case 'Shoes':
          categories.add(Shoes);
          break;
        case 'Tops':
          categories.add(Tops);
          break;
      }
    }

    return categories;
  }
}
