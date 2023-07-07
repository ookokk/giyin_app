import 'package:flutter/material.dart';

class OnboardingProvider with ChangeNotifier {
  bool _isOnboardingShown = false;

  bool get isOnboardingShown => _isOnboardingShown;

  void setOnboardingShown() {
    _isOnboardingShown = true;
    notifyListeners();
  }
}
