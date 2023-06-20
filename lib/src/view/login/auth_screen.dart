import 'package:f6_bootcamp/src/view/home_screen.dart';
import 'package:f6_bootcamp/src/view/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: FirebaseAuth.instance.authStateChanges(),
      initialData: null,
      child: Scaffold(
        body: Consumer<User?>(
          builder: (context, user, _) {
            // User is logged in
            if (user != null) {
              return HomeScreen();
            }
            // User is not logged in
            else {
              return LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
