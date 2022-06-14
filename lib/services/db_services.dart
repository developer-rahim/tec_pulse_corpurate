import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:tacpulse/models/assessment.dart';
import 'package:tacpulse/models/faq.dart';
import 'package:tacpulse/models/inspection_checklists.dart';
import 'package:tacpulse/models/message.dart';
import 'package:tacpulse/models/monthly_paystub.dart';
import 'package:tacpulse/models/notifications.dart';
import 'package:tacpulse/models/occurrence.dart';
import 'package:tacpulse/models/panic.dart';
import 'package:tacpulse/models/response.dart';
import 'package:tacpulse/models/scribe.dart';
import 'package:tacpulse/models/task.dart';
import 'package:tacpulse/models/user.dart';
import 'package:tacpulse/screens/arrived_to_hospital_screen.dart';
import 'package:tacpulse/screens/back_to_base_screen.dart';
import 'package:tacpulse/screens/confirm_new_password_screen.dart';
import 'package:tacpulse/screens/dashboard_screen.dart';
import 'package:tacpulse/screens/departed_screen.dart';
import 'package:tacpulse/screens/hand_over_screen.dart';
import 'package:tacpulse/screens/on_scene_screen.dart';
import 'package:tacpulse/screens/response_details_screen.dart';

class DbServices {
  Future resetPassword(String email, BuildContext context) async {
    Map data = {"email": email};
    var response = await http.post(
      Uri.parse('https://tacpulse.animo-ai.co/api/password_reset/'),
      body: data,
    );
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text(
            'SUCCESS!',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'An email response has been sent',
            style: GoogleFonts.inter(
              color: Colors.black45,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (_) => ConfirmNewPasswordScreen(),
                  ),
                );
              },
              child: Text(
                'Okay',
                style: GoogleFonts.inter(),
              ),
            ),
          ],
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
              onPressed: () {
                Navigator.pop(context);
              },
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

  Future confirmNewPassword(BuildContext context, String email,
      String newPassword, String token) async {
    Map data = {
      "email": email,
      "password": newPassword,
      "token": token,
    };
    var response = await http.post(
      Uri.parse(
        'https://tacpulse.animo-ai.co/api/password_reset/confirm/?token=' +
            token,
      ),
      body: data,
    );
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text(
            'SUCCESS!',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Password has been reset',
            style: GoogleFonts.inter(
              color: Colors.black45,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text(
                'Okay',
                style: GoogleFonts.inter(),
              ),
            ),
          ],
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
              onPressed: () {
                Navigator.pop(context);
              },
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

  Future changePassword(
      String oldPassword, String newPassword, BuildContext context) async {
    Map data = {"old_password": oldPassword, "new_password": newPassword};
    var storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    var response = await http.put(
      Uri.parse('https://tacpulse.animo-ai.co/api/change/password/'),
      headers: {"Authorization": 'Token ' + token!},
      body: data,
    );
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text(
            'SUCCESS!',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Password has been changed',
            style: GoogleFonts.inter(
              color: Colors.black45,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text(
                'Okay',
                style: GoogleFonts.inter(),
              ),
            ),
          ],
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
              onPressed: () {
                Navigator.pop(context);
              },
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

  Future<List<Assessment>> fetchAssessments() async {
    var storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    var response = await http.get(
      Uri.parse('https://tacpulse.animo-ai.co/api/assessments/list/'),
      headers: {
        "Authorization": 'Token ' + token!,
      },
    );
    if (response.statusCode == 200) {
      print(response);
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((data) => new Assessment.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load assessments');
    }
  }

  Future<List<Faq>> fetchFaqs() async {
    var storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    var response = await http.get(
        Uri.parse('https://tacpulse.animo-ai.co/api/faq/'),
        headers: {"Authorization": 'Token ' + token!});
    if (response.statusCode == 200) {
      List jsonData = jsonDecode(response.body);
      return jsonData.map((data) => new Faq.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load FAQs');
    }
  }

  Future<List<Task>> fetchTaskList() async {
    var storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    var response = await http.get(
        Uri.parse(
            'https://tacpulse.animo-ai.co/api/assigned/paramedics/tasks/'),
          
        headers: {
          "Authorization": 'Token ' + token!,
        });
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((data) => new Task.fromJson(data)).toList();
    } else {
      debugPrint(response.reasonPhrase);
      throw Exception('Failed to load tasks');
    }
  }

  Future<List<InspectionChecklists>> fetchInspectionChecklists() async {
    final response = await http.get(
        Uri.parse('https://tacpulse.animo-ai.co/api/inspection/checklist/'));
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse
          .map((data) => new InspectionChecklists.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load inspection checklists');
    }
  }

  Future<List<MonthlyPaystub>> fetchMonthlyPaystubs() async {
    final response = await http
        .get(Uri.parse('https://tacpulse.animo-ai.co/api/paystub/reports/'));
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse
          .map((data) => new MonthlyPaystub.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load paystubs');
    }
  }

  Future<List<Notifications>> fetchNotifications() async {
    var storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    var response = await http.get(
        Uri.parse('https://tacpulse.animo-ai.co/notification/panic/'),
        headers: {
          "Authorization": 'Token ' + token!,
        });
    if (response.statusCode == 200) {
      List jsonData = jsonDecode(response.body);
      return jsonData.map((data) => new Notifications.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load notifications');
    }
  }

  Future<List<Occurrence>> fetchOccurrenceReports() async {
    final response = await http
        .get(Uri.parse('https://tacpulse.animo-ai.co/api/occurrence/reports/'));
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((data) => new Occurrence.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load paystubs');
    }
  }

  Future<List<User>> getUserProfileData() async {
    var storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    final response = await http.get(
        Uri.parse('https://tacpulse.animo-ai.co/api/profile/'),
        headers: {"Authorization": 'Token ' + token!});
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((data) => new User.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load profile data');
    }
  }

  Future sendPanicRequest(
      BuildContext context,
      String panicSender,
      String emergencyContact,
      String reason,
      String place,
      String lat,
      String lng) async {
    Map data = {
      'panic_sender': panicSender,
      'emergency_contact': emergencyContact,
      'reason': reason,
      'place': place,
      'lat': lat,
      'lng': lng,
    };
    var storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    var response = await http.post(
      Uri.parse('https://tacpulse.animo-ai.co/api/panic/crerate/'),
      headers: {
        "Authorization": 'Token ' + token!,
      },
      body: data,
    );
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text(
            'SUCCESS',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Panic request sent!',
            style: GoogleFonts.inter(
              color: Colors.black45,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text(
                'Okay',
                style: GoogleFonts.inter(),
              ),
            ),
          ],
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
              onPressed: () {
                Navigator.pop(context);
              },
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

  Future<List<Panic>> fetchPanicList() async {
    var storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    var response = await http.get(
        Uri.parse('https://tacpulse.animo-ai.co/api/panic/list/'),
        headers: {
          "Authorization": 'Token ' + token!,
        });
    if (response.statusCode == 200) {
      List jsonData = jsonDecode(response.body);
      return jsonData.map((data) => new Panic.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load panic list');
    }
  }

  Future updateAddress(BuildContext context, String address) async {
    Map data = {
      "address": address,
    };
    var storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    var response = await http.put(
      Uri.parse('https://tacpulse.animo-ai.co/api/profile/update/'),
      headers: {
        "Authorization": 'Token ' + token!,
      },
      body: data,
    );
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text(
            'SUCCESS',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Address changed successfully',
            style: GoogleFonts.inter(
              color: Colors.black45,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text(
                'Okay',
                style: GoogleFonts.inter(),
              ),
            ),
          ],
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
              onPressed: () {
                Navigator.pop(context);
              },
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

  Future updateBio(BuildContext context, String bio) async {
    Map data = {
      "quote": bio,
    };
    var storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    var response = await http.put(
      Uri.parse('https://tacpulse.animo-ai.co/api/profile/update/'),
      headers: {
        "Authorization": 'Token ' + token!,
      },
      body: data,
    );
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text(
            'SUCCESS',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Bio changed successfully',
            style: GoogleFonts.inter(
              color: Colors.black45,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text(
                'Okay',
                style: GoogleFonts.inter(),
              ),
            ),
          ],
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
              onPressed: () {
                Navigator.pop(context);
              },
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

  Future updateContact(BuildContext context, String contact) async {
    Map data = {
      "contact": contact,
    };
    var storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    var response = await http.put(
      Uri.parse('https://tacpulse.animo-ai.co/api/profile/update/'),
      headers: {
        "Authorization": 'Token ' + token!,
      },
      body: data,
    );
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text(
            'SUCCESS',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Contact changed successfully',
            style: GoogleFonts.inter(
              color: Colors.black45,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text(
                'Okay',
                style: GoogleFonts.inter(),
              ),
            ),
          ],
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
              onPressed: () {
                Navigator.pop(context);
              },
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

  Future updateEmail(BuildContext context, String email) async {
    Map data = {
      "username": email,
    };
    var storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    var response = await http.put(
      Uri.parse('https://tacpulse.animo-ai.co/api/profile/update/'),
      headers: {
        "Authorization": 'Token ' + token!,
      },
      body: data,
    );
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text(
            'SUCCESS',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Email changed successfully',
            style: GoogleFonts.inter(
              color: Colors.black45,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text(
                'Okay',
                style: GoogleFonts.inter(),
              ),
            ),
          ],
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
              onPressed: () {
                Navigator.pop(context);
              },
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

  Future updateName(
      BuildContext context, String firstName, String lastName) async {
    Map data = {
      "first_name": firstName,
      "last_name": lastName,
    };
    var storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    var response = await http.put(
      Uri.parse('https://tacpulse.animo-ai.co/api/profile/update/'),
      headers: {
        "Authorization": 'Token ' + token!,
      },
      body: data,
    );
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'SUCCESS',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Name changed successfully',
            style: GoogleFonts.inter(
              color: Colors.black87,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text(
                'Okay',
                style: GoogleFonts.inter(),
              ),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'ERROR!',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            response.reasonPhrase.toString(),
            style: GoogleFonts.inter(
              color: Colors.black87,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
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

  Future<List<Response>> fetchResponseDetails() async {
    var storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    final response = await http.get(
      Uri.parse('https://tacpulse.animo-ai.co/api/paramedic/reports/list/'),
      headers: {
        'Authorization': 'Token ' + token!,
      },
    );
    if (response.statusCode == 200) {
      List jsonData = jsonDecode(response.body);
      return jsonData.map((data) => Response.fromJson(data)).toList();
    } else {
      throw Exception('Could not load list of responses');
    }
  }

  Future respondToTask({
    BuildContext? context,
    Task? task,
    String? parent,
    String? forCrew,
    String? medicLoc,
    String? targetLoc,
    String? actionTime,
    String? odo,
    String? dis,
    String? dur,
  }) async {
    Map data = {
      'parent': parent,
      'for_crew': forCrew,
      'status': 'Respond',
      'medic_loc': medicLoc,
      'target_loc': targetLoc,
      'action_time': actionTime,
      'odo': odo,
      'dis': dis,
      'dur': dur,
    };
    var storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    final response = await http.post(
      Uri.parse('https://tacpulse.animo-ai.co/api/paramedic/phases/update/'),
      body: data,
      headers: {
        'Authorization': 'Token ' + token!,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      showDialog(
        context: context!,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'SUCCESS',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'You are now responding to this case',
            style: GoogleFonts.inter(
              color: Colors.black87,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (_) => ResponseDetailsScreen(task: task),
                  ),
                );
              },
              child: Text(
                'Okay',
                style: GoogleFonts.inter(),
              ),
            ),
          ],
        ),
      );
    } else if (response.statusCode == 208) {
      showDialog(
        context: context!,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'ERROR',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'You have already responded to this case',
            style: GoogleFonts.inter(
              color: Colors.black87,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (_) => ResponseDetailsScreen(task: task),
                  ),
                );
              },
              child: Text(
                'Okay',
                style: GoogleFonts.inter(),
              ),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context!,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'ERROR!',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            response.reasonPhrase.toString(),
            style: GoogleFonts.inter(
              color: Colors.black87,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
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

  Future updateStatusToOnScene({
    BuildContext? context,
    Task? task,
    String? parent,
    String? forCrew,
    String? medicLoc,
    String? targetLoc,
    String? actionTime,
    String? odo,
    String? dis,
    String? dur,
  }) async {
    Map data = {
      'parent': parent,
      'for_crew': forCrew,
      'status': 'On-Scene',
      'medic_loc': medicLoc,
      'target_loc': targetLoc,
      'action_time': actionTime,
      'odo': odo,
      'dis': dis,
      'dur': dur,
    };
    var storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    final response = await http.post(
      Uri.parse('https://tacpulse.animo-ai.co/api/paramedic/phases/update/'),
      body: data,
      headers: {
        'Authorization': 'Token ' + token!,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      showDialog(
        context: context!,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'SUCCESS',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Status updated to On-Scene',
            style: GoogleFonts.inter(
              color: Colors.black87,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (_) => OnSceneScreen(task: task),
                  ),
                );
              },
              child: Text(
                'Okay',
                style: GoogleFonts.inter(),
              ),
            ),
          ],
        ),
      );
    } else if (response.statusCode == 208) {
      showDialog(
        context: context!,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'ERROR',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'You have already been on scene',
            style: GoogleFonts.inter(
              color: Colors.black87,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (_) => OnSceneScreen(task: task),
                  ),
                );
              },
              child: Text(
                'Okay',
                style: GoogleFonts.inter(),
              ),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context!,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'ERROR!',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            response.reasonPhrase.toString(),
            style: GoogleFonts.inter(
              color: Colors.black87,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
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

  Future updateStatusToDepartsScene({
    BuildContext? context,
    Task? task,
    String? parent,
    String? forCrew,
    String? medicLoc,
    String? targetLoc,
    String? actionTime,
    String? odo,
    String? dis,
    String? dur,
  }) async {
    Map data = {
      'parent': parent,
      'for_crew': forCrew,
      'status': 'Departs-Scene',
      'medic_loc': medicLoc,
      'target_loc': targetLoc,
      'action_time': actionTime,
      'odo': odo,
      'dis': dis,
      'dur': dur,
    };
    var storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    final response = await http.post(
      Uri.parse('https://tacpulse.animo-ai.co/api/paramedic/phases/update/'),
      body: data,
      headers: {
        'Authorization': 'Token ' + token!,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      showDialog(
        context: context!,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'SUCCESS',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Status updated to Departed',
            style: GoogleFonts.inter(
              color: Colors.black87,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (_) => DepartedScreen(task: task),
                  ),
                );
              },
              child: Text(
                'Okay',
                style: GoogleFonts.inter(),
              ),
            ),
          ],
        ),
      );
    } else if (response.statusCode == 208) {
      showDialog(
        context: context!,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'ERROR',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'You have already departed scene',
            style: GoogleFonts.inter(
              color: Colors.black87,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (_) => DepartedScreen(task: task),
                  ),
                );
              },
              child: Text(
                'Okay',
                style: GoogleFonts.inter(),
              ),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context!,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'ERROR!',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            response.reasonPhrase.toString(),
            style: GoogleFonts.inter(
              color: Colors.black87,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
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

  Future updateStatusToArrivesHospital({
    BuildContext? context,
    Task? task,
    String? parent,
    String? forCrew,
    String? medicLoc,
    String? targetLoc,
    String? actionTime,
    String? odo,
    String? dis,
    String? dur,
  }) async {
    Map data = {
      'parent': parent,
      'for_crew': forCrew,
      'status': 'Arrives-Hospital',
      'medic_loc': medicLoc,
      'target_loc': targetLoc,
      'action_time': actionTime,
      'odo': odo,
      'dis': dis,
      'dur': dur,
    };
    var storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    final response = await http.post(
      Uri.parse('https://tacpulse.animo-ai.co/api/paramedic/phases/update/'),
      body: data,
      headers: {
        'Authorization': 'Token ' + token!,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      showDialog(
        context: context!,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'SUCCESS',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Status updated to Arrived at Hospital',
            style: GoogleFonts.inter(
              color: Colors.black87,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (_) => ArriveToHospitalScreen(task: task),
                  ),
                );
              },
              child: Text(
                'Okay',
                style: GoogleFonts.inter(),
              ),
            ),
          ],
        ),
      );
    } else if (response.statusCode == 208) {
      showDialog(
        context: context!,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'ERROR',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'You have already arrived at hospital',
            style: GoogleFonts.inter(
              color: Colors.black87,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (_) => ArriveToHospitalScreen(task: task),
                  ),
                );
              },
              child: Text(
                'Okay',
                style: GoogleFonts.inter(),
              ),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context!,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'ERROR!',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            response.reasonPhrase.toString(),
            style: GoogleFonts.inter(
              color: Colors.black87,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
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

  Future updateStatusToHandOver({
    BuildContext? context,
    Task? task,
    String? parent,
    String? forCrew,
    String? medicLoc,
    String? targetLoc,
    String? actionTime,
    String? odo,
    String? dis,
    String? dur,
  }) async {
    Map data = {
      'parent': parent,
      'for_crew': forCrew,
      'status': 'Hand-Over',
      'medic_loc': medicLoc,
      'target_loc': targetLoc,
      'action_time': actionTime,
      'odo': odo,
      'dis': dis,
      'dur': dur,
    };
    var storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    final response = await http.post(
      Uri.parse('https://tacpulse.animo-ai.co/api/paramedic/phases/update/'),
      body: data,
      headers: {
        'Authorization': 'Token ' + token!,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      showDialog(
        context: context!,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'SUCCESS',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Status updated to Handed Over',
            style: GoogleFonts.inter(
              color: Colors.black87,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (_) => HandOverScreen(task: task),
                  ),
                );
              },
              child: Text(
                'Okay',
                style: GoogleFonts.inter(),
              ),
            ),
          ],
        ),
      );
    } else if (response.statusCode == 208) {
      showDialog(
        context: context!,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'ERROR',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'You have already handed over',
            style: GoogleFonts.inter(
              color: Colors.black87,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (_) => HandOverScreen(task: task),
                  ),
                );
              },
              child: Text(
                'Okay',
                style: GoogleFonts.inter(),
              ),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context!,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'ERROR!',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            response.reasonPhrase.toString(),
            style: GoogleFonts.inter(
              color: Colors.black87,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
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

  Future updateStatusToBackToBase({
    BuildContext? context,
    Task? task,
    String? parent,
    String? forCrew,
    String? medicLoc,
    String? targetLoc,
    String? actionTime,
    String? odo,
    String? dis,
    String? dur,
  }) async {
    Map data = {
      'parent': parent,
      'for_crew': forCrew,
      'status': 'Return-Back-To-Base',
      'medic_loc': medicLoc,
      'target_loc': targetLoc,
      'action_time': actionTime,
      'odo': odo,
      'dis': dis,
      'dur': dur,
    };
    var storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    final response = await http.post(
      Uri.parse('https://tacpulse.animo-ai.co/api/paramedic/phases/update/'),
      body: data,
      headers: {
        'Authorization': 'Token ' + token!,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      showDialog(
        context: context!,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'SUCCESS',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Status updated to Returning to Base',
            style: GoogleFonts.inter(
              color: Colors.black87,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (_) => BackToBaseScreen(task: task),
                  ),
                );
              },
              child: Text(
                'Okay',
                style: GoogleFonts.inter(),
              ),
            ),
          ],
        ),
      );
    } else if (response.statusCode == 208) {
      showDialog(
        context: context!,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'ERROR',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'You have already returned to base',
            style: GoogleFonts.inter(
              color: Colors.black87,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (_) => BackToBaseScreen(task: task),
                  ),
                );
              },
              child: Text(
                'Okay',
                style: GoogleFonts.inter(),
              ),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context!,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'ERROR!',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            response.reasonPhrase.toString(),
            style: GoogleFonts.inter(
              color: Colors.black87,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
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

  Future updateStatusToServiceCompleted({
    BuildContext? context,
    Task? task,
    String? parent,
    String? forCrew,
    String? medicLoc,
    String? targetLoc,
    String? actionTime,
    String? odo,
    String? dis,
    String? dur,
  }) async {
    Map data = {
      'parent': parent,
      'for_crew': forCrew,
      'status': 'Service-Completed',
      'medic_loc': medicLoc,
      'target_loc': targetLoc,
      'action_time': actionTime,
      'odo': odo,
      'dis': dis,
      'dur': dur,
    };
    var storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    final response = await http.post(
      Uri.parse('https://tacpulse.animo-ai.co/api/paramedic/phases/update/'),
      body: data,
      headers: {
        'Authorization': 'Token ' + token!,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      showDialog(
        context: context!,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'SUCCESS',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Status updated to Service Completed',
            style: GoogleFonts.inter(
              color: Colors.black87,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (_) => DashboardScreen(),
                  ),
                );
              },
              child: Text(
                'Okay',
                style: GoogleFonts.inter(),
              ),
            ),
          ],
        ),
      );
    } else if (response.statusCode == 208) {
      showDialog(
        context: context!,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'ERROR',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'You have already completed service',
            style: GoogleFonts.inter(
              color: Colors.black87,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (_) => DashboardScreen(),
                  ),
                );
              },
              child: Text(
                'Okay',
                style: GoogleFonts.inter(),
              ),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context!,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'ERROR!',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            response.reasonPhrase.toString(),
            style: GoogleFonts.inter(
              color: Colors.black87,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
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

  Future addServiceNote({
    BuildContext? context,
    int? id,
    String? scribeId,
    String? noteType,
    String? note,
  }) async {
    var storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');

    Map data = {
      'service_notes': noteType,
      'service_note_description': note,
      'scribe': scribeId,
    };

    final response = await http.post(
      Uri.parse(
          'https://tacpulse.animo-ai.co/api/notes/' + id.toString() + '/'),
      body: data,
      headers: {
        'Authorization': 'Token ' + token!,
      },
    );
    if (response.statusCode == 201) {
      showDialog(
        context: context!,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'SUCCESS!',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Service Note added',
            style: GoogleFonts.inter(
              color: Colors.black87,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Okay',
                style: GoogleFonts.inter(),
              ),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context!,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'ERROR!',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            response.reasonPhrase.toString(),
            style: GoogleFonts.inter(
              color: Colors.black87,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
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

  Future addImage({
    BuildContext? context,
    int? id,
    String? imageType,
    String? imagePath,
  }) async {
    var storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    final request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://tacpulse.animo-ai.co/api/photos/' + id.toString() + '/'),
    );
    request.headers['Authorization'] = 'Token ' + token!;
    request.fields['photos_and_other_choices'] = imageType!;
    request.files.add(await http.MultipartFile.fromPath('photo', imagePath!));
    request.send().then((response) {
      if (response.statusCode == 201) {
        showDialog(
          context: context!,
          builder: (BuildContext context) => AlertDialog(
            title: Text(
              'SUCCESS!',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              'Image added',
              style: GoogleFonts.inter(
                color: Colors.black87,
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Okay',
                  style: GoogleFonts.inter(),
                ),
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context!,
          builder: (BuildContext context) => AlertDialog(
            title: Text(
              'ERROR!',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              response.reasonPhrase.toString(),
              style: GoogleFonts.inter(
                color: Colors.black87,
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Retry',
                  style: GoogleFonts.inter(),
                ),
              ),
            ],
          ),
        );
      }
    });
  }

  Future<List<Message>> fetchMessages(int id) async {
    var storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    final response = await http.get(
      Uri.parse(
          'https://tacpulse.animo-ai.co/api/inbox/' + id.toString() + '/'),
      headers: {'Authorization': 'Token ' + token!},
    );
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((data) => new Message.fromJson(data)).toList();
    } else {
      throw Exception('Could not load messages');
    }
  }

  Future sendMessage({
    BuildContext? context,
    int? id,
    String? senderId,
    String? message,
  }) async {
    var storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');

    Map data = {
      'sender': senderId,
      'msg': message,
    };

    final response = await http.post(
      Uri.parse(
          'https://tacpulse.animo-ai.co/api/inbox/' + id.toString() + '/'),
      body: data,
      headers: {'Authorization': 'Token ' + token!},
    );
    if (response.statusCode == 201) {
      // do nothing
    } else {
      showDialog(
        context: context!,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'ERROR!',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            response.reasonPhrase.toString(),
            style: GoogleFonts.inter(
              color: Colors.black87,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
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

  Future<List<Scribe>> fetchScribes() async {
    var storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    final response = await http.get(
      Uri.parse('https://tacpulse.animo-ai.co/api/scribes/'),
      headers: {'Authorization': 'Token ' + token!},
    );
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((data) => new Scribe.fromJson(data)).toList();
    } else {
      throw Exception('Could not load scribes');
    }
  }
}
