import 'package:flutter/material.dart';

import '../color.dart';

class UploadPhotoButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? text;
  final TextStyle? textStyle;

  const UploadPhotoButton({
    required this.onPressed,
    this.text,
    this.textStyle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: CustomColors.kMorGibi,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      child: Text(
        text!,
        style: textStyle,
      ),
    );
  }
}
