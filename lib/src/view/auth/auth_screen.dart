import 'package:Giyin/src/view/auth/login_screen.dart';
import 'package:Giyin/src/view/wardrobe/combination/my_combinations_screen.dart';
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
              return MyCombinationsScreen();
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
