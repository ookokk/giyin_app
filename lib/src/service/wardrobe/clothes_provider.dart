import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f6_bootcamp/src/models/wardrobe/clothes/my_clothe1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/wardrobe/clothes/clothes.dart';

class ClothesProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Clothes? providerSelectedClothe;
  String? userUid;

  ClothesProvider({this.providerSelectedClothe});

  Future<void> addClotheToFirebase(Clothes clothe) async {
    setUserUid();

    if (userUid != null) {
      CollectionReference clothesCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(userUid)
          .collection('clothes');

      Map<String, dynamic> clotheData = clothe.toJson();

      await clothesCollection
          .doc(myClothe1?.name ?? myClothe1?.clotheID)
          .set(clotheData);
    }
  }

  void setUserUid() {
    User? user = _auth.currentUser;
    if (user != null) {
      userUid = user.uid;
    }
  }
}
