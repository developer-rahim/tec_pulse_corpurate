import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tacpulse/models/occurrence.dart';
import 'package:tacpulse/services/db_services.dart';

class OccurrenceReportsScreen extends StatefulWidget {
  @override
  OccurrenceReportsScreenState createState() => OccurrenceReportsScreenState();
}

class OccurrenceReportsScreenState extends State<OccurrenceReportsScreen> {
  DbServices _dbServices = DbServices();

  Stream<List<Occurrence>> _loadOccurrenceReports() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      yield await _dbServices.fetchOccurrenceReports();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(top: 2.0),
          child: Text(
            'Occurrence Reports',
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
      body: StreamBuilder<List<Occurrence>>(
        stream: _loadOccurrenceReports(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<Occurrence> data = snapshot.data;
            return ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
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
                      data[index].reason.toString(),
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      data[index].department.toString() +
                          '\nDate: ' +
                          data[index].date.toString(),
                      style: GoogleFonts.inter(),
                    ),
                  ),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
