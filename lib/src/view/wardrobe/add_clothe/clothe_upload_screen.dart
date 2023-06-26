import 'dart:io';
import 'dart:async';
import 'package:f6_bootcamp/src/constants/auth_components/auth_textfield.dart';
import 'package:f6_bootcamp/src/constants/color.dart';
import 'package:f6_bootcamp/src/constants/default_padding.dart';
import 'package:f6_bootcamp/src/constants/text_style.dart';
import 'package:f6_bootcamp/src/constants/wardrobe/upload_photo_button.dart';
import 'package:f6_bootcamp/src/service/wardrobe/clothes_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:f6_bootcamp/src/service/wardrobe/add_clothe/image_upload_provider.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../../../models/wardrobe/clothes.dart';

class ClotheUploadScreen extends StatelessWidget {
  ClotheUploadScreen({Key? key, this.clothes, this.userUid}) : super(key: key);

  final Clothes? clothes;
  final String? userUid;
  final clotheNameController = TextEditingController();
  final clotheNoteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            //size
            String? selectedSize = clothesProvider.sizeOptions?.first;
            List<String>? sizeOptions = ClothesProvider().sizeOptions;
            //material
            String? selectedMaterial = clothesProvider.material?.first;
            List<String>? materialOptions = ClothesProvider().material;
            //category
            String? selectedCategory = clothesProvider.category.first;
            List<String>? categoryOptions = ClothesProvider().category;
            //season
            String? selectedSeasons = clothesProvider.season?.first;
            List<String>? seasonOptions = ClothesProvider().season;
            //color
            String? selectedColor = clothesProvider.color?.first;
            List<String>? colorOptions = ClothesProvider().color;
            //degreeOfLove
            int? selectedDegreeOfLove = clothesProvider.degreeOfLove?.first;
            List<int>? degreeOfLoveOptions = ClothesProvider().degreeOfLove;

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
                        buildTakeUploadPhotoRow(imageUploadProvider, context),
                        AuthTextField(
                            controller: clotheNameController,
                            hintText: "Clothe Name ",
                            obscureText: false),
                        IconButton(
                            onPressed: () {
                              clothesProvider.saveNameToDatabase(
                                  userUid!, clotheNameController.text);
                              print(clotheNameController.text);
                            },
                            icon: Icon(Icons.add)),
                        AuthTextField(
                            controller: clotheNoteController,
                            hintText: "Additional Note",
                            obscureText: false),

                        Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius: BorderRadius.circular(20)),
                          margin: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Expanded(
                                  child:
                                      Text("Select Size", style: kMediumText)),
                              Expanded(
                                child: buildSelectSizeOptionsDropdown(
                                    selectedSize, sizeOptions, clothesProvider),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius: BorderRadius.circular(20)),
                          margin: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Expanded(
                                  child: Text("Select Material",
                                      style: kMediumText)),
                              Expanded(
                                child: buildSelectMaterialOptionsDropdown(
                                    selectedMaterial,
                                    materialOptions,
                                    clothesProvider),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: buildSelectSeasonMultiSelectChipField(
                              seasonOptions, selectedSeasons, clothesProvider),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius: BorderRadius.circular(20)),
                          margin: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Expanded(
                                  child: Text("Select Degree Of Love",
                                      style: kMediumText)),
                              Expanded(
                                child: buildSelectDegreeOfLoveDropdownButton(
                                    selectedDegreeOfLove,
                                    degreeOfLoveOptions,
                                    clothesProvider),
                              ),
                            ],
                          ),
                        ),
                        //select category
                        Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.circular(20)),
                            margin: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Expanded(
                                    child: Text("Select Category",
                                        style: kMediumText)),
                                Expanded(
                                  child: buildSelectCategoryDropdownButton(
                                      selectedCategory,
                                      categoryOptions,
                                      clothesProvider),
                                ),
                              ],
                            )),
                        Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.circular(20)),
                            margin: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Expanded(
                                    child: Text("Select Color",
                                        style: kMediumText)),
                                Expanded(
                                  child: buildSelectColorDropdownButton(
                                      selectedColor,
                                      colorOptions,
                                      clothesProvider),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              )),
            );
          });
        },
      ),
    );
  }

  DropdownButtonHideUnderline buildSelectColorDropdownButton(
      String? selectedColor,
      List<String>? colorOptions,
      ClothesProvider clothesProvider) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: selectedColor,
        hint: Text(selectedColor!),
        items: colorOptions?.map((String colorValue) {
          return DropdownMenuItem<String>(
            value: colorValue,
            child: Text(colorValue),
          );
        }).toList(),
        onChanged: (String? newColor) {
          selectedColor = newColor;
          clothesProvider.setColor(selectedColor!);
          if (clothesProvider.userUid != null && newColor != null) {
            clothesProvider.saveColorToDatabase(
              clothesProvider.userUid!,
              newColor,
            );
            clothesProvider.saveColorToDatabase(
              clothesProvider.userUid!,
              newColor,
            );
          }
          print(newColor);
        },
      ),
    );
  }

  DropdownButtonHideUnderline buildSelectCategoryDropdownButton(
      String selectedCategory,
      List<String> categoryOptions,
      ClothesProvider clothesProvider) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: selectedCategory,
        hint: Text(selectedCategory),
        items: categoryOptions.map((String categoryValue) {
          return DropdownMenuItem<String>(
            value: categoryValue,
            child: Text(categoryValue),
          );
        }).toList(),
        onChanged: (String? newCategory) {
          selectedCategory = newCategory!;
          clothesProvider.setCategory(selectedCategory!);
          if (clothesProvider.userUid != null && newCategory != null) {
            clothesProvider.saveCategoryToDatabase(
              clothesProvider.userUid!,
              newCategory,
            );
            clothesProvider.saveCategoryToDatabase(
              clothesProvider.userUid!,
              newCategory,
            );
          }
          print(newCategory);
        },
      ),
    );
  }

  DropdownButtonHideUnderline buildSelectDegreeOfLoveDropdownButton(
      int? selectedDegreeOfLove,
      List<int>? degreeOfLoveOptions,
      ClothesProvider clothesProvider) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<int>(
        value: selectedDegreeOfLove,
        hint: Text(selectedDegreeOfLove.toString()),
        items: degreeOfLoveOptions?.map((int degreeOfLove) {
              return DropdownMenuItem<int>(
                value: degreeOfLove,
                child: Text(degreeOfLove.toString()),
              );
            }).toList() ??
            [],
        onChanged: (int? newDegreeOfLove) {
          selectedDegreeOfLove = newDegreeOfLove;
          clothesProvider.setDegreeOfLove(selectedDegreeOfLove!);
          if (clothesProvider.userUid != null && newDegreeOfLove != null) {
            clothesProvider.saveDegreeOfLoveToDatabase(
              clothesProvider.userUid!,
              [newDegreeOfLove] as int,
            );
            clothesProvider.saveDegreeOfLoveToDatabase(
              clothesProvider.userUid!,
              [newDegreeOfLove] as int,
            );
          }
          print(newDegreeOfLove);
        },
      ),
    );
  }

  MultiSelectChipField<Object?> buildSelectSeasonMultiSelectChipField(
      List<String>? seasonOptions,
      String? selectedSeasons,
      ClothesProvider clothesProvider) {
    return MultiSelectChipField(
      headerColor: CustomColors.kDarkGray,
      selectedChipColor: CustomColors.kMorGibi,
      title: Text(
        "Select Season",
        style: kMediumText,
      ),
      items: seasonOptions?.map((season) {
            return MultiSelectItem<String>(
              season,
              season,
            );
          }).toList() ??
          [],
      onTap: (selectedItems) {
        List<String> selectedSeasons =
            selectedItems.map((item) => item.toString()).toList();
        clothesProvider.setSeason(selectedSeasons);
// burada kullanıcı seçimi geri çekerse hata alıyoruz bunu kontrol et sonra
        print(selectedSeasons);
      },
    );
  }

  Row buildTakeUploadPhotoRow(
      ImageUploadProvider imageUploadProvider, BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: UploadPhotoButton(
            onPressed: () {
              imageUploadProvider.pickImage(ImageSource.gallery);
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
                imageUploadProvider.cropImage(
                    context, imageUploadProvider.selectedImage!);
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
    );
  }

  DropdownButtonHideUnderline buildSelectMaterialOptionsDropdown(
      String? selectedMaterial,
      List<String>? materialOptions,
      // String? selectedSize,
      ClothesProvider clothesProvider) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: selectedMaterial,
        hint: Text(selectedMaterial!),
        items: materialOptions!.map((String materialValue) {
          return DropdownMenuItem<String>(
            value: materialValue,
            child: Text(materialValue),
          );
        }).toList(),
        onChanged: (String? newMaterial) {
          selectedMaterial = newMaterial;
          clothesProvider.setMaterial(selectedMaterial!);
          if (clothesProvider.userUid != null && newMaterial != null) {
            clothesProvider.saveMaterialToDatabase(
              clothesProvider.userUid!,
              [newMaterial],
            );
            clothesProvider.saveMaterialToDatabase(
              clothesProvider.userUid!,
              [newMaterial],
            );
          }
          print(newMaterial);
        },
      ),
    );
  }

  DropdownButtonHideUnderline buildSelectSizeOptionsDropdown(
      String? selectedSize,
      List<String>? sizeOptions,
      ClothesProvider clothesProvider) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: selectedSize,
        hint: Text(selectedSize!),
        items: sizeOptions!.map((String selectedSize) {
          return DropdownMenuItem<String>(
            value: selectedSize,
            child: Text(selectedSize),
          );
        }).toList(),
        onChanged: (String? newSize) {
          selectedSize = newSize;
          clothesProvider.setSizeOptions(selectedSize!);
          if (clothesProvider.userUid != null && newSize != null) {
            clothesProvider.saveSizeOptionsToDatabase(
              clothesProvider.userUid!,
              newSize,
            );
            clothesProvider.saveSizeOptionsToDatabase(
              clothesProvider.userUid!,
              newSize,
            );
          }
          print(selectedSize);
        },
      ),
    );
  }
}
