import 'package:f6_bootcamp/src/view/calendar/calendar_screen.dart';
import 'package:f6_bootcamp/src/view/weather/weather_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/service/firebase_options.dart';
import 'src/service/weather/weather_data.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherData(),
      child: const MaterialApp(
          debugShowCheckedModeBanner: false, home: CalendarScreen()),
    );
  }
}
