import 'package:flutter/material.dart';
import '../models/wardrobe/clothes/my_clothe1.dart';
import '../view/auth/auth_screen.dart';
import '../view/auth/forgot_password_screen.dart';
import '../view/auth/login_screen.dart';
import '../view/auth/register_screen.dart';
import '../view/calendar/calendar_screen.dart';
import '../view/onboarding/onboarding_screen.dart';
import '../view/wardrobe/add_clothe/add_clothe_screen.dart';
import '../view/wardrobe/combination/create_combination_screen.dart';
import '../view/wardrobe/wardrobe_screen.dart';
import '../view/home/home_screen.dart';
import '../view/wardrobe/combination/my_combinations_screen.dart';
import '../view/weather/weather_screen.dart';

final Map<String, WidgetBuilder> routes = {
  //AUTH
  '/onboarding': (context) => const OnboardingScreen(),
  '/login': (context) => LoginScreen(),
  '/register': (context) => RegisterScreen(),
  '/forgotPassword': (context) => ForgotPasswordScreen(),
  '/auth': (context) => const AuthScreen(),

  '/home': (context) => const HomeScreen(),
  //GARDROP
  '/gardrop': (context) => const WardrobeScreen(),
  '/combinations': (context) => const MyCombinationsScreen(),
  //CREATE CLOTHE
  '/addClothe': (context) => AddClotheScreen(screenClothe: myClothe1),
  '/createCombination': (context) => const CreateCombinationScreen(),
  '/calendar': (context) => const CalendarScreen(),
  '/weather': (context) => const WeatherScreen(),
};
