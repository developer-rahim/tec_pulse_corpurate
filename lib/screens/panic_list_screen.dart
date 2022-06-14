import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:tacpulse/globals.dart' as globals;
import 'package:tacpulse/models/panic.dart';

class PanicListScreen extends StatefulWidget {
  @override
  _PanicListScreenState createState() => _PanicListScreenState();
}

class _PanicListScreenState extends State<PanicListScreen> {
  Future<List<Panic>> fetchPanicList() async {
    var response = await http.get(
        Uri.parse('https://tacpulse.animo-ai.co/api/panic/list/'),
        headers: {
          "Authorization": 'Token ' + globals.token,
        });
    if (response.statusCode == 200) {
      List jsonData = jsonDecode(response.body);
      print('data   :   $jsonData');
      setState(() {
        panicList = jsonData as Future<List<Panic>>;
      });
      return jsonData.map((data) => new Panic.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load panic list');
    }
  }

  Future<List<Panic>>? panicList;
  // fetchPanicList();
  @override
  void initState() {
    // TODO: implement initState
    // print(panicList);
    panicList;
    print(panicList);
    fetchPanicList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(top: 2.0),
          child: Text(
            'Panic Reports',
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
      body: RefreshIndicator(
        onRefresh: fetchPanicList,
        child: FutureBuilder(
          future: panicList,
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              List<Panic> data = snapshot.data;
              return ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 25, vertical: 7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 7,
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      title: Text(
                        data[index].reason.toString(),
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Contact: ',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                              children: [
                                TextSpan(
                                  text: data[index].emergencyContact.toString(),
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black54,
                                  ),
                                )
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Place: ',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                              children: [
                                TextSpan(
                                  text: data[index].place.toString(),
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black54,
                                  ),
                                )
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Lat: ',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                              children: [
                                TextSpan(
                                  text: data[index].lat.toString(),
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black54,
                                  ),
                                )
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Lng: ',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                              children: [
                                TextSpan(
                                  text: data[index].lng.toString(),
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black54,
                                  ),
                                )
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
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
