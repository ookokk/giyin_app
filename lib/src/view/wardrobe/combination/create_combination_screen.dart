// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/color.dart';
import '../../../constants/default_padding.dart';
import '../../../constants/text_style.dart';
import '../../../models/wardrobe/combination/combination.dart';
import '../../../models/wardrobe/combination/my_combination1.dart';
import '../../../service/wardrobe/add_clothe/image_upload_provider.dart';

class CreateCombinationScreen extends StatefulWidget {
  const CreateCombinationScreen({Key? key}) : super(key: key);

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
            appBar: AppBar(
              backgroundColor: CustomColors.kMaviAcik,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            backgroundColor: CustomColors.kKoyuBeyazBG,
            body: SingleChildScrollView(
              child: Padding(
                padding: kDefaultPadding,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 8,
                        ),
                        buildSelectDateButton(context, myDate),
                        const SizedBox(
                          width: 16,
                        ),
                        buildCreateCombinationButton(
                            imageUploadProvider, context),
                      ],
                    ),
                    buildUserClothesGridViewBuilder(
                        imageUploadProvider, toggleSelection, isSelected),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  GridView buildUserClothesGridViewBuilder(
      ImageUploadProvider imageUploadProvider,
      void Function(String imageUrl) toggleSelection,
      bool Function(String imageUrl) isSelected) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                color: Colors.white,
                child: Stack(
                  children: [
                    Image.network(
                      imageUrl,
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.4,
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Icon(
                        isSelected(imageUrl)
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color:
                            isSelected(imageUrl) ? Colors.green : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  ElevatedButton buildCreateCombinationButton(
    ImageUploadProvider imageUploadProvider,
    BuildContext context,
  ) {
    return ElevatedButton(
      onPressed: () {
        myCombination1.setId(DateTime.now().toString());
        myCombination1.setCreatedDate(DateTime.now());

        imageUploadProvider.uploadCombinationToFirebase(myCombination1);

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Success',
              style: kMediumText,
            ),
            content: Text(
              'Combination saved successfully.',
              style: kSmallText,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        maximumSize: Size(MediaQuery.of(context).size.width * 0.4, 300),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: CustomColors.kMaviAcik,
      ),
      child: Text(
        'Create Combine (${myCombination1.selectedClothedUrls!.length})',
        style: kMediumBeyazText,
      ),
    );
  }

  ElevatedButton buildSelectDateButton(BuildContext context, DateTime myDate) {
    return ElevatedButton(
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
          maximumSize: Size(MediaQuery.of(context).size.width * 0.4, 100),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: CustomColors.kMaviAcik),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Select Date",
              style: kMediumBeyazText,
            ),
          ),
          const Expanded(
              child: Icon(
            Icons.calendar_month,
            color: Colors.white,
            size: 35,
          ))
        ],
      ),
    );
  }
}
