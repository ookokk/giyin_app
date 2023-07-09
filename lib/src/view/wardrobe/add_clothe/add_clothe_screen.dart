// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';
import '../../../constants/auth_components/auth_textfield.dart';
import '../../../constants/color.dart';
import '../../../constants/default_padding.dart';
import '../../../constants/text_style.dart';
import '../../../constants/wardrobe/upload_photo_button.dart';
import '../../../models/wardrobe/clothes/clothe_list.dart';
import '../../../models/wardrobe/clothes/clothes.dart';
import '../../../models/wardrobe/clothes/my_clothe1.dart';
import '../../../service/wardrobe/add_clothe/image_upload_provider.dart';
import '../../../service/wardrobe/clothes_provider.dart';
import '../../../widgets/wardrobe/string_dropdown_button.dart';

class AddClotheScreen extends StatelessWidget {
  AddClotheScreen({Key? key, this.screenClothe, this.userUid})
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
                title: Text(
                  "Add Clothe",
                  style: kMediumBeyazText,
                ),
                backgroundColor: CustomColors.kMaviAcik,
              ),
              backgroundColor: CustomColors.kKoyuBeyazBG,
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
                        const SizedBox(height: 18),
                        MultiSelectChipField<String?>(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(24),
                            color: Colors.grey.shade300,
                          ),
                          headerColor: CustomColors.kGrimsi,
                          title: Text("Select Season", style: kMediumText),
                          textStyle: kSmallText,
                          items: ClotheList()
                                  .season
                                  ?.map((e) => MultiSelectItem(e, e))
                                  .toList() ??
                              [],
                          onTap: (List<String?> values) {
                            for (var value in values) {
                              if (value != null) {
                                selectedSeasonsList.add(value);
                                myClothe1!.setSeason(value);
                                clothesProvider.notifyListeners();
                              }
                            }
                          },
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          margin: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Expanded(
                                  child: stringDropdownButton(
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
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          margin: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Expanded(
                                  child: stringDropdownButton(
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
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          margin: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Expanded(
                                  child: stringDropdownButton(
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
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            margin: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Expanded(
                                    child: stringDropdownButton(
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
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            margin: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Expanded(
                                    child: stringDropdownButton(
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
                        const SizedBox(height: 16),
                        AuthTextField(
                            controller: clotheNameController,
                            hintText: "Clothe Name ",
                            obscureText: false),
                        const SizedBox(height: 8),
                        AuthTextField(
                            controller: clotheNoteController,
                            hintText: "Additional Note",
                            obscureText: false),
                        const SizedBox(height: 8),
                        ElevatedButton(
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all<Size>(
                                  const Size(50, 50)),
                              maximumSize: MaterialStateProperty.all<Size>(
                                  const Size(250, 170)),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                const StadiumBorder(),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  CustomColors.kLightBlue),
                            ),
                            onPressed: () {
                              File? image = imageUploadProvider.selectedImage;
                              if (image != null) {
                                imageUploadProvider.uploadImageToStorage(image);
                              }
                              myClothe1!.setClotheID();
                              myClothe1!.setName(clotheNameController.text);
                              myClothe1!.setNotes(clotheNoteController.text);
                              clothesProvider
                                  .addClotheToFirebase(screenClothe!);
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text(
                                          'Success',
                                          style: kMediumText,
                                        ),
                                        content: Text(
                                          'Clothe saved successfully.',
                                          style: kSmallText,
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(
                                                  context); // Close the dialog
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ));
                            },
                            child: Row(children: [
                              Expanded(
                                child: Text(
                                  "Save Clothe",
                                  style: kMediumText,
                                ),
                              ),
                              const Icon(
                                Icons.save,
                                color: Colors.black,
                              )
                            ]))
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
            textStyle: kSmallBlackText,
            onPressed: () {
              imageUploadProvider.pickImage(ImageSource.gallery);
            },
            text: "Select Photo",
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: UploadPhotoButton(
            textStyle: kSmallBlackText,
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
