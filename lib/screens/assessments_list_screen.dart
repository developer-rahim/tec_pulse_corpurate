import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tacpulse/models/assessment.dart';
import 'package:tacpulse/services/db_services.dart';

class AssessmentsListScreen extends StatefulWidget {
  @override
  _AssessmentsListScreenState createState() => _AssessmentsListScreenState();
}

class _AssessmentsListScreenState extends State<AssessmentsListScreen> {
  DbServices _dbServices = DbServices();

  Stream<List<Assessment>> _loadAssessments() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      yield await _dbServices.fetchAssessments();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadAssessments();
    print('vvvvv:  ${_loadAssessments()}');
    print('data $data');
  }

 List<Assessment> data=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(top: 2.0),
          child: Text(
            'Assessments',
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
      body: StreamBuilder<List<Assessment>>(
        stream: _loadAssessments(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
        //  List<Assessment>    data = snapshot.data;
        data = snapshot.data;
            print(' Assernment:  $data');
            return ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 6),
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    title: Text(
                      data[index].message.toString(),
                      style: GoogleFonts.inter(),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'From: ',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                            children: [
                              TextSpan(
                                text: data[index].byUser.toString(),
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'To: ',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                            children: [
                              TextSpan(
                                text: data[index].toUser.toString(),
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Remark: ',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                            children: [
                              TextSpan(
                                text: data[index].remark.toString(),
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Warning: ',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                            children: [
                              TextSpan(
                                text: data[index].warning! ? 'Yes' : 'No',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Date Created: ',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                            children: [
                              TextSpan(
                                text: data[index]
                                    .created
                                    .toString()
                                    .substring(0, 10),
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Center(
            // child: Text('No Data Avaiable')

             child:    CircularProgressIndicator()
              );
        },
      ),
    );
  }
}
