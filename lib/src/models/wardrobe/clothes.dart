import 'package:flutter/material.dart';

import 'categories/bags.dart';
import 'categories/dresses.dart';
import 'categories/headwear.dart';
import 'categories/hijab.dart';
import 'categories/outer.dart';
import 'categories/pants.dart';
import 'categories/shoes.dart';
import 'categories/tops.dart';

class Clothes {
  int durationOfUse;
  String name;
  List<Map<String, dynamic>>? color;
  List<Material>? material;
  String? notes;

  List<int> degreeOfLove = [1, 2, 3, 4, 5];
  List<String>? sizeOptions = [
    'XXS',
    'XS',
    'S',
    'M',
    'L',
    'XL',
    'XXL',
  ];
  List<Type> category = [
    Bags,
    Dresses,
    Headwear,
    Hijab,
    Outer,
    Pants,
    Shoes,
    Tops
  ];
  List<String> season = ['Fall', 'Winter', 'Spring', 'Summer'];
  Clothes({
    required this.durationOfUse,
    required this.name,
    required this.category,
    this.color,
    this.material,
    this.notes,
    required this.season,
    required this.degreeOfLove,
    this.sizeOptions,
  });
}
