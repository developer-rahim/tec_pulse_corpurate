import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tacpulse/screens/dashboard_screen.dart';
import 'package:tacpulse/screens/signup_screen.dart';
import 'package:tacpulse/screens/welcome_screen.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TAC-Pulse ERS',
      theme: ThemeData(
        primaryColor: Color(0xffbe141a),
        colorScheme: ColorScheme.light(
          primary: Color(0xffbe141a),
          secondary: Colors.transparent,
        ),
        buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
        scaffoldBackgroundColor: Color(0xFFFFFFFF),
        // visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WelcomeScreen(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

//hello