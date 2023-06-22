import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageUploadProvider extends ChangeNotifier {
  final Reference _storageReference = FirebaseStorage.instance.ref();
  List<String> clothes = [];
  bool loading = false;
  File? selectedImage;

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
    } catch (e) {
      print('Error fetching user clothes from Firebase Storage: $e');
      clothes.clear();
    } finally {
      loading = false;
      notifyListeners();
    }
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
      print(error);
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
    } else {
      print('Image cropping cancelled!');
    }
    notifyListeners();
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().getImage(source: source);
      if (pickedImage != null) {
        selectedImage = File(pickedImage.path);
      }
    } catch (error) {
      print(error);
      throw Exception(error);
    }
    notifyListeners();
  }
}
