import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ReferScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.starOfLife,
              size: 180,
              color: Theme.of(context).primaryColor.withOpacity(0.3),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              'Please refer to the official\nwebsite for TAC-Pulse',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(),
            ),
          ],
        ),
      ),
    );
  }
}
