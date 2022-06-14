import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';

class AuditFormScreen extends StatefulWidget {
  @override
  AuditFormScreenState createState() => AuditFormScreenState();
}

class AuditFormScreenState extends State<AuditFormScreen> {
  final formKey = GlobalKey<FormBuilderState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController auditorController = TextEditingController();
  TextEditingController practitionerController = TextEditingController();
  TextEditingController transactionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController practitionerEmailController = TextEditingController();
  TextEditingController practitionerQualificationController =
      TextEditingController();
  TextEditingController previousAuditController = TextEditingController();
  TextEditingController prevAuditSpecialNoteController =
      TextEditingController();
  TextEditingController signatureController = TextEditingController();
  String? medicalIssue;
  String? expiredDrugs;

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
          physics: BouncingScrollPhysics(),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: FormBuilder(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormBuilderTextField(
                      name: 'name',
                      controller: nameController,
                      style: GoogleFonts.inter(fontSize: 12.0),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 22.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        hintText: 'Enter name',
                        labelText: 'Name',
                        labelStyle: GoogleFonts.inter(
                          fontSize: 12.0,
                        ),
                        prefixIcon: Icon(
                          CupertinoIcons.info,
                          size: 22,
                        ),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'This field cannot be empty' : null,
                    ),
                    SizedBox(height: 10),
                    FormBuilderTextField(
                      name: 'auditor',
                      controller: auditorController,
                      style: GoogleFonts.inter(fontSize: 12.0),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 22.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        hintText: 'Enter auditor\'s name',
                        labelText: 'Auditor\'s Name',
                        labelStyle: GoogleFonts.inter(
                          fontSize: 12.0,
                        ),
                        prefixIcon: Icon(
                          CupertinoIcons.info,
                          size: 22,
                        ),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'This field cannot be empty' : null,
                    ),
                    SizedBox(height: 10),
                    FormBuilderTextField(
                      name: 'practitioner',
                      controller: practitionerController,
                      style: GoogleFonts.inter(fontSize: 12.0),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 22.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        hintText: 'Enter practitioner\'s username',
                        labelText: 'Practitioner\'s Name',
                        labelStyle: GoogleFonts.inter(
                          fontSize: 12.0,
                        ),
                        prefixIcon: Icon(
                          CupertinoIcons.info,
                          size: 22,
                        ),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'This field cannot be empty' : null,
                    ),
                    SizedBox(height: 10),
                    FormBuilderTextField(
                      name: 'transaction',
                      controller: transactionController,
                      style: GoogleFonts.inter(fontSize: 12.0),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 22.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        hintText: 'Enter transaction amount',
                        labelText: 'Transaction',
                        labelStyle: GoogleFonts.inter(
                          fontSize: 12.0,
                        ),
                        prefixIcon: Icon(
                          CupertinoIcons.info,
                          size: 22,
                        ),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'This field cannot be empty' : null,
                    ),
                    SizedBox(height: 10),
                    FormBuilderDateTimePicker(
                      name: 'date',
                      controller: dateController,
                      inputType: InputType.date,
                      style: GoogleFonts.inter(fontSize: 12.0),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 22.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        hintText: 'Select date',
                        labelText: 'Date',
                        labelStyle: GoogleFonts.inter(
                          fontSize: 12.0,
                        ),
                        prefixIcon: Icon(
                          CupertinoIcons.calendar,
                          size: 22,
                        ),
                      ),
                      validator: (value) =>
                          value == null ? 'This field cannot be empty' : null,
                    ),
                    SizedBox(height: 10),
                    FormBuilderTextField(
                      name: 'practitioner_email',
                      controller: practitionerEmailController,
                      keyboardType: TextInputType.emailAddress,
                      style: GoogleFonts.inter(fontSize: 12.0),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 22.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        hintText: 'Enter practitioner\'s email',
                        labelText: 'Practitioner\'s Email',
                        labelStyle: GoogleFonts.inter(
                          fontSize: 12.0,
                        ),
                        prefixIcon: Icon(
                          CupertinoIcons.envelope,
                          size: 22,
                        ),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'This field cannot be empty' : null,
                    ),
                    SizedBox(height: 10),
                    FormBuilderTextField(
                      name: 'practitioner_qualification',
                      controller: practitionerQualificationController,
                      style: GoogleFonts.inter(fontSize: 12.0),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 22.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        hintText: 'Enter practitioner\'s qualification',
                        labelText: 'Practitioner\'s Qualification',
                        labelStyle: GoogleFonts.inter(
                          fontSize: 12.0,
                        ),
                        prefixIcon: Icon(
                          CupertinoIcons.info,
                          size: 22,
                        ),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'This field cannot be empty' : null,
                    ),
                    SizedBox(height: 10),
                    FormBuilderDateTimePicker(
                      name: 'previous_audit_date',
                      controller: previousAuditController,
                      style: GoogleFonts.inter(fontSize: 12.0),
                      inputType: InputType.date,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 22.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        hintText: 'Enter previous audit date',
                        labelText: 'Previous Audit Date',
                        labelStyle: GoogleFonts.inter(
                          fontSize: 12.0,
                        ),
                        prefixIcon: Icon(
                          CupertinoIcons.calendar,
                          size: 22,
                        ),
                      ),
                      validator: (value) =>
                          value == null ? 'This field cannot be empty' : null,
                    ),
                    SizedBox(height: 10),
                    FormBuilderTextField(
                      name: 'previous_audit_note',
                      controller: prevAuditSpecialNoteController,
                      style: GoogleFonts.inter(fontSize: 12.0),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 22.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        hintText: 'Enter previous audit note',
                        labelText: 'Previous Audit Note',
                        labelStyle: GoogleFonts.inter(
                          fontSize: 12.0,
                        ),
                        prefixIcon: Icon(
                          CupertinoIcons.info,
                          size: 22,
                        ),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'This field cannot be empty' : null,
                    ),
                    SizedBox(height: 10),
                    FormBuilderDropdown(
                      name: 'medical_issue',
                      items: [
                        DropdownMenuItem(
                          child: Text('Yes'),
                          value: true,
                        ),
                        DropdownMenuItem(
                          child: Text('No'),
                          value: false,
                        ),
                      ],
                      style: GoogleFonts.inter(
                        fontSize: 12.0,
                        color: Colors.black54,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                          top: 10.0,
                          bottom: 10.0,
                          left: 22.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        hintText: 'Any medical issue?',
                        labelText: 'Medical Issue',
                        labelStyle: GoogleFonts.inter(
                          fontSize: 12.0,
                        ),
                        prefixIcon: Icon(
                          CupertinoIcons.info,
                          size: 22,
                        ),
                      ),
                      validator: (value) =>
                          value == null ? 'This field cannot be empty' : null,
                      onChanged: (value) {
                        setState(() {
                          medicalIssue = value.toString();
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    FormBuilderDropdown(
                      name: 'expired_drugs',
                      items: [
                        DropdownMenuItem(
                          child: Text('Yes'),
                          value: true,
                        ),
                        DropdownMenuItem(
                          child: Text('No'),
                          value: false,
                        ),
                      ],
                      style: GoogleFonts.inter(
                        fontSize: 12.0,
                        color: Colors.black54,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                          top: 10.0,
                          bottom: 10.0,
                          left: 22.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        hintText: 'Any expired drugs?',
                        labelText: 'Expired Drugs',
                        labelStyle: GoogleFonts.inter(
                          fontSize: 12.0,
                        ),
                        prefixIcon: Icon(
                          CupertinoIcons.info,
                          size: 22,
                        ),
                      ),
                      validator: (value) =>
                          value == null ? 'This field cannot be empty' : null,
                      onChanged: (value) {
                        setState(() {
                          expiredDrugs = value.toString();
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    FormBuilderTextField(
                      name: 'signature',
                      controller: signatureController,
                      keyboardType: TextInputType.emailAddress,
                      style: GoogleFonts.inter(fontSize: 12.0),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 22.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        hintText: 'Enter your signature',
                        labelText: 'Signature',
                        labelStyle: GoogleFonts.inter(
                          fontSize: 12.0,
                        ),
                        prefixIcon: Icon(
                          CupertinoIcons.signature,
                          size: 22,
                        ),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'This field cannot be empty' : null,
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: MaterialButton(
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
            ),
          ],
        ),
      ),
    );
  }
}
