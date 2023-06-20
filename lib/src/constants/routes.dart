import 'package:flutter/material.dart';

import '../view/calendar/edit_combinations_screen.dart';
import '../view/login/forgot_password_screen.dart';
import '../view/wardrobe/wardrobe_screen.dart';
import '../view/home_screen.dart';
import '../view/login/login_screen.dart';
import '../view/login/register_screen.dart';
import '../view/splash/splash_screen.dart';
import '../view/weather/weather_screen.dart';

final Map<String, WidgetBuilder> routes = {
  //AUTH
  '/splash': (context) => const SplashScreen(),
  '/login': (context) => LoginScreen(),
  '/register': (context) => RegisterScreen(),
  '/forgotPassword': (context) => ForgotPasswordScreen(),

  '/home': (context) => HomeScreen(),
  //GARDROP
  '/gardrop': (context) => const WardrobeScreen(),
  '/calendar': (context) => EditCombinationsScreen(),
  //HAVA DURUMU
  '/weather': (context) => const WeatherScreen(),
};
