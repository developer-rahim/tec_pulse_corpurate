import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tacpulse/services/db_services.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: buildChangePasswordAppBar(context),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 30),
                buildChangePasswordForm(),
                const SizedBox(height: 15.0),
                buildChangePasswordMaterialButton(context),
                const SizedBox(height: 20),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildChangePasswordMaterialButton(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          FocusScope.of(context).unfocus();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              duration: Duration(milliseconds: 1500),
              content: Container(
                color: Colors.transparent,
                child: Text(
                  'Change in progress...',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 16.0,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          );
          var service = DbServices();
          service.changePassword(
              oldPasswordController.text, newPasswordController.text, context);
        }
      },
      elevation: 0,
      height: 50,
      minWidth: double.infinity,
      color: Color(0xffbe141a),
      child: Text(
        'Change Password',
        style: GoogleFonts.inter(
          color: Color(0xFFFFFFFF),
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildChangePasswordForm() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: FormBuilder(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Previous Password',
              style: GoogleFonts.inter(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 5),
            FormBuilderTextField(
              name: 'old_password',
              controller: oldPasswordController,
              style: GoogleFonts.inter(fontSize: 12.0),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black12,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 15.0,
                ),
                hintText: 'Enter your previous password',
                hintStyle: GoogleFonts.inter(),
                labelStyle: GoogleFonts.inter(fontSize: 12.0),
                errorStyle: GoogleFonts.inter(
                  fontSize: 10,
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'This field cannot be empty';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            Text(
              'New Password',
              style: GoogleFonts.inter(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 5),
            FormBuilderTextField(
              name: 'new_password',
              controller: newPasswordController,
              style: GoogleFonts.inter(fontSize: 12.0),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black12,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 15.0,
                ),
                hintText: 'Enter a new password',
                hintStyle: GoogleFonts.inter(),
                labelStyle: GoogleFonts.inter(fontSize: 12.0),
                errorStyle: GoogleFonts.inter(
                  fontSize: 10,
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'This field cannot be empty';
                } else if (value.length < 6) {
                  return 'New password must atleast be of length 6';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget buildChangePasswordAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey[50],
      title: Text(
        'Change Password',
        style: GoogleFonts.inter(
          color: Colors.black87,
        ),
      ),
      leading: IconButton(
        icon: Platform.isAndroid
            ? Icon(Icons.arrow_back)
            : Icon(Icons.arrow_back_ios),
        iconSize: 24.0,
        color: Colors.black87,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
