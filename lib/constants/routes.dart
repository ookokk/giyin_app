import 'package:flutter/material.dart';

import '../view/calendar_screen.dart';
import '../view/gardrop_screen.dart';
import '../view/home_screen.dart';
import '../view/login_screen.dart';
import '../view/register_screen.dart';
import '../view/splash_screen.dart';
import '../view/weather_screen.dart';

final Map<String, WidgetBuilder> routes = {
  '/splash': (context) => const SplashScreen(),
  '/login': (context) => const LoginScreen(),
  '/register': (context) => const RegisterScreen(),
  '/home': (context) => const HomeScreen(),
  '/gardrop': (context) => const GardropScreen(),
  '/calendar': (context) => const CalendarScreen(),
  '/weather': (context) => const WeatherScreen(),
};
