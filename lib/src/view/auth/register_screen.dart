import 'package:flutter/material.dart';
import '../../constants/auth_components/auth_textfield.dart';
import '../../constants/text_style.dart';
import '../../service/auth/auth_provider.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({
    Key? key,
  }) : super(key: key);

  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final AuthProvider authProvider = AuthProvider();

  bool passwordConfirmed() {
    return passwordController.text.trim() ==
        confirmPasswordController.text.trim();
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
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                Image.asset(
                  "assets/icons/giyin_logo.png",
                  height: MediaQuery.of(context).size.height * 0.18,
                ),

                const SizedBox(height: 50),

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
                //confirm password
                AuthTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // forgot password?

                const SizedBox(height: 25),

                // sign in button
                GestureDetector(
                  onTap: () {
                    authProvider.signUp(context, emailController.text.trim(),
                        passwordController.text.trim(), passwordConfirmed());
                  },
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        "Sign Up",
                        style: kMediumLargeWText,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 100),

                buildLoginNowRow(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildLoginNowRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'I am a member.',
          style: kSmallText,
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/login');
          },
          child: const Text(
            'Login now',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
