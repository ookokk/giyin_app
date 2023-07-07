import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../../models/wardrobe/combination/combination.dart';

class ImageUploadProvider extends ChangeNotifier {
  final Reference _storageReference = FirebaseStorage.instance.ref();

  List<String> clothes = [];
  bool loading = false;
  File? selectedImage;
  String? imageUrl;
  Combination providerCombination = Combination();

  Future<List<Combination>> getCombinationsFromFirebase() async {
    final user = FirebaseAuth.instance.currentUser;
    final String userId = user!.uid;
    List<Combination> combinations = [];

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(userId)
        .collection('combinations')
        .get();

    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data();
      Combination combination = Combination(
        dateToWear: data['dateToWear'] != null
            ? (data['dateToWear'] as Timestamp).toDate()
            : null,
        id: doc.id,
        selectedClothedUrls: List<String>.from(data['selectedClothes']),
        createdDate: data['createdDate'] != null
            ? (data['createdDate'] as Timestamp).toDate()
            : null,
      );

      combinations.add(combination);
    });

    return combinations;
  }

  Future<void> uploadCombinationToFirebase(Combination newCombination) async {
    final user = FirebaseAuth.instance.currentUser;
    final String userId = user!.uid;

    final combineData = {
      'dateToWear': newCombination.dateToWear,
      'id': newCombination.id,
      'selectedClothes': newCombination.selectedClothedUrls,
      'createdDate': newCombination.createdDate,
    };

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('combinations')
        .add(combineData)
        .then((docRef) {})
        .catchError((error) {});
  }

  Future<String> uploadImageToStorage(File image) async {
    final user = FirebaseAuth.instance.currentUser;
    final String userId = user!.uid;
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference =
          _storageReference.child('users/$userId/$fileName');
      UploadTask uploadTask = storageReference.putFile(image);
      TaskSnapshot storageSnapshot = await uploadTask;
      String downloadUrl = await storageSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (error) {
      throw Exception(error);
    } finally {
      notifyListeners();
    }
  }

  Future<void> cropImage(BuildContext context, File imageFile) async {
    final crop = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
    );
    if (crop != null) {
      // Kırpılmış resmi kullanarak istediğiniz işlemleri gerçekleştirin
    } else {}
    notifyListeners();
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        selectedImage = File(pickedImage.path);
      }
    } catch (error) {
      throw Exception(error);
    }
    notifyListeners();
  }

  Future<void> getUserClothes() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final String userId = user!.uid;

      final ListResult result =
          await _storageReference.child('users/$userId').listAll();

      clothes.clear();
      for (final item in result.items) {
        final String downloadUrl = await item.getDownloadURL();
        clothes.add(downloadUrl);
      }

      // Set the image URL to the first item in the clothes list, if available
      if (clothes.isNotEmpty) {
        imageUrl = clothes.first;
      } else {
        imageUrl = null;
      }
    } catch (e) {
      clothes.clear();
      imageUrl = null;
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
