import 'package:f6_bootcamp/src/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

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
      backgroundColor: Colors.grey,
      selectedItemColor: Colors.white,
      unselectedItemColor: CustomColors.kBeige,
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
            icon: Icon(Icons.house, size: 46, color: Colors.black),
            label: 'Home'),
        BottomNavigationBarItem(
            icon: Image.asset("assets/icons/plus.png", width: 45),
            label: 'Add Clothe'),
        BottomNavigationBarItem(
            icon: Image.asset("assets/icons/weather.png", width: 45),
            label: 'Weather'),
        BottomNavigationBarItem(
            icon: Image.asset("assets/icons/color_break.png", width: 55),
            label: 'Create Combination'),
      ],
    );
  }
}
