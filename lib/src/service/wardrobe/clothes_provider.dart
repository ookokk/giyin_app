import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/wardrobe/clothes.dart';

class ClothesProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Clothes? providerSelectedClothe = Clothes(
      category: "",
      color: "",
      degreeOfLove: "",
      clotheID: "",
      imagePath: "",
      sizeOptions: "",
      season: "",
      notes: "",
      name: "",
      material: "",
      durationOfUse: 0);
  String? userUid;

  ClothesProvider({this.providerSelectedClothe});

  Future<void> addClotheToFirebase(Clothes clothe) async {
    setUserUid();

    if (userUid != null) {
      CollectionReference clothesCollection = FirebaseFirestore.instance
          .collection('users')
          .doc('test@gmail.com')
          .collection('clothes');

      Map<String, dynamic> clotheData = clothe.toJson();

      await clothesCollection.doc('clothe2').set(clotheData);
    }
  }

  void setUserUid() {
    User? user = _auth.currentUser;
    if (user != null) {
      userUid = user.uid;
    }
  }
}
