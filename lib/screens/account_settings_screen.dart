import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tacpulse/screens/update_address_screen.dart';
import 'package:tacpulse/screens/update_bio_screen.dart';
import 'package:tacpulse/screens/update_contact_screen.dart';
import 'package:tacpulse/screens/update_email_screen.dart';
import 'package:tacpulse/screens/update_name_screen.dart';

class AccountSettingsScreen extends StatefulWidget {
  @override
  AccountSettingsScreenState createState() => AccountSettingsScreenState();
}

class AccountSettingsScreenState extends State<AccountSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAccountSettingsAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(height: 20),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 7),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 6,
            child: ListTile(
              onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (_) => UpdateNameScreen(),
                ),
              ),
              title: Text(
                'Update Name',
                style: GoogleFonts.inter(
                  color: Colors.black54,
                ),
              ),
              leading: Icon(CupertinoIcons.person_fill),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 7),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 6,
            child: ListTile(
              onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (_) => UpdateEmailScreen(),
                ),
              ),
              title: Text(
                'Update Email',
                style: GoogleFonts.inter(
                  color: Colors.black54,
                ),
              ),
              leading: Icon(CupertinoIcons.envelope_fill),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 7),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 6,
            child: ListTile(
              onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (_) => UpdateAddressScreen(),
                ),
              ),
              title: Text(
                'Update Address',
                style: GoogleFonts.inter(
                  color: Colors.black54,
                ),
              ),
              leading: Icon(CupertinoIcons.building_2_fill),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 7),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 6,
            child: ListTile(
              onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (_) => UpdateContactScreen(),
                ),
              ),
              title: Text(
                'Update Contact',
                style: GoogleFonts.inter(
                  color: Colors.black54,
                ),
              ),
              leading: Icon(CupertinoIcons.device_phone_portrait),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 7),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 6,
            child: ListTile(
              onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (_) => UpdateBioScreen(),
                ),
              ),
              title: Text(
                'Update Bio',
                style: GoogleFonts.inter(
                  color: Colors.black54,
                ),
              ),
              leading: Icon(CupertinoIcons.text_quote),
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAccountSettingsAppBar(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: EdgeInsets.only(top: 2.0),
        child: Text(
          'Account Settings',
          style: GoogleFonts.inter(
            color: Colors.black54,
            fontSize: 20.0,
          ),
        ),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
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
    );
  }
}
