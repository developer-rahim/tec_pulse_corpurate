import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tacpulse/services/db_services.dart';

class ConfirmNewPasswordScreen extends StatefulWidget {
  @override
  _ConfirmNewPasswordScreenState createState() =>
      _ConfirmNewPasswordScreenState();
}

class _ConfirmNewPasswordScreenState extends State<ConfirmNewPasswordScreen> {
  DbServices _dbServices = DbServices();

  final formKey = GlobalKey<FormBuilderState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController tokenController = TextEditingController();

  bool isValidEmail(String email) {
    if (RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email)) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: Platform.isAndroid
              ? Icon(Icons.arrow_back)
              : Icon(Icons.arrow_back_ios),
          iconSize: 24.0,
          color: Colors.black54,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20.0, left: 20.0),
            child: Text(
              'Confirm Password',
              style: GoogleFonts.inter(
                color: Colors.black87,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'Enter your new password and token',
              style: GoogleFonts.inter(
                color: Colors.black45,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: FormBuilder(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Email Address',
                    style: GoogleFonts.inter(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),
                  FormBuilderTextField(
                    name: 'email',
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: GoogleFonts.inter(fontSize: 14.0),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black12,
                      hintText: 'Enter the email you provided',
                      hintStyle: GoogleFonts.inter(),
                      errorStyle: GoogleFonts.inter(
                        fontSize: 10,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This field cannot be empty';
                      } else if (!isValidEmail(value)) {
                        return 'Please enter a valid email';
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
                    style: GoogleFonts.inter(fontSize: 14.0),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black12,
                      hintText: 'Enter a new password',
                      hintStyle: GoogleFonts.inter(),
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
                    'Received Token',
                    style: GoogleFonts.inter(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),
                  FormBuilderTextField(
                    name: 'token',
                    controller: tokenController,
                    style: GoogleFonts.inter(fontSize: 14.0),
                    decoration: InputDecoration(
                      hintText: 'Enter the received token',
                      hintStyle: GoogleFonts.inter(),
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
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: MaterialButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  FocusScope.of(context).unfocus();
                  _dbServices.confirmNewPassword(context, emailController.text,
                      newPasswordController.text, tokenController.text);
                }
              },
              elevation: 0,
              height: 50,
              minWidth: double.infinity,
              color: Color(0xffbe141a),
              child: Text(
                'Reset Password',
                style: GoogleFonts.inter(
                  color: Color(0xFFFFFFFF),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
