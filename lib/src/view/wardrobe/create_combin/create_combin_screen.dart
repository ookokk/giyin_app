// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:f6_bootcamp/src/constants/color.dart';
import 'package:f6_bootcamp/src/constants/text_style.dart';
import 'package:f6_bootcamp/src/models/wardrobe/combination/my_combination1.dart';
import 'package:f6_bootcamp/src/service/wardrobe/add_clothe/image_upload_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/wardrobe/combination/combination.dart';

class CreateCombinationScreen extends StatefulWidget {
  CreateCombinationScreen({Key? key}) : super(key: key);

  @override
  State<CreateCombinationScreen> createState() =>
      _CreateCombinationScreenState();
}

class _CreateCombinationScreenState extends State<CreateCombinationScreen> {
  Combination screenCombination = Combination();
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final imageUploadProvider =
        Provider.of<ImageUploadProvider>(context, listen: false);
    imageUploadProvider.getUserClothes();
  }

  // Combination screenCombination = Combination();
  @override
  Widget build(BuildContext context) {
    return Consumer<ImageUploadProvider>(
      builder: (context, imageUploadProvider, _) {
        bool isSelected(String imageUrl) {
          return myCombination1.selectedClothedUrls!.contains(imageUrl);
        }

        DateTime myDate = DateTime.now();
        Future<void> selectDate(BuildContext context) async {
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime(2023),
          );

          if (picked != null) {
            dateController.text = picked.toString();
          }
        }

        void toggleSelection(String imageUrl) {
          if (myCombination1.selectedClothedUrls!.contains(imageUrl)) {
            myCombination1.selectedClothedUrls!.remove(imageUrl);
          } else {
            myCombination1.selectedClothedUrls!.add(imageUrl);
          }
          imageUploadProvider.notifyListeners();
        }

        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: imageUploadProvider.clothes.length,
                    itemBuilder: (context, index) {
                      final imageUrl = imageUploadProvider.clothes[index];

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: GestureDetector(
                            onTap: () {
                              toggleSelection(imageUrl);
                            },
                            child: Container(
                              color: CustomColors.kBeige,
                              child: Stack(
                                children: [
                                  Image.network(
                                    imageUrl,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    height: MediaQuery.of(context).size.height *
                                        0.4,
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Icon(
                                      isSelected(imageUrl)
                                          ? Icons.check_box
                                          : Icons.check_box_outline_blank,
                                      color: isSelected(imageUrl)
                                          ? Colors.green
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: myDate,
                          firstDate: DateTime(2022),
                          lastDate: DateTime(2030));
                      if (newDate == null) return;

                      setState(() => myDate = newDate);
                      myCombination1.setDateToWear(newDate);
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: CustomColors.kGrimsi),
                    child: Text(
                      "Select Date",
                      style: kMediumLargeWText,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      myCombination1.setId(DateTime.now().toString());
                      myCombination1.setCreatedDate(DateTime.now());
                      imageUploadProvider
                          .uploadCombinationToFirebase(myCombination1);
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: CustomColors.kGrimsi),
                    child: Text(
                      'Create Combination (${myCombination1.selectedClothedUrls!.length})',
                      style: kMediumLargeWText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
