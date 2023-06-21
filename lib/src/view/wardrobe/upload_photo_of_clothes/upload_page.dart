import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:f6_bootcamp/src/service/wardrobe/image_upload_provider.dart';

class UploadPage extends StatelessWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ImageUploadProvider>(
      builder: (context, imageUploadProvider, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Upload Photo'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    imageUploadProvider.pickImage(ImageSource.gallery);
                  },
                  child: const Text('Select Photo'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Assuming you have the `image` variable available here
                    File? image = imageUploadProvider.selectedImage;
                    if (image != null) {
                      imageUploadProvider.uploadImageToStorage(image);
                    } else {
                      print('No image selected!');
                    }
                  },
                  child: const Text('Upload Photo'),
                ),
                ElevatedButton(
                  onPressed: () {
                    imageUploadProvider.pickImage(ImageSource.camera);
                  },
                  child: const Text('Take Photo'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
