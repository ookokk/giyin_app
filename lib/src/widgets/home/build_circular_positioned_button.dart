import 'package:flutter/material.dart';

Positioned buildCircularPositionedButton(
  double? bottom,
  double? top,
  double? right,
  double? left,
  final Function()? onTap,
  String imagePath,
) {
  return Positioned(
    bottom: bottom,
    top: top,
    right: right,
    left: left,
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(140, 50),
        maximumSize: const Size(140, 50),
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(5),
        shadowColor: Colors.black,
      ),
      child: Image.asset(imagePath),
    ),
  );
}
