import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:giyin/src/constants/text_style.dart';

class AuthProvider with ChangeNotifier {
  String _token = '';

  String get token => _token;

  set token(String value) {
    _token = value;
    notifyListeners();
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  Future<String?> signUserIn(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      String firebaseToken = await userCredential.user?.getIdToken() ?? '';

      _token = firebaseToken;
      return null;
    } catch (error) {
      return error.toString();
    }
  }

  void signUp(BuildContext context, String email, String password,
      bool isPasswordConfirmed) async {
    if (!isPasswordConfirmed) {
      showAlert(context, "Passwords not matching", "Error");
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      showAlert(context, "", "User created successfully ");
    }
  }

  void showAlert(BuildContext context, String message, String title) {
    final startIndex = message.indexOf(']') + 1;
    final cleanMessage = message.substring(startIndex).trim();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: kMediumText,
          ),
          content: Text(cleanMessage, style: kSmallBlackText),
          actions: [
            TextButton(
              child: Text(
                'Okay',
                style: kMediumText,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
