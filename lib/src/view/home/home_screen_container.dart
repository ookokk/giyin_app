// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:giyin/src/widgets/home/my_home_clipper.dart';
import 'dart:math';
import '../../constants/color.dart';
import '../../widgets/home/build_circular_positioned_button.dart';

class HomeScreenContainer extends StatelessWidget {
  HomeScreenContainer({Key? key}) : super(key: key);
  double sinX = 2 * pi * 0 / 8;
  @override
  Widget build(BuildContext context) {
    double myWidth = MediaQuery.of(context).size.width;
    double myHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: myWidth,
        height: myHeight,
        color: CustomColors.kKoyuBeyazBG,
        child: ClipOval(
          clipper: MyHomeClipper(ovality: 1),
          child: Container(
            color: Colors.white,
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipOval(
                  child: Image.asset(
                    "assets/icons/giyin_logo.png",
                    height: myHeight * 0.23,
                  ),
                ),
                buildCircularPositionedButton(myHeight * 0.52, myHeight * 0.17,
                    myWidth * 0.1, myWidth * 0.1, () {
                  Navigator.pushNamed(context, '/combinations');
                }, "assets/icons/closet.png"),
                buildCircularPositionedButton(myHeight * 0.1, myHeight * 0.45,
                    myWidth * 0.4, myWidth * 0.4, () {
                  Navigator.pushNamed(context, '/addClothe');
                }, "assets/icons/clothes.png"),
                buildCircularPositionedButton(myHeight * 0.1, myHeight * 0.1,
                    myWidth * 0.75, myWidth * 0.05, () {
                  Navigator.pushNamed(context, '/createCombination');
                }, "assets/icons/create_combination.png"),
                buildCircularPositionedButton(
                    myHeight * 0.1,
                    myHeight * 0.1,
                    myWidth * 0.05,
                    myWidth * 0.75,
                    () {},
                    "assets/icons/star.png"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
