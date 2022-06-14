import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tacpulse/models/monthly_paystub.dart';
import 'package:tacpulse/services/db_services.dart';

class MonthlyPaystubScreen extends StatefulWidget {
  @override
  _MonthlyPaystubScreenState createState() => _MonthlyPaystubScreenState();
}

class _MonthlyPaystubScreenState extends State<MonthlyPaystubScreen> {
  DbServices _dbServices = DbServices();

  Stream<List<MonthlyPaystub>> _loadMonthlyPaystubs() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      yield await _dbServices.fetchMonthlyPaystubs();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(top: 2.0),
          child: Text(
            'Monthly Paystubs',
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
      body: StreamBuilder<List<MonthlyPaystub>>(
        stream: _loadMonthlyPaystubs(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<MonthlyPaystub> data = snapshot.data;
            return ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  elevation: 6,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 4.0),
                          child: RichText(
                            text: TextSpan(
                              text: 'Date created: ',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      data[index].uploadDate!.substring(0, 10) +
                                          ", ",
                                  style: GoogleFonts.inter(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Amount: ',
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: data[index].amount,
                                          style: GoogleFonts.inter(
                                            color: Colors.black45,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 6),
                        MaterialButton(
                          onPressed: () {},
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          minWidth: 20,
                          color: Theme.of(context).primaryColor,
                          child: Text(
                            'Download',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                            ),
                          ),
                        )
                      ],
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
