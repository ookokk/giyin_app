// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import '../../constants/color.dart';
import '../../models/wardrobe/clothes/my_clothe1.dart';
import '../../service/auth/auth_provider.dart';
import '../../widgets/custom_botom_navigation_bar.dart';
import '../../widgets/home/my_navigation_drawer.dart';
import '../calendar/calendar_screen.dart';
import '../wardrobe/add_clothe/clothe_upload_screen.dart';
import '../weather/weather_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
    const WeatherScreen(),
    const CalendarScreen(),
  ];

  void onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: MyNavigationDrawer(),
      /*floatingActionButton: FloatingActionButton(
            onPressed: () {
              authProvider.signUserOut();
            },
          ),*/
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: CustomColors.kMaviAcik,
          leading: Builder(
            builder: (BuildContext context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(Icons.menu)),
          )),
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        onItemSelected: onItemSelected,
      ),
    ));
  }
}
