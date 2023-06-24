import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../models/wardrobe/categories/bags.dart';
import '../../models/wardrobe/categories/dresses.dart';
import '../../models/wardrobe/categories/headwear.dart';
import '../../models/wardrobe/categories/hijab.dart';
import '../../models/wardrobe/categories/outer.dart';
import '../../models/wardrobe/categories/pants.dart';
import '../../models/wardrobe/categories/shoes.dart';
import '../../models/wardrobe/categories/tops.dart';
import '../../models/wardrobe/clothes.dart';

class ClothesProvider with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Clothes? selectedClothes;
  String? _userUid;
  List<int>? _degreeOfLove = [1, 2, 3, 4, 5];

  List<Type> _category = [
    Bags,
    Dresses,
    Headwear,
    Hijab,
    Outer,
    Pants,
    Shoes,
    Tops
  ];
  String? _name;
  String? _notes;
  String? _color;
  int? _durationOfUse = 0;
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

  // Getters
  List<int>? get degreeOfLove => _degreeOfLove;
  String? get color => _color;
  String? get userUid => _userUid;
  List<Type> get category => _category;
  String? get name => _name;
  int? get durationOfUse => _durationOfUse;
  List<String>? get sizeOptions => _sizeOptions;
  List<String>? get season => _season;
  List<String>? get material => _material;
  String? get notes => _notes;

  ClothesProvider({this.selectedClothes}) {
    // Assign the properties from selectedClothes to the corresponding properties in the ClothesProvider
    if (selectedClothes != null) {
      _color = selectedClothes!.color as String?;
      _category = selectedClothes!.category as List<Type>;
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
          .collection('collections')
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

  void setColor(String userUid, String color) {
    _color = color;
    saveColorToDatabase(userUid, color);
    notifyListeners();
  }

  void setCategory(String userUid, String category) {
    _category = category as List<Type>;
    saveCategoryToDatabase(userUid, category);
    notifyListeners();
  }

  void setName(String userUid, String name) {
    _name = name;
    saveNameToDatabase(userUid, name);
    notifyListeners();
  }

  void setDurationOfUse(String userUid, int durationOfUse) {
    _durationOfUse = durationOfUse;
    saveDurationOfUseToDatabase(userUid, durationOfUse);
    notifyListeners();
  }

  void setSizeOptions(String userUid, List<String> sizeOptions) {
    _sizeOptions = sizeOptions;
    saveSizeOptionsToDatabase(userUid, sizeOptions);
    notifyListeners();
  }

  void setSeason(String userUid, List<String> season) {
    _season = season;
    saveSeasonToDatabase(userUid, season);
    notifyListeners();
  }

  void setMaterial(String userUid, List<String> material) {
    _material = material;
    saveMaterialToDatabase(userUid, material);
    notifyListeners();
  }

  void setNotes(String userUid, String notes) {
    _notes = notes;
    saveNotesToDatabase(userUid, notes);
    notifyListeners();
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

  void saveSizeOptionsToDatabase(String userUid, List<String> sizeOptions) {
    saveClothesPropertyToDatabase(userUid, 'sizeOptions', sizeOptions);
    notifyListeners();
  }

  void saveSeasonToDatabase(String userUid, List<String> season) {
    saveClothesPropertyToDatabase(userUid, 'season', season);
    notifyListeners();
  }

  void saveMaterialToDatabase(String userUid, List<String> material) {
    saveClothesPropertyToDatabase(userUid, 'material', material);
    notifyListeners();
  }

  //-----------

  void saveNotesToDatabase(String userUid, String notes) {
    saveClothesPropertyToDatabase(userUid, 'notes', notes);
  }
}
