import 'package:f6_bootcamp/src/view/screens/weather_page.dart';
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
          debugShowCheckedModeBanner: false, home: WeatherPage()),
    );
  }
}
