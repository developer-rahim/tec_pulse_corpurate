import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tacpulse/services/auth_service.dart';

class ImageSelectionScreen extends StatefulWidget {
  final String? email;
  final String? password;
  final String? confirmPassword;
  final String? firstName;
  final String? lastName;
  final String? address;
  final String? contact;

  ImageSelectionScreen(
      {required this.email,
      this.password,
      this.confirmPassword,
      this.firstName,
      this.lastName,
      this.address,
      this.contact});

  @override
  _ImageSelectionScreenState createState() => _ImageSelectionScreenState();
}

class _ImageSelectionScreenState extends State<ImageSelectionScreen> {
  XFile? _imageFile;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildImageSelectionScreenAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildImageSelectionScreenHeader(),
              buildImageSelectionScreenSubHeader(),
              SizedBox(height: 80),
              buildCircularImageAvatar(context),
              SizedBox(height: 110),
              buildRegistrationCompletionMaterialButton(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget imageSelectionBottomSheet() {
    return Container(
      height: 180,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Center(
              child: Text(
                'Choose a profile picture',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          ListTile(
            title: Text(
              'Take a picture',
              style: GoogleFonts.inter(
                fontSize: 14,
              ),
            ),
            leading: Icon(CupertinoIcons.camera),
            minLeadingWidth: 10,
            onTap: () {
              Navigator.pop(context);
              selectImage(ImageSource.camera);
            },
          ),
          ListTile(
            title: Text(
              'Choose from gallery',
              style: GoogleFonts.inter(
                fontSize: 14,
              ),
            ),
            leading: Icon(CupertinoIcons.photo_on_rectangle),
            minLeadingWidth: 10,
            onTap: () {
              Navigator.pop(context);
              selectImage(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }

  MaterialButton buildRegistrationCompletionMaterialButton(
      BuildContext context) {
    return MaterialButton(
      onPressed: () {
        if (_imageFile == null) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  'Default Image',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: Text(
                  'Please select your own image',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Go back'),
                  )
                ],
              );
            },
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              duration: Duration(milliseconds: 5000),
              content: Container(
                color: Colors.transparent,
                child: Text(
                  'Signing Up...Please Wait',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 16.0,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          );
          var service = AuthService();
          service.userSignUp(
            widget.email!,
            widget.password!,
            widget.confirmPassword!,
            widget.firstName!,
            widget.lastName!,
            widget.contact!,
            widget.address!,
            _imageFile!.path,
            context,
          );
        }
      },
      elevation: 0,
      height: 50,
      minWidth: 300,
      textColor: Color(0xFFFFFFFF),
      color: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        'Finish Registration',
        style: GoogleFonts.inter(
          color: Color(0xFFFFFFFF),
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Center buildCircularImageAvatar(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Material(
            shape: CircleBorder(),
            elevation: 15,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  style: BorderStyle.solid,
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: CircleAvatar(
                radius: 120,
                backgroundImage: _imageFile == null
                    ? AssetImage("images/profile.png")
                    : FileImage(File(_imageFile!.path)) as ImageProvider,
              ),
            ),
          ),
          Positioned(
            top: 183.0,
            left: 170.0,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (_) => imageSelectionBottomSheet(),
                );
              },
              child: Container(
                height: 60.0,
                width: 60.0,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 2.0,
                    color: Colors.white,
                  ),
                ),
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 26.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void selectImage(ImageSource source) async {
    final pickedImage = await _imagePicker.pickImage(
      source: source,
      preferredCameraDevice: CameraDevice.front,
    );
    setState(() {
      _imageFile = pickedImage;
    });
  }

  Text buildImageSelectionScreenSubHeader() {
    return Text(
      'Select an image for your profile',
      style: GoogleFonts.inter(
        color: Colors.black45,
        fontSize: 12,
      ),
    );
  }

  Padding buildImageSelectionScreenHeader() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
      child: Text(
        'Completion',
        style: GoogleFonts.inter(
          color: Colors.black54,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  AppBar buildImageSelectionScreenAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.grey[50],
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
    );
  }
}
