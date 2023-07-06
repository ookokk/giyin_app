import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

import '../constants/color.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final Function(int) onItemSelected;

  const CustomBottomNavigationBar({Key? key, required this.onItemSelected})
      : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int selectedItemPosition = 0;

  @override
  Widget build(BuildContext context) {
    return SnakeNavigationBar.color(
      backgroundColor: CustomColors.kMaviAcik,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      snakeShape: SnakeShape.rectangle,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(26), bottom: Radius.circular(26)),
      ),
      padding: const EdgeInsets.all(10),
      currentIndex: selectedItemPosition,
      onTap: (index) {
        setState(() {
          selectedItemPosition = index;
        });
        widget.onItemSelected(index);
      },
      items: [
        const BottomNavigationBarItem(
            icon: Icon(Icons.house, size: 46, color: Colors.white),
            label: 'Home'),
        BottomNavigationBarItem(
            icon: Image.asset("assets/icons/clothes.png", width: 45),
            label: 'Add Clothe'),
        BottomNavigationBarItem(
            icon: Image.asset("assets/images/sunny.png", width: 45),
            label: 'Weather'),
        const BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.calendar,
              size: 40,
            ),
            label: 'Calendar'),
      ],
    );
  }
}
