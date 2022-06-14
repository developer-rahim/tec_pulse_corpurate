/* Multi-page Registration Screen setup */

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tacpulse/screens/image_selection_screen.dart';
import 'package:tacpulse/screens/login_screen.dart';

// First screen for inputting registration information
class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  bool isValidEmail(String email) {
    if (RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email)) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFFFFFFFF),
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
        body: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
                  child: Text(
                    'Join us today!',
                    style: GoogleFonts.inter(
                      color: Colors.black54,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Become a member of TAC-Pulse ERS',
                  style: GoogleFonts.inter(
                    color: Colors.black45,
                    fontSize: 12,
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 43.0),
                  child: FormBuilder(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        FormBuilderTextField(
                          name: 'email',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: GoogleFonts.inter(fontSize: 12.0),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 22.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: 'Enter your email address',
                            hintStyle: GoogleFonts.inter(),
                            labelStyle: GoogleFonts.inter(
                              fontSize: 12.0,
                            ),
                            errorStyle: GoogleFonts.inter(
                              fontSize: 10,
                            ),
                            prefixIcon: Icon(
                              CupertinoIcons.envelope_fill,
                              size: 22.0,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'This field cannot be empty';
                            } else if (!isValidEmail(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FormBuilderTextField(
                          name: 'password',
                          controller: _passwordController,
                          style: GoogleFonts.inter(fontSize: 12.0),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 22.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: 'Enter a password',
                            hintStyle: GoogleFonts.inter(),
                            labelStyle: GoogleFonts.inter(
                              fontSize: 12.0,
                            ),
                            errorStyle: GoogleFonts.inter(
                              fontSize: 10,
                            ),
                            prefixIcon: Icon(
                              CupertinoIcons.lock_fill,
                              size: 22.0,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'This field cannot be empty';
                            } else if (value.length < 6) {
                              return 'Password cannot be less than 6 characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FormBuilderTextField(
                          name: 'confirmPassword',
                          controller: _confirmPasswordController,
                          style: GoogleFonts.inter(fontSize: 12.0),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 22.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: 'Confirm your password',
                            hintStyle: GoogleFonts.inter(),
                            labelStyle: GoogleFonts.inter(
                              fontSize: 12.0,
                            ),
                            errorStyle: GoogleFonts.inter(
                              fontSize: 10,
                            ),
                            prefixIcon: Icon(
                              CupertinoIcons.lock_fill,
                              size: 22.0,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'This field cannot be empty';
                            } else if (value != _passwordController.text) {
                              return 'The passwords do not match';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                MaterialButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => ExtendedSignupScreen(
                            email: _emailController.text,
                            password: _passwordController.text,
                            confirmPassword: _confirmPasswordController.text,
                          ),
                        ),
                      );
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
                    'Sign Up',
                    style: GoogleFonts.inter(
                      color: Color(0xFFFFFFFF),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Already a member? ',
                    style: GoogleFonts.inter(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                    children: [
                      TextSpan(
                        text: 'Login',
                        style: GoogleFonts.inter(
                          color: Color(0xFFF64E60),
                          fontSize: 12,
                        ),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => LoginScreen(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Second screen for inputting registration information
class ExtendedSignupScreen extends StatefulWidget {
  final String? email;
  final String? password;
  final String? confirmPassword;

  ExtendedSignupScreen(
      {required this.email,
      required this.password,
      required this.confirmPassword});

  @override
  _ExtendedSignupScreenState createState() => _ExtendedSignupScreenState();
}

class _ExtendedSignupScreenState extends State<ExtendedSignupScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  TextEditingController _phoneNoController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  // Code to validate South African contact numbers
  // with the use of a Regular Expression
  bool isValidPhoneNo(String phoneNo) {
    if (RegExp(r'^(?:\+27|0)(?:6\d|7[0-4]|7[6-9]|8[1-4])\d{7}$')
        .hasMatch(phoneNo)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // Retrieved data from first registration page
    _emailController.text = widget.email!;
    _passwordController.text = widget.password!;
    _confirmPasswordController.text = widget.confirmPassword!;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFFFFFFFF),
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
        body: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
                  child: Text(
                    'Completion',
                    style: GoogleFonts.inter(
                      color: Colors.black54,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Please enter your personal details',
                  style: GoogleFonts.inter(
                    color: Colors.black45,
                    fontSize: 12,
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 43.0),
                  child: FormBuilder(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        FormBuilderTextField(
                          name: 'firstName',
                          controller: _firstNameController,
                          keyboardType: TextInputType.emailAddress,
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
                          controller: _lastNameController,
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
                              size: 24.0,
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
                          name: 'address',
                          controller: _addressController,
                          style: GoogleFonts.inter(fontSize: 12.0),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 22.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: 'Enter your address',
                            hintStyle: GoogleFonts.inter(),
                            labelStyle: GoogleFonts.inter(
                              fontSize: 12.0,
                            ),
                            errorStyle: GoogleFonts.inter(
                              fontSize: 10,
                            ),
                            prefixIcon: Icon(
                              CupertinoIcons.location_solid,
                              size: 22.0,
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
                          name: 'phoneNo',
                          controller: _phoneNoController,
                          keyboardType: TextInputType.phone,
                          style: GoogleFonts.inter(fontSize: 12.0),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 22.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: 'Enter your phone number',
                            hintStyle: GoogleFonts.inter(),
                            labelStyle: GoogleFonts.inter(
                              fontSize: 12.0,
                            ),
                            errorStyle: GoogleFonts.inter(
                              fontSize: 10,
                            ),
                            prefixIcon: Icon(
                              CupertinoIcons.device_phone_portrait,
                              size: 22.0,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'This field cannot be empty';
                            }
                            //  else if (!isValidPhoneNo(value)) {
                            //   return 'Please enter a valid phone number';
                            // }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                MaterialButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => ImageSelectionScreen(
                            email: _emailController.text,
                            password: _passwordController.text,
                            confirmPassword: _confirmPasswordController.text,
                            firstName: _firstNameController.text,
                            lastName: _lastNameController.text,
                            address: _addressController.text,
                            contact: _phoneNoController.text,
                          ),
                        ),
                      );
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
                    'Complete Registration',
                    style: GoogleFonts.inter(
                      color: Color(0xFFFFFFFF),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Already a member? ',
                    style: GoogleFonts.inter(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                    children: [
                      TextSpan(
                        text: 'Login',
                        style: GoogleFonts.inter(
                          color: Color(0xFFF64E60),
                          fontSize: 12,
                        ),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => LoginScreen(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
