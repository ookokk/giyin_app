import 'package:f6_bootcamp/src/models/wardrobe/clothes/tab_bar_provider.dart';
import 'package:f6_bootcamp/src/view/auth/auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/constants/routes.dart';
import 'src/service/firebase_options.dart';
import 'src/service/wardrobe/add_clothe/image_upload_provider.dart';
import 'src/service/weather/weather_provider.dart';
import 'src/service/calendar/calendar_provider.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WeatherProvider()),
        ChangeNotifierProvider(create: (context) => CalendarProvider()),
        ChangeNotifierProvider(create: (context) => ImageUploadProvider()),
        //kullanıcı hatalı giriş yapma durumlarını kontrol et
      ],
      child: MaterialApp(
        routes: routes,
        debugShowCheckedModeBanner: false,
        home: AuthScreen(),
      ),
    );
  }
}
