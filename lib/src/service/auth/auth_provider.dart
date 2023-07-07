import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    String firebaseToken = await userCredential.user?.getIdToken() ?? '';

    _token = firebaseToken;
    return null;
  }
}
