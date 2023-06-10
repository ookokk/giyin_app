import 'package:flutter/material.dart';

import '../view/calendar/calendar_screen.dart';
import '../view/wardrobe/gardrop_screen.dart';
import '../view/home_screen.dart';
import '../view/login/login_screen.dart';
import '../view/login/register_screen.dart';
import '../view/splash/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  '/splash': (context) => const SplashScreen(),
  '/login': (context) => const LoginScreen(),
  '/register': (context) => const RegisterScreen(),
  '/home': (context) => const HomeScreen(),
  '/gardrop': (context) => const GardropScreen(),
  '/calendar': (context) => const CalendarScreen(),
};
