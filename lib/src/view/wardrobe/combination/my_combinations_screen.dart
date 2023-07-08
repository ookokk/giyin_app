import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../constants/color.dart';
import '../../../constants/default_padding.dart';
import '../../../constants/text_style.dart';
import '../../../models/wardrobe/combination/combination.dart';
import '../../../service/wardrobe/add_clothe/image_upload_provider.dart';

class MyCombinationsScreen extends StatelessWidget {
  const MyCombinationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ImageUploadProvider>(
      builder: (context, imageUploadProvider, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "My Combinations",
              style: kMediumBeyazText,
            ),
            backgroundColor: CustomColors.kMaviAcik,
          ),
          body: Padding(
            padding: kDefaultPadding,
            child: FutureBuilder<List<Combination>>(
              future: imageUploadProvider.getCombinationsFromFirebase(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                List<Combination> combinations = snapshot.data ?? [];

                return SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        buildMyCombinationsGridViewBuilder(combinations),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  GridView buildMyCombinationsGridViewBuilder(List<Combination> combinations) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: combinations.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        Combination combination = combinations[index];

        return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(
                  'Selected Clothes',
                  style: kMediumText,
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: combination.selectedClothedUrls!
                      .map((url) => Image.network(
                            url,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ))
                      .toList(),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                    },
                    child: Text('OK', style: kMediumText),
                  ),
                ],
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                // Display combination image or placeholder
                // Replace Image.network with your own implementation
                Image.network(
                  combination.selectedClothedUrls![0],
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                Text(
                  DateFormat('MMMM dd, yyyy').format(
                    combination.dateToWear!,
                  ),
                  style: kMediumText,
                ),
                // Display other combination details as desired
              ],
            ),
          ),
        );
      },
    );
  }
}
