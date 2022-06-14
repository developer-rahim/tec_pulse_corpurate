import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tacpulse/models/directions.dart';
import 'package:tacpulse/models/task.dart';
import 'package:tacpulse/screens/dashboard_screen.dart';
import 'package:tacpulse/services/db_services.dart';
import 'package:tacpulse/services/directions_service.dart';

class TaskDetailsScreen extends StatefulWidget {
  final Task? task;
  TaskDetailsScreen({this.task});

  @override
  _TaskDetailsScreenState createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  DbServices _dbServices = DbServices();
  TextEditingController _odoReadingController = TextEditingController();

  var _currentPosition;
  var _currentAddress;
  var _addressList;
  Placemark? _firstAddress;
  Directions? _info;

  void _getDirectionsInfo(LatLng src, LatLng dest) async {
    final directions =
        await DirectionsService().getDirections(origin: src, destination: dest);
    setState(() {
      _info = directions;
    });
  }

  _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    // _addressList = await Geocoder.local.findAddressesFromCoordinates(
    //     Coordinates(position.latitude, position.longitude));
    // _firstAddress = _addressList.first;
    _addressList =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    _firstAddress = _addressList[0];
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _currentAddress = _firstAddress!.street! +
          ', ' +
          _firstAddress!.locality! +
          ', ' +
          _firstAddress!.administrativeArea! +
          ', ' +
          _firstAddress!.country!;
    });

    List<Location> locations =
        await locationFromAddress(widget.task!.parent!.pickUpAddress!);
    Location location = locations[0];

    LatLng dest = LatLng(location.latitude, location.longitude);
    _getDirectionsInfo(_currentPosition, dest);
  }

  @override
  void initState() {
    Timer(Duration(seconds: 5), () {
      _getUserLocation();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(top: 2.0),
          child: Text(
            'Task Details',
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
      body: _currentPosition == null
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                _buildTaskDetailListItem(
                    'Run ID', widget.task!.parent!.runId.toString()),
                _buildTaskDetailListItem('Authorization No.',
                    widget.task!.parent!.authorizationNumber.toString()),
                _buildTaskDetailListItem(
                    'Caller Name', widget.task!.parent!.callerName.toString()),
                _buildTaskDetailListItem('Caller Contact No.',
                    widget.task!.parent!.callerNumber.toString()),
                _buildTaskDetailListItem('Pickup Address',
                    widget.task!.parent!.pickUpAddress.toString()),
                _buildTaskDetailListItem('Reason of Emergency',
                    widget.task!.parent!.panic?.reason.toString()),
                _buildTaskDetailListItem('Assigned Unit',
                    widget.task!.forCrew!.assignedUnit!.uniName.toString()),
                _buildTaskDetailListItem(
                    'Senior', widget.task!.forCrew!.senior!.toString()),
                _buildTaskDetailListItem(
                    'Assist 1', widget.task!.forCrew!.assist01!.toString()),
                widget.task!.forCrew!.assist02 != null
                    ? _buildTaskDetailListItem(
                        'Assist 2', widget.task!.forCrew!.assist02!.toString())
                    : Container(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
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
                                  DateTime time = DateTime.now();
                                  String _formattedActionTime =
                                      DateFormat('yyyy-MM-ddThh:mm:ss')
                                          .format(time);
                                  _dbServices.respondToTask(
                                    context: context,
                                    task: widget.task,
                                    parent: widget.task!.id.toString(),
                                    forCrew:
                                        widget.task!.forCrew!.id.toString(),
                                    medicLoc: _currentAddress,
                                    targetLoc:
                                        widget.task!.parent!.pickUpAddress,
                                    actionTime: _formattedActionTime,
                                    odo: _odoReadingController.text,
                                    dis: _info!.totalDistance.toString(),
                                    dur: _info!.totalDuration.toString(),
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
                      'Respond',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildTaskDetailListItem(String? title, String? content) {
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
