import 'package:flutter/material.dart';
import 'package:roomates/API/firebase_api.dart';
import 'package:roomates/pages/home_page.dart';

import 'package:roomates/pages/splash_screen.dart';
import 'package:roomates/services/otp/phone.dart';
import 'package:roomates/services/otp/verify.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:roomates/pages/auth_page.dart';
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FireBaseApi().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash', // Set an initial route
      routes: {
        'splash': (context) =>
            SplashScreen(), // Define your authentication page
        'auth': (context) => AuthPage(), // Define your authentication page
        'verify': (context) => MyVerify(),
        'phone': (context) => MyPhone(), // Define your verification page
        'home': (context) => HomePage(), // Define your verification page
        // ... other routes ...
      },
    );
  }
}
