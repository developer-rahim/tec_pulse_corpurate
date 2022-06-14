import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tacpulse/screens/forgot_password_screen.dart';
import 'package:tacpulse/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // Code for password visibility
  bool obscureTextStatus = true;
  void togglePasswordVisibility() {
    setState(() {
      obscureTextStatus = !obscureTextStatus;
    });
  }

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
        appBar: buildLoginAppBar(context),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Hello there!',
                    style: GoogleFonts.inter(
                      color: Colors.black87,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Enter your credentials and login',
                    style: GoogleFonts.inter(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                buildLoginForm(),
                buildForgotPasswordLink(context),
                const SizedBox(height: 20),
                buildLoginMaterialButton(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLoginMaterialButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: MaterialButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            FocusScope.of(context).unfocus();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Theme.of(context).primaryColor,
                elevation: 0,
                width: 120,
                behavior: SnackBarBehavior.floating,
                duration: Duration(milliseconds: 1700),
                content: Container(
                  color: Colors.transparent,
                  child: Text(
                    'Logging In...',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
            var service = AuthService();
            service.userLogin(
                _emailController.text, _passwordController.text, context);
          }
        },
        elevation: 0,
        height: 50,
        minWidth: double.infinity,
        color: Color(0xffbe141a),
        child: Text(
          'Login',
          style: GoogleFonts.inter(
            color: Color(0xFFFFFFFF),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildForgotPasswordLink(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20.0, top: 10.0, bottom: 10.0),
      alignment: Alignment.bottomRight,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ForgotPasswordScreen(),
            ),
          );
        },
        child: Text(
          'Forgot Password?',
          style: GoogleFonts.inter(
            color: Colors.black87,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget buildLoginForm() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
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
              controller: _emailController,
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
              validator: (value) {
                if (value!.isEmpty) {
                  return 'This field cannot be empty';
                } else if (!isValidEmail(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            Text(
              'Password',
              style: GoogleFonts.inter(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 5),
            FormBuilderTextField(
              name: 'password',
              controller: _passwordController,
              obscureText: obscureTextStatus,
              style: GoogleFonts.inter(fontSize: 14.0, height: 1.45),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black12,
                hintText: 'Enter your password',
                hintStyle: GoogleFonts.inter(),
                errorStyle: GoogleFonts.inter(
                  fontSize: 10,
                ),
                suffixIcon: IconButton(
                  icon: obscureTextStatus
                      ? Icon(CupertinoIcons.eye_fill, size: 22)
                      : Icon(CupertinoIcons.eye_slash_fill, size: 22),
                  onPressed: () => togglePasswordVisibility(),
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
    );
  }

  PreferredSizeWidget buildLoginAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}
