import 'package:f6_bootcamp/src/models/wardrobe/clothes/my_clothe1.dart';
import 'package:f6_bootcamp/src/view/calendar/calendar_screen.dart';
import 'package:f6_bootcamp/src/view/wardrobe/add_clothe/clothe_upload_screen.dart';
import 'package:flutter/material.dart';

import '../view/auth/forgot_password_screen.dart';
import '../view/auth/login_screen.dart';
import '../view/auth/register_screen.dart';
import '../view/wardrobe/wardrobe_screen.dart';
import '../view/home_screen.dart';

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
  //CREATE CLOTHE
  '/clotheUpload': (context) => ClotheUploadScreen(screenClothe: myClothe1),

  //CALENDAR
  '/calendar': (context) => CalendarScreen(),
  //HAVA DURUMU
  '/weather': (context) => const WeatherScreen(),
};
