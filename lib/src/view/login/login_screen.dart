import 'package:f6_bootcamp/src/constants/default_padding.dart';
import 'package:f6_bootcamp/src/constants/text_style.dart';
import 'package:f6_bootcamp/src/service/auth/sign_in_with_google.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants/auth_components/auth_screen_button.dart';
import '../../constants/auth_components/auth_textfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({
    super.key,
  });

  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
  }

  //log out user
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Padding(
          padding: kDefaultPadding,
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),

                  // logo
                  Image.asset(
                    "assets/icons/giyin_logo.png",
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),

                  const SizedBox(height: 24),

                  // wee happy to see you again
                  Text('We happy to see you again.', style: kMediumText),

                  const SizedBox(height: 25),

                  // username textfield
                  AuthTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  // password textfield
                  AuthTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),

                  const SizedBox(height: 10),

                  // forgot password?
                  buildForgotPasswordRow(context),

                  const SizedBox(height: 25),

                  // sign in button
                  AuthScreenButton(
                    buttonText: "Sign In",
                    onTap: signUserIn,
                  ),

                  const SizedBox(height: 26),

                  // or continue with
                  buildOrContinueWithDivider(),

                  const SizedBox(height: 26),

                  // google + apple sign in buttons
                  buildLoginWithGoogleButton(context),

                  const SizedBox(height: 20),

                  // not a member? register now
                  buildRegisterNowRow(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row buildRegisterNowRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Not a member?',
          style: kSmallText,
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/register');
          },
          child: Text(
            'Register now',
            style: kSmallBlueText,
          ),
        ),
      ],
    );
  }

  Padding buildOrContinueWithDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              thickness: 0.5,
              color: Colors.grey[400],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              'Or continue with',
              style: kSmallText,
            ),
          ),
          Expanded(
            child: Divider(
              thickness: 0.5,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  Padding buildForgotPasswordRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/forgotPassword');
            },
            child: Text(
              'Forgot Password?',
              style: kSmallBlueText,
            ),
          ),
        ],
      ),
    );
  }

  Row buildLoginWithGoogleButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // google button
        GestureDetector(
          onTap: () => GoogleAuthService().signInWithGoogle(),
          child: Container(
              padding: const EdgeInsets.all(25),
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Image.asset(
                    "assets/icons/google.png",
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  const SizedBox(width: 20),
                  Text(
                    "Login with Google",
                    style: kSmallText,
                  )
                ],
              )),
        ),
      ],
    );
  }
}
