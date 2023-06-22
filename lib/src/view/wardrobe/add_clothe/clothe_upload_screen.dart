import 'dart:io';

import 'package:f6_bootcamp/src/constants/default_padding.dart';
import 'package:f6_bootcamp/src/constants/wardrobe/upload_photo_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:f6_bootcamp/src/service/wardrobe/add_clothe/image_upload_provider.dart';

class ClotheUploadScreen extends StatelessWidget {
  const ClotheUploadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ImageUploadProvider>(
      builder: (context, imageUploadProvider, _) {
        return Scaffold(
          appBar: AppBar(
            //edit butonuna fonksiyon ata
            actions: [
              IconButton(
                  onPressed: () {
                    if (imageUploadProvider.selectedImage != null) {
                      imageUploadProvider.cropImage(
                        context,
                        imageUploadProvider.selectedImage!,
                      );
                    }
                  },
                  icon: const Icon(Icons.edit))
            ],
            backgroundColor: Colors.black87,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back)),
          ),
          body: SingleChildScrollView(
              child: SafeArea(
            child: Padding(
              padding: kDefaultPadding,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (imageUploadProvider.selectedImage != null)
                      Image.file(
                        imageUploadProvider.selectedImage!,
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(
                          child: UploadPhotoButton(
                            onPressed: () {
                              imageUploadProvider
                                  .pickImage(ImageSource.gallery);
                            },
                            text: "Select Photo",
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: UploadPhotoButton(
                            onPressed: () {
                              imageUploadProvider.pickImage(ImageSource.camera);
                              if (imageUploadProvider.selectedImage != null) {
                                imageUploadProvider.cropImage(context,
                                    imageUploadProvider.selectedImage!);
                              } else {
                                // Handle the case when selectedImage is null
                              }
                            },
                            text: "Take Photo",
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: UploadPhotoButton(
                            onPressed: () {
                              File? image = imageUploadProvider.selectedImage;
                              if (image != null) {
                                imageUploadProvider.uploadImageToStorage(image);
                              } else {
                                print('No image selected!');
                              }
                            },
                            text: "Upload Photo",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    UploadPhotoButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/editClotheOptions');
                      },
                      text: "Edit Outfit Information ",
                    )
                  ],
                ),
              ),
            ),
          )),
        );
      },
    );
  }
}
