import 'package:flutter/material.dart';
import 'package:giyin/src/constants/text_style.dart';
import '../../constants/color.dart';
import '../../service/auth/auth_provider.dart';

class MyNavigationDrawer extends StatelessWidget {
  MyNavigationDrawer({Key? key}) : super(key: key);
  final AuthProvider authProvider = AuthProvider();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 100,
      width: MediaQuery.of(context).size.width * 0.75,
      backgroundColor: CustomColors.kKoyuBeyazBG,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(
                child: Align(
              alignment: Alignment.topCenter,
              child: buildMenuItems(context),
            )),
            Expanded(
              child: Align(
                child: buildSignOut(context),
                alignment: Alignment.bottomLeft,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildMenuItems(BuildContext context) => Column(
        children: [
          const SizedBox(height: 16),
          buildDrawerListTileCard(
              context, "assets/icons/clothes.png", "Add Clothe", () {
            Navigator.pushNamed(context, '/addClothe');
          }),
          const SizedBox(height: 16),
          buildDrawerListTileCard(
            context,
            "assets/icons/closet.png",
            "My Combinations",
            () {
              Navigator.pushNamed(context, '/combinations');
            },
          ),
          const SizedBox(height: 16),
          buildDrawerListTileCard(context,
              "assets/icons/create_combination.png", "Create Combination", () {
            Navigator.pushNamed(context, '/createCombination');
          }),
        ],
      );

  Flexible buildDrawerListTileCard(BuildContext context, String image,
      String text, final Function()? onTap) {
    return Flexible(
      flex: 1,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: const BorderSide(color: CustomColors.kKoyuBeyazBG, width: 1),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          leading: SizedBox(
            width: 50,
            child: Image.asset(
              image,
              height: 50,
            ),
          ),
          title: Text(
            text,
            style: kMediumText,
          ),
          onTap: onTap,
        ),
      ),
    );
  }

  Widget buildSignOut(BuildContext context) => ListTile(
        leading: const Icon(
          Icons.logout,
          color: Colors.black,
          size: 45,
        ),
        title: Text(
          "Sign Out",
          style: kMediumLargeBText,
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  "Sign Out",
                  style: kMediumLargeBText,
                ),
                content: Text(
                  "Do you really want to log out?",
                  style: kMediumText,
                ),
                actions: [
                  TextButton(
                    child: Text("No", style: kMediumText),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    child: Text("Yes", style: kMediumText),
                    onPressed: () {
                      Navigator.pop(context);
                      authProvider.signUserOut();
                    },
                  ),
                ],
              );
            },
          );
        },
      );
}
