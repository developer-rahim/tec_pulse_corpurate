import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tacpulse/models/inspection_checklists.dart';
import 'package:tacpulse/services/db_services.dart';

class InspectionChecklistsScreen extends StatefulWidget {
  @override
  InspectionChecklistsScreenState createState() =>
      InspectionChecklistsScreenState();
}

class InspectionChecklistsScreenState
    extends State<InspectionChecklistsScreen> {
  DbServices _dbServices = DbServices();

  Stream<List<InspectionChecklists>> _loadInspectionChecklists() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      yield await _dbServices.fetchInspectionChecklists();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DbServices _dbServices = DbServices();
    var data = _dbServices.fetchInspectionChecklists();
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(top: 2.0),
          child: Text(
            'Inspection Checklists',
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
      body: StreamBuilder<List<InspectionChecklists>>(
        stream: _loadInspectionChecklists(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<InspectionChecklists> data = snapshot.data;
            return ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    title: Text(
                      data[index].type.toString(),
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Detail: ' +
                          data[index].detail.toString() +
                          '\nOutput: ' +
                          data[index].output.toString(),
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
