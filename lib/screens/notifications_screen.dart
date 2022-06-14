import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tacpulse/models/notifications.dart';
import 'package:tacpulse/services/db_services.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  NotificationsScreenState createState() => NotificationsScreenState();
}

class NotificationsScreenState extends State<NotificationsScreen> {
  DbServices _dbServices = DbServices();

  Stream<List<Notifications>> _loadNotifications() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      yield await _dbServices.fetchNotifications();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFFFFFFF),
        leading: Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: IconButton(
            icon: Icon(CupertinoIcons.chevron_left),
            iconSize: 24.0,
            color: Colors.black54,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: StreamBuilder<List<Notifications>>(
        stream: _loadNotifications(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<Notifications> data = snapshot.data;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 6),
                  elevation: 6,
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                    title: Text(
                      data[index].firstName.toString() +
                          ' ' +
                          data[index].lastName.toString(),
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      data[index].notification.toString(),
                      style: GoogleFonts.inter(),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load notifications'));
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
