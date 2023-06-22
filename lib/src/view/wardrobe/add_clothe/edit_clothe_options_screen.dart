import 'dart:io';

import 'package:f6_bootcamp/src/constants/default_padding.dart';
import 'package:f6_bootcamp/src/constants/wardrobe/upload_photo_button.dart';
import 'package:f6_bootcamp/src/service/wardrobe/add_clothe/image_upload_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditClotheOptionsScreen extends StatelessWidget {
  const EditClotheOptionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ImageUploadProvider>(
      builder: (context, imageUploadProvider, _) {
        return Scaffold(
          appBar: AppBar(
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
                    children: [
                      if (imageUploadProvider.selectedImage != null)
                        Image.file(
                          imageUploadProvider.selectedImage!,
                          height: MediaQuery.of(context).size.height * 0.3,
                        ),
                      //kıyafete bir isim ver
                      // Kategori seçimi  ekleyin
                      // Mevsim seçimini ekleyin
                      //renk seç
                      //bunun altındakiler isteğe bağlı
                      //sevme derecesi ekle

                      //kıyafetin kumaşı isteğe bağlı seç

                      // Not ekleme alanını ekleyin
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
    );
  }
}
