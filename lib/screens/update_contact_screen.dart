import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tacpulse/services/db_services.dart';

class UpdateContactScreen extends StatefulWidget {
  @override
  _UpdateContactScreenState createState() => _UpdateContactScreenState();
}

class _UpdateContactScreenState extends State<UpdateContactScreen> {
  DbServices _dbServices = DbServices();

  final formKey = GlobalKey<FormBuilderState>();
  TextEditingController contactController = TextEditingController();

  bool isValidPhoneNo(String phoneNo) {
    if (RegExp(r'^(?:\+27|0)(?:6\d|7[0-4]|7[6-9]|8[1-4])\d{7}$')
        .hasMatch(phoneNo)) {
      return true;
    }
    return false;
  }

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
                'Update your contact',
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
                child: FormBuilderTextField(
                  name: 'contact',
                  keyboardType: TextInputType.phone,
                  controller: contactController,
                  style: GoogleFonts.inter(fontSize: 12.0),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 22.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Enter your contact',
                    hintStyle: GoogleFonts.inter(),
                    labelStyle: GoogleFonts.inter(
                      fontSize: 12.0,
                    ),
                    errorStyle: GoogleFonts.inter(
                      fontSize: 10,
                    ),
                    prefixIcon: Icon(
                      CupertinoIcons.device_phone_portrait,
                      size: 22,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This field cannot be empty';
                    } else if (!isValidPhoneNo(value)) {
                      return 'Please enter a valid contact number';
                    }
                    return null;
                  },
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
                  _dbServices.updateContact(context, contactController.text);
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
