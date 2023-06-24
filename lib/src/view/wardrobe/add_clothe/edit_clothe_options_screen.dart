import 'dart:io';

import 'package:f6_bootcamp/src/constants/default_padding.dart';
import 'package:f6_bootcamp/src/constants/wardrobe/upload_photo_button.dart';
import 'package:f6_bootcamp/src/service/wardrobe/add_clothe/image_upload_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/wardrobe/clothes.dart';
import '../../../service/wardrobe/clothes_provider.dart';

class EditClotheOptionsScreen extends StatelessWidget {
  final Clothes? clothes;
  final String? userUid;

  EditClotheOptionsScreen({Key? key, this.clothes, this.userUid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String>? sizeOptions = ClothesProvider().sizeOptions;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ImageUploadProvider>(
          create: (_) => ImageUploadProvider(),
        ),
        ChangeNotifierProvider<ClothesProvider>(
          create: (_) => ClothesProvider(selectedClothes: clothes),
        ),
      ],
      child: Consumer<ImageUploadProvider>(
        builder: (context, imageUploadProvider, _) {
          return Consumer<ClothesProvider>(
            builder: (context, clothesProvider, _) {
              clothesProvider.setUserUid();
              String? selectedSize = clothesProvider.sizeOptions?.first;
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
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                              ),
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.all(20),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: selectedSize,
                                  hint: Text('Select Size'),
                                  items: sizeOptions!.map((String size) {
                                    return DropdownMenuItem<String>(
                                      value: size,
                                      child: Text(size),
                                    );
                                  }).toList(),
                                  onChanged: (String? newSize) {
                                    clothesProvider.setSizeOptions(
                                      context.read<ClothesProvider>().userUid!,
                                      [newSize!],
                                    );
                                  },
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                print(sizeOptions);
                                print("artıya bastın");
                              },
                              child: Icon(Icons.add),
                            ),
                            // Diğer widget'lar buraya eklenir
                            buildSaveClothesToFirebaseButton(
                                imageUploadProvider),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  UploadPhotoButton buildSaveClothesToFirebaseButton(
    ImageUploadProvider imageUploadProvider,
  ) {
    return UploadPhotoButton(
      onPressed: () {
        File? image = imageUploadProvider.selectedImage;
        if (image != null) {
          imageUploadProvider.uploadImageToStorage(image);
        } else {
          print('No image selected!');
        }
      },
      text: "SAVE",
    );
  }
}
