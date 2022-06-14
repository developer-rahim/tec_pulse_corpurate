import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tacpulse/screens/assessments_list_screen.dart';
import 'package:tacpulse/screens/chat_screen.dart';
import 'package:tacpulse/screens/inspection_checklists_screen.dart';
// import 'package:tacpulse/screens/monthly_paystub_screen.dart';
// import 'package:tacpulse/screens/occurrence_reports_screen.dart';
import 'package:tacpulse/screens/panic_list_screen.dart';
import 'package:tacpulse/screens/profile_screen.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.white),
        child: Drawer(
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 17.0),
                      child: RichText(
                        text: TextSpan(
                          text: 'TAC-',
                          style: GoogleFonts.inter(
                            color: Colors.black54,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: 'PULSE',
                              style: GoogleFonts.inter(
                                color: Color(0xFFF64E60),
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Container(
                        height: 25,
                        width: 105,
                        child: Card(
                          shadowColor: Colors.transparent,
                          color: Color(0xFFFFE2E5),
                          child: Center(
                            child: Text(
                              'Corporate App',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                color: Color(0xFFF64E60),
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                title: Text(
                  'Inspection Checklist',
                  style: GoogleFonts.inter(
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
                leading: Icon(CupertinoIcons.doc_plaintext, size: 27),
                trailing: Icon(Icons.arrow_forward_ios, size: 15),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => InspectionChecklistsScreen(),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 17.0, bottom: 10),
                child: Text(
                  'REPORTS',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // ListTile(
              //   title: Text(
              //     'Occurrence Reports',
              //     style: GoogleFonts.inter(
              //       color: Colors.black54,
              //       fontSize: 12,
              //     ),
              //   ),
              //   leading: Icon(CupertinoIcons.news, size: 27),
              //   trailing: Icon(Icons.arrow_forward_ios, size: 15),
              //   onTap: () {
              //     Navigator.pop(context);
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (_) => OccurrenceReportsScreen(),
              //       ),
              //     );
              //   },
              // ),
              // ListTile(
              //   title: Text(
              //     'Monthly Pay Stubs',
              //     style: GoogleFonts.inter(
              //       color: Colors.black54,
              //       fontSize: 12,
              //     ),
              //   ),
              //   leading: Icon(CupertinoIcons.news, size: 27),
              //   trailing: Icon(Icons.arrow_forward_ios, size: 15),
              //   onTap: () {
              //     Navigator.pop(context);
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (_) => MonthlyPaystubScreen(),
              //       ),
              //     );
              //   },
              // ),
              ListTile(
                title: Text(
                  'Assessments',
                  style: GoogleFonts.inter(
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
                leading: Icon(CupertinoIcons.news, size: 27),
                trailing: Icon(Icons.arrow_forward_ios, size: 15),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AssessmentsListScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 17.0, bottom: 10),
                child: Text(
                  'PANIC',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'Panic Report List',
                  style: GoogleFonts.inter(
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
                leading: Icon(CupertinoIcons.list_dash, size: 27),
                trailing: Icon(Icons.arrow_forward_ios, size: 15),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (_) => PanicListScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 17.0, bottom: 10),
                child: Text(
                  'CHAT',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'Chat Messaging',
                  style: GoogleFonts.inter(
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
                leading: Icon(CupertinoIcons.chat_bubble_2, size: 27),
                trailing: Icon(Icons.arrow_forward_ios, size: 15),
                onTap: () {
                 // Navigator.pop(context);
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (_) => ChatScreen(),
                    ),
                  );
                },
              ),
                 SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 17.0, bottom: 10),
                child: Text(
                  'PROFILE',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'Check Profile',
                  style: GoogleFonts.inter(
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
                leading: Icon(CupertinoIcons.chat_bubble_2, size: 27),
                trailing: Icon(Icons.arrow_forward_ios, size: 15),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (_) => ProfileScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
