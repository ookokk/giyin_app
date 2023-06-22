import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ClothesProvider extends ChangeNotifier {
  final Reference _storageReference = FirebaseStorage.instance.ref();
}
