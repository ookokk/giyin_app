import 'package:f6_bootcamp/src/view/wardrobe/add_clothe/clothe_upload_screen.dart';
import 'package:f6_bootcamp/src/view/wardrobe/categories_wardrobe_screen.dart';
import 'package:f6_bootcamp/src/view/wardrobe/create_combin/create_combin_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';

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
              return CreateCombinationScreen();
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
