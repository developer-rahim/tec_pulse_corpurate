import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tacpulse/models/faq.dart';
import 'package:tacpulse/services/db_services.dart';

class HelpCenterScreen extends StatefulWidget {
  @override
  _HelpCenterScreenState createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  DbServices _dbServices = DbServices();

  Stream<List<Faq>> _loadFaqs() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      yield await _dbServices.fetchFaqs();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildHelpCenterAppBar(context),
      body: StreamBuilder<List<Faq>>(
        stream: _loadFaqs(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<Faq> data = snapshot.data;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                  title: Text(
                    data[index].question.toString(),
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  subtitle: Text(
                    data[index].answer.toString(),
                    style: GoogleFonts.inter(),
                  ),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  AppBar buildHelpCenterAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: Padding(
        padding: EdgeInsets.only(top: 1),
        child: Text(
          'FAQs',
          style: GoogleFonts.inter(color: Colors.black54),
        ),
      ),
      centerTitle: true,
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
