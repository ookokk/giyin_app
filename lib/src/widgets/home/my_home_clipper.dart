import 'package:flutter/cupertino.dart';

class MyHomeClipper extends CustomClipper<Rect> {
  final double ovality;

  MyHomeClipper({this.ovality = 1.0});

  @override
  Rect getClip(Size size) {
    return Rect.fromCenter(
      center: size.center(Offset.zero),
      width: 380,
      height: 380,
    );
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
