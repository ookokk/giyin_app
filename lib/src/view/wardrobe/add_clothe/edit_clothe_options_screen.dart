import 'dart:io';

import 'package:f6_bootcamp/src/constants/default_padding.dart';
import 'package:f6_bootcamp/src/constants/wardrobe/upload_photo_button.dart';
import 'package:f6_bootcamp/src/service/wardrobe/add_clothe/image_upload_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../service/wardrobe/clothes_provider.dart';

class EditClotheOptionsScreen extends StatelessWidget {
  const EditClotheOptionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ImageUploadProvider>(
          create: (_) => ImageUploadProvider(),
        ),
        ChangeNotifierProvider<ClothesProvider>(
          create: (_) => ClothesProvider(),
        ),
      ],
      child: Consumer<ImageUploadProvider>(
        builder: (context, imageUploadProvider, _) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black87,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: kDefaultPadding,
                  child: Center(
                    child: Column(
                      children: [
                        if (imageUploadProvider.selectedImage != null)
                          Image.file(
                            imageUploadProvider.selectedImage!,
                            height: MediaQuery.of(context).size.height * 0.3,
                          ),
                        // Diğer widget'lar buraya eklenir
                        UploadPhotoButton(
                          onPressed: () {
                            File? image = imageUploadProvider.selectedImage;
                            if (image != null) {
                              imageUploadProvider.uploadImageToStorage(image);
                            } else {
                              print('No image selected!');
                            }
                          },
                          text: "SAVE",
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
