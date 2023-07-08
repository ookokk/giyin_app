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
          Flexible(
            flex: 1,
            child: ListTile(
              leading: Image.asset(
                "assets/icons/clothes.png",
                height: 50,
              ),
              title: Text(
                "Add Clothe",
                style: kMediumText,
              ),
              onTap: () {
                Navigator.pushNamed(context, '/clotheUpload');
              },
            ),
          ),
          const SizedBox(height: 16),
          Flexible(
            flex: 1,
            child: ListTile(
              leading: Image.asset(
                "assets/icons/closet.png",
                height: 50,
              ),
              title: Text(
                "My Combinations",
                style: kMediumText,
              ),
              onTap: () {
                Navigator.pushNamed(context, '/combinations');
              },
            ),
          ),
          const SizedBox(height: 16),
          Flexible(
              flex: 1,
              child: ListTile(
                leading: Image.asset(
                  "assets/icons/create_combination.png",
                  height: 50,
                ),
                title: Text(
                  "Create Combination",
                  style: kMediumText,
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/createCombination');
                },
              )),
        ],
      );
  Widget buildSignOut(BuildContext context) => Container(
        child: ListTile(
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
                        Navigator.pop(context); // AlertDialog'ı kapat
                      },
                    ),
                    TextButton(
                      child: Text("Yes", style: kMediumText),
                      onPressed: () {
                        Navigator.pop(context); // AlertDialog'ı kapat
                        authProvider.signUserOut(); // Çıkış yap işlevi
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      );
}
