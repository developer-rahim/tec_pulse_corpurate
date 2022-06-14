import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tacpulse/screens/dashboard_screen.dart';
import 'package:tacpulse/screens/login_screen.dart';
import 'package:tacpulse/screens/signup_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  var storage = FlutterSecureStorage();
  String? _token;

  getToken() async {
    String? token = await storage.read(key: 'token');
    setState(() {
      _token = token;
    });
  }

  @override
  void initState() {
    getToken();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        PageTransition(
          child: _token == null ? SignupScreen() : DashboardScreen(),
          type: PageTransitionType.bottomToTop,
          duration: Duration(milliseconds: 400),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        body: Center(
          child: Image.asset(
            'images/logo.png',
            width: 220,
            height: 220,
          ),
        ),
      ),
    );
  }
}
