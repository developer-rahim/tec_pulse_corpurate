import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tacpulse/models/directions.dart';
import 'package:tacpulse/models/response.dart';
import 'package:tacpulse/models/scribe.dart';
import 'package:tacpulse/models/task.dart';
import 'package:tacpulse/screens/chat_screen.dart';
import 'package:tacpulse/screens/dashboard_screen.dart';
import 'package:tacpulse/services/db_services.dart';
import 'package:tacpulse/services/directions_service.dart';

class HandOverScreen extends StatefulWidget {
  final Task? task;
  const HandOverScreen({Key? key, this.task}) : super(key: key);

  @override
  _HandOverScreenState createState() => _HandOverScreenState();
}

class _HandOverScreenState extends State<HandOverScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  TextEditingController _odoReadingController = TextEditingController();
  TextEditingController _newTargetLocController = TextEditingController();
  TextEditingController _noteController = TextEditingController();

  DbServices _dbServices = DbServices();
  late Future<List<Response>> _responses;
  late Future<List<Scribe>> _scribes;
  Scribe? _selectedScribe;

  XFile? _imageFile;
  final ImagePicker _imagePicker = ImagePicker();
  takeAPicture() async {
    final imageFromCamera =
        await _imagePicker.pickImage(source: ImageSource.camera);
    if (imageFromCamera != null) {
      setState(() {
        _imageFile = imageFromCamera;
      });
    }
  }

  String? _selectedServiceNote;
  String? _imageSelectedImageType = 'Scene Photo';

  Directions? _info;
  void _getDirectionsInfo(String? src, String? dest) async {
    List<Location> locationsSrc = await locationFromAddress(src!);
    Location srcLocation = locationsSrc[0];
    List<Location> locationsDest = await locationFromAddress(dest!);
    Location destLocation = locationsDest[0];

    LatLng source = LatLng(srcLocation.latitude, srcLocation.longitude);
    LatLng destination = LatLng(destLocation.latitude, destLocation.longitude);

    final directions = await DirectionsService()
        .getDirections(origin: source, destination: destination);
    setState(() {
      _info = directions;
    });
  }

  @override
  void initState() {
    _responses = _dbServices.fetchResponseDetails();
    _scribes = _dbServices.fetchScribes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(top: 2.0),
          child: Text(
            'Run ID: ' + widget.task!.parent!.runId.toString(),
            style: GoogleFonts.inter(
              color: Colors.black87,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Color(0xFFFFFFFF),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 4),
            child: IconButton(
              icon: Icon(Icons.cancel_outlined),
              color: Theme.of(context).primaryColor,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('Stop Responding', style: GoogleFonts.inter()),
                    content: Text(
                      'Do you want to stop responding to this task?',
                      style: GoogleFonts.inter(),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('No', style: GoogleFonts.inter()),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                            builder: (_) => DashboardScreen(),
                          ),
                        ),
                        child: Text(
                          'Yes',
                          style: GoogleFonts.inter(),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (_) => ChatScreen(
                task: widget.task,
              ),
            ),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        child: Icon(CupertinoIcons.chat_bubble_fill),
      ),
      body: FutureBuilder(
        future: Future.wait([
          _responses,
          _scribes,
        ]),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<Scribe> scribes = snapshot.data[1];
            List<Response> responses = snapshot.data[0]
                .where((response) => response.parent!.id == widget.task!.id)
                .toList();
            Response response = responses[0];
            return ListView(
              children: [
                _buildResponseDetailListItem(
                    'Your Location', response.medicLoc),
                // _buildResponseDetailListItem(
                //     'Target Location', response.targetLoc),
                // _buildResponseDetailListItem('Distance', response.dis),
                // _buildResponseDetailListItem('Duration', response.dur),
                _buildResponseDetailListItem(
                    'Current ODO Reading', response.odo.toString()),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 5),
                        child: MaterialButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                contentPadding: const EdgeInsets.all(10),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    FormBuilderDropdown(
                                      name: 'image_type',
                                      initialValue: 'Scene Photo',
                                      items: [
                                        DropdownMenuItem(
                                          value: 'Scene Photo',
                                          child: Text('Scene Photo'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'Document',
                                          child: Text('Other Document'),
                                        ),
                                      ],
                                      style: GoogleFonts.inter(
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.black12,
                                        hintText: 'Select note type',
                                        hintStyle: GoogleFonts.inter(),
                                        errorStyle: GoogleFonts.inter(
                                          fontSize: 10,
                                        ),
                                      ),
                                      onChanged: (val) {
                                        setState(() {
                                          _imageSelectedImageType =
                                              val.toString();
                                        });
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    _imageFile == null
                                        ? GestureDetector(
                                            onTap: () => takeAPicture(),
                                            child: Container(
                                              width: double.infinity,
                                              height: 200,
                                              decoration: BoxDecoration(
                                                color: Colors.black12,
                                                border: Border.all(
                                                  width: 1,
                                                  style: BorderStyle.solid,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.camera_alt,
                                                    color: Colors.grey.shade700,
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    'Take a picture',
                                                    style: GoogleFonts.inter(
                                                      fontSize: 13,
                                                      color:
                                                          Colors.grey.shade700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : Container(
                                            width: double.infinity,
                                            height: 200,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: FileImage(
                                                  File(_imageFile!.path),
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_imageFile == null) {
                                        Navigator.pop(context);
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            title: Text(
                                              'ERROR!',
                                              style: GoogleFonts.inter(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            content: Text(
                                              'No image was selected',
                                              style: GoogleFonts.inter(
                                                color: Colors.black45,
                                              ),
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  'Retry',
                                                  style: GoogleFonts.inter(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        Navigator.pop(context);
                                        _dbServices.addImage(
                                          context: context,
                                          id: widget.task!.parent!.id,
                                          imageType: _imageSelectedImageType,
                                          imagePath: _imageFile!.path,
                                        );
                                      }
                                    },
                                    child: Text(
                                      'Submit',
                                      style: GoogleFonts.inter(),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          color: Colors.blue.shade800,
                          height: 46,
                          minWidth: double.infinity,
                          child: Text(
                            'Add Images',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 10),
                        child: MaterialButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                contentPadding: const EdgeInsets.all(10),
                                content: FormBuilder(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      FormBuilderDropdown(
                                        name: 'service_note',
                                        items: [
                                          DropdownMenuItem(
                                              value: 'RESPONSE DELAY',
                                              child: Text('RESPONSE DELAY')),
                                          DropdownMenuItem(
                                              value: 'ON SCENE DELAY',
                                              child: Text('ON SCENE DELAY')),
                                          DropdownMenuItem(
                                              value: 'TRANSPORTING NOTES',
                                              child:
                                                  Text('TRANSPORTING NOTES')),
                                          DropdownMenuItem(
                                              value: 'HANDOVER DELAY',
                                              child: Text('HANDOVER DELAY')),
                                          DropdownMenuItem(
                                              value: 'SPECIAL RECORD',
                                              child: Text('SPECIAL RECORD')),
                                        ],
                                        style: GoogleFonts.inter(
                                          color: Colors.black,
                                        ),
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.black12,
                                          hintText: 'Select note type',
                                          hintStyle: GoogleFonts.inter(),
                                          errorStyle: GoogleFonts.inter(
                                            fontSize: 10,
                                          ),
                                        ),
                                        validator: (val) {
                                          if (val == null) {
                                            return 'Please select a service note type';
                                          } else {
                                            return null;
                                          }
                                        },
                                        onChanged: (val) {
                                          setState(() {
                                            _selectedServiceNote =
                                                val.toString();
                                          });
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      FormBuilderDropdown(
                                        name: 'scribe',
                                        items: scribes
                                            .map<DropdownMenuItem<Scribe>>(
                                              (Scribe scribe) =>
                                                  DropdownMenuItem(
                                                value: scribe,
                                                child: Text(
                                                  scribe.scribeName.toString(),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        style: GoogleFonts.inter(
                                          color: Colors.black,
                                        ),
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.black12,
                                          hintText: 'Select scribe',
                                          hintStyle: GoogleFonts.inter(),
                                          errorStyle: GoogleFonts.inter(
                                            fontSize: 10,
                                          ),
                                        ),
                                        validator: (val) {
                                          if (val == null) {
                                            return 'Please select a scribe';
                                          } else {
                                            return null;
                                          }
                                        },
                                        onChanged: (Scribe? scribe) {
                                          setState(() {
                                            _selectedScribe = scribe;
                                          });
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      FormBuilderTextField(
                                        name: 'note',
                                        controller: _noteController,
                                        style: GoogleFonts.inter(),
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.black12,
                                          hintText: 'Enter notes',
                                          hintStyle: GoogleFonts.inter(),
                                          errorStyle: GoogleFonts.inter(
                                            fontSize: 10,
                                          ),
                                        ),
                                        maxLines: 5,
                                        validator: (val) {
                                          if (val == null) {
                                            return 'Please enter a note';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        FocusScope.of(context).unfocus();
                                        Navigator.pop(context);
                                        _dbServices.addServiceNote(
                                          context: context,
                                          id: widget.task!.parent!.id,
                                          scribeId:
                                              _selectedScribe!.id.toString(),
                                          noteType: _selectedServiceNote,
                                          note: _noteController.text,
                                        );
                                        _noteController.clear();
                                      }
                                    },
                                    child: Text(
                                      'Submit',
                                      style: GoogleFonts.inter(),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                          color: Colors.blue.shade800,
                          height: 46,
                          minWidth: double.infinity,
                          child: Text(
                            'Add Notes',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          contentPadding: const EdgeInsets.all(10),
                          content: FormBuilder(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FormBuilderTextField(
                                  name: 'odo',
                                  controller: _odoReadingController,
                                  keyboardType: TextInputType.number,
                                  style: GoogleFonts.inter(fontSize: 14.0),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.black12,
                                    hintText: 'Enter vehicle ODO reading',
                                    hintStyle: GoogleFonts.inter(),
                                    errorStyle: GoogleFonts.inter(
                                      fontSize: 10,
                                    ),
                                  ),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'You must enter vehicle ODO reading';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                                FormBuilderTextField(
                                  name: 'target',
                                  controller: _newTargetLocController,
                                  style: GoogleFonts.inter(fontSize: 14.0),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.black12,
                                    hintText: 'Enter base address',
                                    hintStyle: GoogleFonts.inter(),
                                    errorStyle: GoogleFonts.inter(
                                      fontSize: 10,
                                    ),
                                  ),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'You must enter base address';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                // _getDirectionsInfo();
                                if (_formKey.currentState!.validate()) {
                                  FocusScope.of(context).unfocus();
                                  Navigator.pop(context);
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //   SnackBar(
                                  //     backgroundColor: Colors.transparent,
                                  //     elevation: 0,
                                  //     duration: Duration(milliseconds: 1700),
                                  //     content: Container(
                                  //       color: Theme.of(context).primaryColor,
                                  //       child: Text(
                                  //         'Submitting...',
                                  //         textAlign: TextAlign.center,
                                  //         style: GoogleFonts.inter(
                                  //           fontSize: 16.0,
                                  //           color: Colors.white,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // );
                                  _getDirectionsInfo(response.medicLoc,
                                      _newTargetLocController.text);
                                  DateTime time = DateTime.now();
                                  String _formattedActionTime =
                                      DateFormat('yyyy-MM-ddThh:mm:ss')
                                          .format(time);

                                  _dbServices.updateStatusToBackToBase(
                                    context: context,
                                    task: widget.task,
                                    parent: widget.task!.id.toString(),
                                    forCrew:
                                        widget.task!.forCrew!.id.toString(),
                                    medicLoc: response.medicLoc,
                                    targetLoc: _newTargetLocController.text,
                                    actionTime: _formattedActionTime,
                                    odo: _odoReadingController.text,
                                    dis: _info!.totalDistance,
                                    dur: _info!.totalDuration,
                                  );
                                }
                              },
                              child: Text('Submit', style: GoogleFonts.inter()),
                            )
                          ],
                        ),
                      );
                    },
                    height: 46,
                    minWidth: double.infinity,
                    color: Colors.black87,
                    child: Text(
                      'Return to Base',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildResponseDetailListItem(String? title, String? content) {
    return ListTile(
      title: Text(
        title.toString(),
        style: GoogleFonts.inter(
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      subtitle: Text(content.toString(),
          style: GoogleFonts.inter(color: Colors.black87)),
    );
  }
}
