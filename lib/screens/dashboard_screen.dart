import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tacpulse/drawers/side_drawer.dart';
import 'package:tacpulse/models/response.dart';
import 'package:tacpulse/models/task.dart';
import 'package:tacpulse/screens/login_screen.dart';
import 'package:tacpulse/screens/task_details_screen.dart';
import 'package:tacpulse/services/auth_service.dart';
import 'package:tacpulse/services/db_services.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  DbServices _dbServices = DbServices();

  Stream<List<Task>> _loadTasks() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 3));
      yield await _dbServices.fetchTaskList();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DbServices _dbServices = DbServices();
    var data = _dbServices.fetchTaskList();
    print(data);
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
        key: scaffoldKey,
        appBar: buildDashboardAppBar(context),
        drawer: SideDrawer(),
        body: StreamBuilder<List<Task>>(
          stream: _loadTasks(),
          builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
            if (snapshot.hasData) {
              List<Task> tasks = snapshot.data!
                  .where((task) => task.parent!.closed == false)
                  .toList();
              print(tasks);
              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                            builder: (_) =>
                                TaskDetailsScreen(task: tasks[index]),
                          ),
                        );
                      },
                      title: Text(
                        'Run ID: ' + tasks[index].parent!.runId.toString(),
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Text(
                        'Tap to respond',
                        style: GoogleFonts.inter(
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  // Dashboard appbar
  AppBar buildDashboardAppBar(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: EdgeInsets.only(top: 5.0),
        child: Text(
          'Your Tasks',
          style: GoogleFonts.inter(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
      ),
      leading: Padding(
        padding: EdgeInsets.only(top: 2.0),
        child: IconButton(
          icon: Icon(Icons.menu),
          color: Colors.black87,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(top: 4.0),
          child: IconButton(
            icon: Icon(Icons.logout_outlined),
            color: Colors.black87,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text('Logout', style: GoogleFonts.inter()),
                  content: Text('Are you sure?', style: GoogleFonts.inter()),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'No',
                        style: GoogleFonts.inter(),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        var service = AuthService();
                        service.userSignOut();
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => LoginScreen()),
                        );
                      },
                      child: Text(
                        'Yes',
                        style: GoogleFonts.inter(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
      centerTitle: true,
      // elevation: 0,
      backgroundColor: Color(0xFFFFFFFF),
    );
  }
}
