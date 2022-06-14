import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tacpulse/screens/account_settings_screen.dart';
import 'package:tacpulse/screens/dashboard_screen.dart';
import 'package:tacpulse/screens/departed_screen.dart';
import 'package:tacpulse/screens/login_screen.dart';
import 'package:tacpulse/screens/profile_screen.dart';

class AuthService {
  Future userLogin(
      String username, String password, BuildContext context) async {
    Map data = {'username': username, 'password': password};
    var jsonData;
    var response = await http
        .post(Uri.parse('https://tacpulse.animo-ai.co/api/login/'), body: data);
    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);
      var storage = FlutterSecureStorage();
      await storage.write(key: 'token', value: jsonData['token']);
      await storage.write(key: 'username', value: username);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => DashboardScreen(),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text(
            'ERROR!',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            response.reasonPhrase.toString(),
            style: GoogleFonts.inter(
              color: Colors.black45,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Retry',
                style: GoogleFonts.inter(),
              ),
            ),
          ],
        ),
      );
    }
  }

  Future userSignOut() async {
    var storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    var response = await http.post(
        Uri.parse('https://tacpulse.animo-ai.co/api/logout/'),
        headers: {"Authorization": 'Token ' + token!});
    if (response.statusCode == 204) {
      print('Logged Out');
      await storage.delete(key: 'token');
    }
  }

  Future userSignUp(
      String username,
      String password,
      String password1,
      String firstName,
      String lastName,
      String contact,
      String address,
      String profilePicPath,
      BuildContext context) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://tacpulse.animo-ai.co/api/register/'));
    request.fields['username'] = username;
    request.fields['password'] = password;
    request.fields['password1'] = password1;
    request.fields['first_name'] = firstName;
    request.fields['last_name'] = lastName;
    request.fields['address'] = address;
    request.fields['contact'] = contact;
    request.fields['is_staff'] = "true";
    // request.fields['is_staff'] = "flase";
    request.files
        .add(await http.MultipartFile.fromPath("profile_pic", profilePicPath));
    request.send().then((response) {
      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'SUCCESS!',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Text(
                'Your account has been created',
                style: GoogleFonts.inter(
                  fontSize: 14,
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LoginScreen(),
                      ),
                    );
                  },
                  child: Text('Okay'),
                )
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'FAILED',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Text(
                'Please try again',
                style: GoogleFonts.inter(
                  fontSize: 14,
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Retry'),
                )
              ],
            );
          },
        );
      }
    });
  }
}
