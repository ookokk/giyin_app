import 'package:f6_bootcamp/src/view/wardrobe/add_clothe/clothe_upload_screen.dart';
import 'package:f6_bootcamp/src/widgets/custom_botom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/wardrobe/clothes/my_clothe1.dart';
import 'wardrobe/create_combin/create_combin_screen.dart';
import 'weather/weather_screen.dart';

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

  final List<Widget> _pages = [
    Container(), // Boş bir Container kullanarak örnek sayfaları temsil ediyoruz.
    ClotheUploadScreen(screenClothe: myClothe1),
    const WeatherScreen(),
    CreateCombinationScreen(),
  ];

  void onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(onPressed: widget.logOut, icon: const Icon(Icons.logout))
        ],
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
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
