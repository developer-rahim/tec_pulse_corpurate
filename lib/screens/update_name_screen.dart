import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tacpulse/services/db_services.dart';

class UpdateNameScreen extends StatefulWidget {
  @override
  _UpdateNameScreenState createState() => _UpdateNameScreenState();
}

class _UpdateNameScreenState extends State<UpdateNameScreen> {
  DbServices _dbServices = DbServices();

  final formKey = GlobalKey<FormBuilderState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
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
        ),
        body: Column(
          children: [
            Center(
              child: Text(
                'Update your name',
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 43),
              child: FormBuilder(
                key: formKey,
                child: Column(
                  children: [
                    FormBuilderTextField(
                      name: 'firstName',
                      controller: firstNameController,
                      style: GoogleFonts.inter(fontSize: 12.0),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 22.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: 'Enter your first name',
                        hintStyle: GoogleFonts.inter(),
                        labelStyle: GoogleFonts.inter(
                          fontSize: 12.0,
                        ),
                        errorStyle: GoogleFonts.inter(
                          fontSize: 10,
                        ),
                        prefixIcon: Icon(
                          CupertinoIcons.person_fill,
                          size: 22,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'This field cannot be empty';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FormBuilderTextField(
                      name: 'lastName',
                      controller: lastNameController,
                      style: GoogleFonts.inter(fontSize: 12.0),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 22.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: 'Enter your last name',
                        hintStyle: GoogleFonts.inter(),
                        labelStyle: GoogleFonts.inter(
                          fontSize: 12.0,
                        ),
                        errorStyle: GoogleFonts.inter(
                          fontSize: 10,
                        ),
                        prefixIcon: Icon(
                          CupertinoIcons.person_fill,
                          size: 22,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'This field cannot be empty';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  FocusScope.of(context).unfocus();
                  _dbServices.updateName(context, firstNameController.text,
                      lastNameController.text);
                }
              },
              elevation: 0,
              height: 50,
              minWidth: 300,
              textColor: Color(0xFFFFFFFF),
              color: Color(0xFFF64E60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                'Update',
                style: GoogleFonts.inter(
                  color: Color(0xFFFFFFFF),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
