import 'package:Giyin/src/view/calendar/calendar_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants/color.dart';
import '../../models/wardrobe/clothes/my_clothe1.dart';
import '../../service/auth/auth_provider.dart';
import '../../widgets/custom_botom_navigation_bar.dart';
import '../wardrobe/add_clothe/clothe_upload_screen.dart';
import '../weather/weather_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final AuthProvider authProvider = AuthProvider();
  final List<Widget> _pages = [
    Center(
      child: Column(children: [
        Expanded(
          child: Image.asset(
            "assets/images/home_logo.png",
          ),
        )
      ]),
    ),
    ClotheUploadScreen(screenClothe: myClothe1),
    const WeatherScreen(),
    CalendarScreen(),
  ];

  void onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        /*onPressed: () {
          authProvider.signUserOut();
        },
      ),*/
      backgroundColor: CustomColors.kKoyuBeyazBG,
      appBar: AppBar(
        backgroundColor: CustomColors.kMaviAcik,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: _pages[_selectedIndex], // Seçilen sayfayı göster
      bottomNavigationBar: CustomBottomNavigationBar(
        onItemSelected: onItemSelected,
      ),
    );
  }
}
