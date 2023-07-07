// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants/auth_components/auth_screen_button.dart';
import '../../constants/auth_components/auth_textfield.dart';
import '../../constants/default_padding.dart';
import '../../constants/text_style.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();

  Future passwordReset(BuildContext scaffoldContext) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      showDialog(
        context: scaffoldContext,
        builder: (scaffoldContext) => const AlertDialog(
          content: Text("Password reset link sent! Check your email"),
        ),
      );
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: scaffoldContext,
          builder: (scaffoldContext) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: kDefaultPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/icons/wrong-password.png",
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                Text("Forgot\n Password?", style: kXLargeText),
                const SizedBox(height: 26),
                Text(
                    "Don't worry! It happens.Please enter the address associated with your account.",
                    textAlign: TextAlign.center,
                    style: kSmallText),
                const SizedBox(height: 26),
                AuthTextField(
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false),
                const SizedBox(height: 26),
                AuthScreenButton(
                    buttonText: "Submit",
                    onTap: () {
                      passwordReset(context);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
