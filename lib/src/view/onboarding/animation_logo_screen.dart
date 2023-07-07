// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, use_full_hex_values_for_flutter_colors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimationLogoScreen extends StatefulWidget {
  @override
  _AnimationLogoScreenState createState() => _AnimationLogoScreenState();
}

class _AnimationLogoScreenState extends State<AnimationLogoScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        Navigator.pushReplacementNamed(context, '/onboarding');
      } else {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd0e2954),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Animate(
              effects: const [
                RotateEffect(
                  curve: Curves.easeInOut,
                  duration: Duration(seconds: 3),
                  delay: Duration(seconds: 0),
                  begin: 0,
                  end: 2,
                ),
              ],
              child: Image.asset(
                'assets/icons/giyin_logo.png',
                height: MediaQuery.of(context).size.height * 0.15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
