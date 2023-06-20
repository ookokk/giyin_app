import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class UploadImageToStorage {
  final Reference _storageReference = FirebaseStorage.instance.ref();

  Future<String> uploadImage(File image) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageRef = _storageReference.child('images/$fileName.jpg');
    UploadTask uploadTask = storageRef.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String imageUrl = await taskSnapshot.ref.getDownloadURL();
    return imageUrl;
  }
}
