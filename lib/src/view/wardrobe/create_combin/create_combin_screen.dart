import 'package:f6_bootcamp/src/service/wardrobe/add_clothe/image_upload_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/wardrobe/combination/combination.dart';

class CreateCombinationScreen extends StatelessWidget {
  CreateCombinationScreen({Key? key}) : super(key: key);
  List<String> screenSelectedClothes = [];
  Combination screenCombination = Combination();

  @override
  Widget build(BuildContext context) {
    return Consumer<ImageUploadProvider>(
      builder: (context, imageUploadProvider, _) {
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {
                      imageUploadProvider.getUserClothes();
                    },
                    icon: const Icon(Icons.refresh),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemCount: imageUploadProvider.clothes.length,
                    itemBuilder: (context, index) {
                      final imageUrl = imageUploadProvider.clothes[index];
                      final isSelected = imageUploadProvider.isSelected;

                      return GestureDetector(
                        onTap: () {
                          imageUploadProvider.toggleSelection(index);
                          if (imageUploadProvider.isSelected()) {
                            screenSelectedClothes.add(imageUrl);
                          } else {
                            screenSelectedClothes.remove(imageUrl);
                          }
                        },
                        child: Stack(
                          children: [
                            Image.network(imageUrl),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Icon(
                                imageUploadProvider.isSelected()
                                    ? Icons.check_circle
                                    : Icons.check_circle_outline,
                                color: imageUploadProvider.isSelected()
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      /* imageUploadProvider
                          .createCombination(screenSelectedClothes);*/
                    },
                    child: Text('Kombin Oluştur'),
                  ),
                  IconButton(
                      onPressed: () {
                        print(screenSelectedClothes);
                      },
                      icon: Icon(Icons.add))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
