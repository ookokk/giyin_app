import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/wardrobe/clothes.dart';

class ClothesProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Clothes? selectedClothes;
  String? _userUid;
  int? _durationOfUse = 0;

  List<int>? _degreeOfLove = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  String? _name;
  String? _notes;
  List<String>? _color = [
    'Red',
    'Blue',
    'Green',
    'Yellow',
    'Purple',
    'Orange',
    'Pink',
    'Brown',
    'Gray',
    'Black',
    'White',
    'Cyan',
    'Magenta',
    'Lime',
    'Teal',
  ];

  List<String>? _sizeOptions = [
    'XXS',
    'XS',
    'S',
    'M',
    'L',
    'XL',
    'XXL',
  ];
  List<String>? _season = ['Fall', 'Winter', 'Spring', 'Summer'];
  List<String>? _material = [
    "CanvasFabric",
    "Cashmere",
    "Chenille",
    "Chiffon",
    "Cotton",
    "Crepe",
    "Damask",
    "Georgette",
    "Gingham",
    "Jersey",
    "Lace",
    "Leather",
    "Linen",
    "MerinoWool",
    "Modal",
    "Muslin",
    "Polyester",
    "Satin",
    "Silk",
    "Suede",
    "Twill",
    "Velvet",
    "Viscose"
  ];
  List<String> _category = [
    'Bags',
    'Dresses',
    'HeadWear',
    'Hijab',
    'Outer',
    'Pants',
    'Shoes',
    'Tops',
    'Skirts',
    'Swimwear',
    'Activewear',
    'Sleepwear',
    'Underwear',
    'Socks',
    'Accessories',
    'Costumes',
    'Uniforms',
    'Maternity',
  ];
  // Getters
  List<int>? get degreeOfLove => _degreeOfLove;

  String? get userUid => _userUid;
  int? get durationOfUse => _durationOfUse;
  String? get name => _name;
  List<String> get category => _category;
  List<String>? get color => _color;

  List<String>? get sizeOptions => _sizeOptions;
  List<String>? get season => _season;
  List<String>? get material => _material;
  String? get notes => _notes;

  ClothesProvider({this.selectedClothes}) {
    // Assign the properties from selectedClothes to the corresponding properties in the ClothesProvider
    if (selectedClothes != null) {
      _color = selectedClothes!.color;
      _category = selectedClothes!.category.cast<String>();
      _name = selectedClothes!.name;
      _durationOfUse = selectedClothes!.durationOfUse;
      _sizeOptions = selectedClothes!.sizeOptions;
      _season = selectedClothes!.season;
      _material = selectedClothes!.material;
      _notes = selectedClothes!.notes;
      _degreeOfLove = selectedClothes!.degreeOfLove;
    }
  }
  void saveClothesPropertyToDatabase(
      String userUid, String propertyName, dynamic propertyValue) {
    if (selectedClothes != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userUid)
          .collection('clothes')
          .doc(selectedClothes!.clotheID)
          .update({propertyName: propertyValue}).then((_) {
        print('Kıyafet $propertyName veritabanına başarıyla kaydedildi');
      }).catchError((error) {
        print('Kıyafet $propertyName kaydetme sırasında hata oluştu: $error');
      });
    }
  }

  void setUserUid() {
    User? user = _auth.currentUser;
    if (user != null) {
      _userUid = user.uid;
    }
  }

  void setDegreeOfLove(int degreeOfLove) {
    _degreeOfLove = [degreeOfLove];
    notifyListeners();
  }

  void setCategory(String category) {
    _category = [category];
    notifyListeners();
  }

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setNotes(String notes) {
    _notes = notes;
    notifyListeners();
  }

  void setColor(String color) {
    _color = [color];
    notifyListeners();
  }

  void setDurationOfUse(int durationOfUse) {
    _durationOfUse = durationOfUse;
    notifyListeners();
  }

  void setSizeOptions(String sizeOptions) {
    _sizeOptions = [sizeOptions];
    notifyListeners();
  }

  void setSeason(List<String> season) {
    _season = season;
    notifyListeners();
  }

  void setMaterial(String material) {
    _material = [material];
    notifyListeners();
  }
//save methods

  void saveDegreeOfLoveToDatabase(String userUid, int degree) {
    saveClothesPropertyToDatabase(userUid, 'degreeOfLove', degree);
    print('Saved Degree of Love to Database: $degree');
  }

  void saveColorToDatabase(String userUid, String color) {
    saveClothesPropertyToDatabase(userUid, 'color', color);
  }

  void saveCategoryToDatabase(String userUid, String category) {
    saveClothesPropertyToDatabase(userUid, 'category', category);
  }

  void saveNameToDatabase(String userUid, String name) {
    saveClothesPropertyToDatabase(userUid, 'name', name);
  }

  void saveDurationOfUseToDatabase(String userUid, int durationOfUse) {
    saveClothesPropertyToDatabase(userUid, 'durationOfUse', durationOfUse);
  }

  void saveSizeOptionsToDatabase(String userUid, String sizeOptions) {
    saveClothesPropertyToDatabase(userUid, 'sizeOptions', sizeOptions);
  }

  void saveSeasonToDatabase(String userUid, String season) {
    saveClothesPropertyToDatabase(userUid, 'season', season);
  }

  void saveMaterialToDatabase(String userUid, List<String> material) {
    saveClothesPropertyToDatabase(userUid, 'material', material);
  }

  void saveNotesToDatabase(String userUid, String notes) {
    saveClothesPropertyToDatabase(userUid, 'notes', notes);
  }
}
