import 'package:f6_bootcamp/src/constants/auth_components/my_button.dart';
import 'package:f6_bootcamp/src/constants/auth_components/my_textfield.dart';
import 'package:f6_bootcamp/src/constants/default_padding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
        builder: (scaffoldContext) => AlertDialog(
          content: Text("Password reset link sent! Check your email"),
        ),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
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
  Widget build(BuildContext scaffoldContext) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(scaffoldContext);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: kDefaultPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Forgot\n Password?", style: kXLargeText),
                SizedBox(height: 26),
                Text(
                    "Don't worry! It happens.Please enter the address associated with your account.",
                    textAlign: TextAlign.center,
                    style: kSmallText),
                const SizedBox(height: 26),
                MyTextField(
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false),
                const SizedBox(height: 26),
                MyButton(
                    buttonText: "Submit",
                    onTap: () {
                      passwordReset(scaffoldContext);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
