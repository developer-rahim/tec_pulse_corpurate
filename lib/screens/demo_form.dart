import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';

class DemoForm extends StatefulWidget {
  @override
  _DemoFormState createState() => _DemoFormState();
}

class _DemoFormState extends State<DemoForm> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.only(top: 2.0),
            child: Text(
              'Audit Form',
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
        body: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: FormBuilder(
                    child: Column(
                      children: <Widget>[
                        FormBuilderTextField(
                          name: 'name',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Field',
                            labelStyle: GoogleFonts.inter(
                              fontSize: 16,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FormBuilderTextField(
                          name: 'name',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Field',
                            labelStyle: GoogleFonts.inter(
                              fontSize: 16,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FormBuilderTextField(
                          name: 'name',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Field',
                            labelStyle: GoogleFonts.inter(
                              fontSize: 16,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FormBuilderTextField(
                          name: 'name',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Field',
                            labelStyle: GoogleFonts.inter(
                              fontSize: 16,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FormBuilderTextField(
                          name: 'name',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Field',
                            labelStyle: GoogleFonts.inter(
                              fontSize: 16,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FormBuilderTextField(
                          name: 'name',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Field',
                            labelStyle: GoogleFonts.inter(
                              fontSize: 16,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FormBuilderTextField(
                          name: 'name',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Field',
                            labelStyle: GoogleFonts.inter(
                              fontSize: 16,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FormBuilderTextField(
                          name: 'name',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Field',
                            labelStyle: GoogleFonts.inter(
                              fontSize: 16,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                MaterialButton(
                  onPressed: () {},
                  elevation: 0,
                  height: 50,
                  minWidth: 300,
                  textColor: Color(0xFFFFFFFF),
                  color: Color(0xFFF64E60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    'Save & Upload',
                    style: GoogleFonts.inter(
                      color: Color(0xFFFFFFFF),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
