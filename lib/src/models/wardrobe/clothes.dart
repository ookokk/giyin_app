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
  String name;
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
  Color? color;
  String? material;
  String? notes;
  String season;
  int degreeOfLove;
  String size;

  Clothes({
    required this.name,
    required this.category,
    this.color,
    this.material,
    this.notes,
    required this.season,
    required this.degreeOfLove,
    required this.size,
  });
}
