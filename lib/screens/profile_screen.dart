import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tacpulse/models/user.dart';
import 'package:tacpulse/screens/account_settings_screen.dart';
import 'package:tacpulse/screens/change_password_screen.dart';
import 'package:tacpulse/screens/help_center_screen.dart';
//import 'package:tacpulse/screens/notifications_screen.dart';
import 'package:tacpulse/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:tacpulse/globals.dart' as globals;

import '../services/db_services.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Future<List<User>> getUserProfileData() async {
  //   final response = await http.get(
  //       Uri.parse('https://tacpulse.animo-ai.co/api/profile/'),
  //       headers: {"Authorization": 'Token ' + globals.token});
  //   if (response.statusCode == 200) {
  //     List jsonResponse = jsonDecode(response.body);
  //     print(jsonResponse);
  //     return jsonResponse.map((data) => new User.fromJson(data)).toList();
  //   } else {
  //     throw Exception('Failed to load profile data');
  //   }
  // }

  // late Future<List<User>> userProfileData;

  // @override
  // void initState() {
  //   userProfileData = getUserProfileData();
  //   super.initState();
  // }
  DbServices _dbServices = DbServices();
  late Future<List<User>> _userProfileData;

  @override
  void initState() {
    _userProfileData = _dbServices.getUserProfileData();
    super.initState();
    print(_userProfileData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(top: 5.0),
          child: Text(
            'Your Profile',
            style: GoogleFonts.inter(
              color: Colors.black54,
              fontSize: 20.0,
            ),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFFFFFFFF),
        leading: Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            iconSize: 20.0,
            color: Colors.black54,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: FutureBuilder<List<User>>(
        future: _userProfileData,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            List<User> data = snapshot.data;
            print(data);
            String imgLink = data[0].profilePic.toString();
            globals.userName = data[0].username.toString();
            return ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 8.0),
                  child: Center(
                    child: CircleAvatar(
                      radius: 77,
                      backgroundImage: NetworkImage(imgLink),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  data[0].firstName.toString() +
                      ' ' +
                      data[0].lastName.toString(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  data[0].contact.toString(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  shadowColor: Colors.transparent,
                  color: Color(0xFFFFE2E5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    onTap: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => AccountSettingsScreen(),
                      ),
                    ),
                    title: Text(
                      'Account Settings',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: Color(0xFFF64E60),
                      ),
                    ),
                    leading: Icon(
                      CupertinoIcons.person,
                      size: 27,
                      color: Color(0xFFF64E60),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFFF64E60),
                      size: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  shadowColor: Colors.transparent,
                  color: Color(0xFFFFE2E5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    onTap: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => ChangePasswordScreen(),
                      ),
                    ),
                    title: Text(
                      'Change Password',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: Color(0xFFF64E60),
                      ),
                    ),
                    leading: Icon(
                      CupertinoIcons.lock,
                      size: 27,
                      color: Color(0xFFF64E60),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFFF64E60),
                      size: 20,
                    ),
                  ),
                ),

                // Card(
                //   margin: EdgeInsets.symmetric(horizontal: 30),
                //   shadowColor: Colors.transparent,
                //   color: Color(0xFFFFE2E5),
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(20),
                //   ),
                //   child: ListTile(
                //     onTap: () => Navigator.push(
                //       context,
                //       CupertinoPageRoute(
                //         builder: (_) => NotificationsScreen(),
                //       ),
                //     ),
                //     title: Text(
                //       'Notifications',
                //       style: GoogleFonts.inter(
                //         fontSize: 16,
                //         color: Color(0xFFF64E60),
                //       ),
                //     ),
                //     leading: Icon(
                //       CupertinoIcons.bell,
                //       size: 27,
                //       color: Color(0xFFF64E60),
                //     ),
                //     trailing: Icon(
                //       Icons.arrow_forward_ios,
                //       color: Color(0xFFF64E60),
                //       size: 20,
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  shadowColor: Colors.transparent,
                  color: Color(0xFFFFE2E5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    onTap: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => HelpCenterScreen(),
                      ),
                    ),
                    title: Text(
                      'Help Center',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: Color(0xFFF64E60),
                      ),
                    ),
                    leading: Icon(
                      CupertinoIcons.question,
                      size: 25,
                      color: Color(0xFFF64E60),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFFF64E60),
                      size: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  shadowColor: Colors.transparent,
                  color: Color(0xFFFFE2E5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    title: Text(
                      'Privacy',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: Color(0xFFF64E60),
                      ),
                    ),
                    leading: Icon(
                      CupertinoIcons.shield,
                      size: 27,
                      color: Color(0xFFF64E60),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFFF64E60),
                      size: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  shadowColor: Colors.transparent,
                  color: Color(0xFFFFE2E5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    title: Text(
                      'Sign Out',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: Color(0xFFF64E60),
                      ),
                    ),
                    leading: Icon(
                      CupertinoIcons.square_arrow_right,
                      size: 27,
                      color: Color(0xFFF64E60),
                    ),
                    onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text(
                          'Sign Out',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: Text(
                          'Are you sure?',
                          style: GoogleFonts.inter(
                            color: Colors.black45,
                          ),
                        ),
                        actions: [
                          TextButton(
                            child: Text(
                              'No',
                              style: GoogleFonts.inter(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              var service = AuthService();
                              service.userSignOut();
                              SystemNavigator.pop();
                            },
                            child: Text(
                              'Yes',
                              style: GoogleFonts.inter(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
