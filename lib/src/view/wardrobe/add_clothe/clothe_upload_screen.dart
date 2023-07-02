// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, must_be_immutable

import 'dart:io';
import 'package:f6_bootcamp/src/constants/color.dart';
import 'package:f6_bootcamp/src/models/wardrobe/clothes/my_clothe1.dart';
import 'package:f6_bootcamp/src/models/wardrobe/clothes/clothe_list.dart';
import 'package:f6_bootcamp/src/constants/auth_components/auth_textfield.dart';

import 'package:f6_bootcamp/src/constants/default_padding.dart';
import 'package:f6_bootcamp/src/constants/text_style.dart';
import 'package:f6_bootcamp/src/constants/wardrobe/upload_photo_button.dart';
import 'package:f6_bootcamp/src/service/wardrobe/clothes_provider.dart';
import 'package:f6_bootcamp/src/widgets/wardrobe/string_dropdown_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';
import 'package:f6_bootcamp/src/service/wardrobe/add_clothe/image_upload_provider.dart';
import '../../../models/wardrobe/clothes/clothes.dart';

class ClotheUploadScreen extends StatelessWidget {
  ClotheUploadScreen({Key? key, this.screenClothe, this.userUid})
      : super(key: key);

  String? selectedSizeValue;
  String? selectedMaterialValue;
  String? selectedDegreeOfLoveValue;
  String? selectedCategoryValue;
  String? selectedColorValue;
  List<String> selectedSeasonsList = [];

  Clothes? screenClothe;
  String? userUid;
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
          create: (_) => ClothesProvider(providerSelectedClothe: screenClothe),
        ),
      ],
      child: Consumer<ImageUploadProvider>(
        builder: (context, imageUploadProvider, _) {
          return Consumer<ClothesProvider>(
              builder: (context, clothesProvider, _) {
            clothesProvider.setUserUid();
            //size

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
                          )
                        else
                          Image.asset(
                            "assets/images/add_clothe.png",
                            height: MediaQuery.of(context).size.height * 0.3,
                          ),
                        const SizedBox(height: 18),
                        buildTakeUploadPhotoRow(imageUploadProvider, context),
                        MultiSelectChipField<String?>(
                          headerColor: CustomColors.kDarkBlue,
                          title:
                              Text("Select Season", style: kMediumLargeWText),
                          textStyle: kSmallText,
                          items: ClotheList()
                                  .season
                                  ?.map((e) => MultiSelectItem(e, e))
                                  .toList() ??
                              [],
                          onTap: (List<String?> values) {
                            values.forEach((value) {
                              if (value != null) {
                                selectedSeasonsList.add(value);
                                myClothe1!.setSeason(value);
                                print(value);
                                clothesProvider.notifyListeners();
                              }
                            });
                          },
                        ),
                        /*IconButton(
                            onPressed: () {
                              print(myClothe1!.seasonOptions);
                              print(myClothe1!.sizeOptions);
                              print(myClothe1!.material);
                              print(myClothe1!.degreeOfLove);
                              print(myClothe1!.category);
                              print(myClothe1!.color);
                              print(myClothe1!.name);
                              print(myClothe1!.notes);
                            },
                            icon: Icon(Icons.add)),*/
                        Container(
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          margin: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Expanded(
                                  child: StringDropdownButton(
                                      context,
                                      selectedSizeValue,
                                      ClotheList().sizeOptions,
                                      "Select Size", (String? y) {
                                selectedSizeValue = y;

                                myClothe1?.setSizeOptions(selectedSizeValue!);

                                clothesProvider.notifyListeners();
                              })),
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          margin: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Expanded(
                                  child: StringDropdownButton(
                                      context,
                                      selectedMaterialValue,
                                      ClotheList().material,
                                      "Select Material", (String? y) {
                                selectedMaterialValue = y;
                                myClothe1!.setMaterial(selectedMaterialValue!);
                                clothesProvider.notifyListeners();
                              })),
                            ],
                          ),
                        ),

                        Container(
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          margin: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Expanded(
                                  child: StringDropdownButton(
                                      context,
                                      selectedDegreeOfLoveValue,
                                      ClotheList().degreeOfLove,
                                      "Select Degree Of Love", (String? y) {
                                selectedDegreeOfLoveValue = y;
                                myClothe1!.setDegreeOfLove(
                                    selectedDegreeOfLoveValue!);
                                clothesProvider.notifyListeners();
                              })),
                            ],
                          ),
                        ),
                        //select category
                        Container(
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            margin: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Expanded(
                                    child: StringDropdownButton(
                                        context,
                                        selectedCategoryValue,
                                        ClotheList().category,
                                        "Select Category", (String? y) {
                                  selectedCategoryValue = y;
                                  myClothe1!
                                      .setCategory(selectedCategoryValue!);
                                  clothesProvider.notifyListeners();
                                })),
                              ],
                            )),
                        Container(
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            margin: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Expanded(
                                    child: StringDropdownButton(
                                        context,
                                        selectedColorValue,
                                        ClotheList().color,
                                        "Select Color", (String? y) {
                                  selectedColorValue = y;
                                  myClothe1!.setColor(selectedColorValue!);
                                  clothesProvider.notifyListeners();
                                })),
                              ],
                            )),
                        AuthTextField(
                            controller: clotheNameController,
                            hintText: "Clothe Name ",
                            obscureText: false),
                        AuthTextField(
                            controller: clotheNoteController,
                            hintText: "Additional Note",
                            obscureText: false),
                        FloatingActionButton(
                            backgroundColor: CustomColors.kDarkBlue,
                            onPressed: () {
                              File? image = imageUploadProvider.selectedImage;
                              if (image != null) {
                                imageUploadProvider.uploadImageToStorage(image);
                              } else {
                                print('No image selected!');
                              }
                              myClothe1!.setClotheID();
                              myClothe1!.setName(clotheNameController.text);
                              myClothe1!.setNotes(clotheNoteController.text);
                              clothesProvider
                                  .addClotheToFirebase(screenClothe!);
                            },
                            child: Icon(Icons.save, size: 32))
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
      ],
    );
  }
}
