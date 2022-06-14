import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tacpulse/services/db_services.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildForgotPasswordAppBar(context),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildForgotPasswordHeader(),
              const SizedBox(height: 5),
              buildForgotPasswordSubHeader(),
              const SizedBox(height: 30.0),
              buildForgotPasswordForm(),
              const SizedBox(height: 10.0),
              buildForgotPasswordMaterialButton(),
              const SizedBox(height: 10.0),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildForgotPasswordSubHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Text(
        'Enter your email to get password change link',
        style: GoogleFonts.inter(
          color: Colors.black45,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget buildForgotPasswordHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20.0),
      child: Text(
        'Forgot Password?',
        style: GoogleFonts.inter(
          color: Colors.black87,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildForgotPasswordMaterialButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: MaterialButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            FocusScope.of(context).unfocus();
            var service = DbServices();
            service.resetPassword(emailController.text, context);
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
    );
  }

  Widget buildForgotPasswordForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: FormBuilder(
        key: _formKey,
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
                hintText: 'Enter your email address',
                hintStyle: GoogleFonts.inter(),
                errorStyle: GoogleFonts.inter(
                  fontSize: 10,
                ),
              ),
              validator: (value) =>
                  value!.isEmpty ? 'This field cannot be empty' : null,
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget buildForgotPasswordAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
