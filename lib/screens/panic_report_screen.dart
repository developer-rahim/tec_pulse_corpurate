// import 'dart:convert';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_geocoder/geocoder.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:tacpulse/models/user.dart';
// import 'package:http/http.dart' as http;
// import 'package:tacpulse/globals.dart' as globals;

// class PanicReportScreen extends StatefulWidget {
//   @override
//   _PanicReportScreenState createState() => _PanicReportScreenState();
// }

// class _PanicReportScreenState extends State<PanicReportScreen> {
//   final _formKey = GlobalKey<FormBuilderState>();
//   TextEditingController emergencyContactController = TextEditingController();
//   TextEditingController reasonController = TextEditingController();

//   Future<List<User>> getUserProfileData() async {
//     final response = await http.get(
//         Uri.parse('https://tacpulse.animo-ai.co/api/profile/'),
//         headers: {"Authorization": 'Token ' + globals.token});
//     if (response.statusCode == 200) {
//       List jsonResponse = jsonDecode(response.body);
//       return jsonResponse.map((data) => new User.fromJson(data)).toList();
//     } else {
//       throw Exception('Failed to load profile data');
//     }
//   }

//   Future sendPanicRequest(String panicSender, String emergencyContact,
//       String reason, String place, String lat, String lng) async {
//     Map data = {
//       'panic_sender': panicSender,
//       'emergency_contact': emergencyContact,
//       'reason': reason,
//       'place': place,
//       'lat': lat,
//       'lng': lng,
//     };
//     var response = await http.post(
//       Uri.parse('https://tacpulse.animo-ai.co/api/panic/crerate/'),
//       headers: {
//         "Authorization": 'Token ' + globals.token,
//       },
//       body: data,
//     );
//     if (response.statusCode == 200) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//           title: Text(
//             'SUCCESS',
//             style: GoogleFonts.inter(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           content: Text(
//             'Panic request sent!',
//             style: GoogleFonts.inter(
//               color: Colors.black45,
//             ),
//           ),
//           actions: [
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 Navigator.pop(context);
//               },
//               child: Text(
//                 'Okay',
//                 style: GoogleFonts.inter(),
//               ),
//             ),
//           ],
//         ),
//       );
//     } else {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//           title: Text(
//             'ERROR!',
//             style: GoogleFonts.inter(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           content: Text(
//             response.reasonPhrase.toString(),
//             style: GoogleFonts.inter(
//               color: Colors.black45,
//             ),
//           ),
//           actions: [
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text(
//                 'Retry',
//                 style: GoogleFonts.inter(),
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//   }

//   late Future<List<User>> profileData;

//   Set<Marker> _markerSet = {};
//   var currentPosition;
//   var currentAddress;
//   var addressList;
//   var firstAddress;

//   void _getUserLocation() async {
//     Position position = await Geolocator.getCurrentPosition();
//     addressList = await Geocoder.local.findAddressesFromCoordinates(
//         Coordinates(position.latitude, position.longitude));
//     firstAddress = addressList.first;
//     setState(() {
//       currentPosition = LatLng(position.latitude, position.longitude);
//       currentAddress = firstAddress.addressLine;
//     });
//   }

//   void _onMapCreated(GoogleMapController _controller) async {
//     setState(() {
//       _markerSet.add(
//         Marker(
//           markerId: MarkerId('loc'),
//           position: currentPosition,
//         ),
//       );
//     });
//   }

//   Future _updateAddressDetails(LatLng coords) async {
//     addressList = await Geocoder.local.findAddressesFromCoordinates(
//         Coordinates(coords.latitude, coords.longitude));
//     setState(() {
//       firstAddress = addressList.first;
//       currentAddress = firstAddress.addressLine;
//     });
//   }

//   void _onAddNewMarkerAction(LatLng coords) {
//     setState(
//       () {
//         currentPosition = coords;
//         _updateAddressDetails(coords);
//         _markerSet.add(
//           Marker(
//             markerId: MarkerId('newLoc'),
//             position: coords,
//           ),
//         );
//       },
//     );
//   }

//   @override
//   void initState() {
//     _getUserLocation();
//     profileData = getUserProfileData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Padding(
//             padding: EdgeInsets.only(top: 2.0),
//             child: Text(
//               'Panic Request',
//               style: GoogleFonts.inter(
//                 color: Colors.black54,
//                 fontSize: 20.0,
//               ),
//             ),
//           ),
//           centerTitle: true,
//           elevation: 0,
//           backgroundColor: Color(0xFFFFFFFF),
//           leading: Padding(
//             padding: EdgeInsets.only(left: 20.0),
//             child: IconButton(
//               icon: Icon(Icons.arrow_back_ios),
//               iconSize: 20.0,
//               color: Colors.black54,
//               focusColor: Colors.transparent,
//               highlightColor: Colors.transparent,
//               hoverColor: Colors.transparent,
//               splashColor: Colors.transparent,
//               onPressed: () => Navigator.pop(context),
//             ),
//           ),
//         ),
//         body: FutureBuilder<List<User>>(
//           future: profileData,
//           builder: (context, AsyncSnapshot<dynamic> snapshot) {
//             if (snapshot.connectionState != ConnectionState.done) {
//               return Center(child: CircularProgressIndicator());
//             }
//             if (snapshot.hasData) {
//               List<User> data = snapshot.data;
//               return currentPosition == null
//                   ? Center(child: CircularProgressIndicator())
//                   : ListView(
//                       physics: BouncingScrollPhysics(),
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 20, horizontal: 28),
//                           child: Container(
//                             height: 400,
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                 style: BorderStyle.solid,
//                                 width: 1,
//                                 color: Colors.black45.withOpacity(0.1),
//                               ),
//                             ),
//                             child: Stack(
//                               children: [
//                                 GoogleMap(
//                                   onMapCreated: _onMapCreated,
//                                   zoomControlsEnabled: false,
//                                   mapToolbarEnabled: false,
//                                   initialCameraPosition: CameraPosition(
//                                     target: currentPosition,
//                                     zoom: 18.5,
//                                   ),
//                                   onTap: (coords) {
//                                     if (_markerSet.length >= 1) {
//                                       _markerSet.clear();
//                                     }
//                                     _onAddNewMarkerAction(coords);
//                                     print(currentAddress);
//                                   },
//                                   markers: _markerSet,
//                                 ),
//                                 Align(
//                                   alignment: Alignment.bottomCenter,
//                                   child: Container(
//                                     margin: EdgeInsets.only(
//                                         left: 10, right: 10, bottom: 10),
//                                     height: 60,
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       border: Border.all(
//                                         width: 1,
//                                         style: BorderStyle.solid,
//                                         color: Colors.black45.withOpacity(0.1),
//                                       ),
//                                       borderRadius: BorderRadius.circular(10.0),
//                                     ),
//                                     child: ListTile(
//                                       title: Text(
//                                         currentAddress,
//                                         style: GoogleFonts.inter(
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                       leading:
//                                           Icon(CupertinoIcons.location_solid),
//                                       minLeadingWidth: 10,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 28),
//                           child: FormBuilder(
//                             key: _formKey,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 FormBuilderTextField(
//                                   name: 'emergency_contact',
//                                   controller: emergencyContactController,
//                                   keyboardType: TextInputType.phone,
//                                   style: GoogleFonts.inter(fontSize: 12.0),
//                                   decoration: InputDecoration(
//                                     contentPadding: EdgeInsets.symmetric(
//                                       vertical: 10.0,
//                                       horizontal: 22.0,
//                                     ),
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(10.0),
//                                     ),
//                                     hintText: 'Enter your emergency contact',
//                                     hintStyle: GoogleFonts.inter(),
//                                     labelStyle: GoogleFonts.inter(
//                                       fontSize: 12.0,
//                                     ),
//                                     errorStyle: GoogleFonts.inter(
//                                       fontSize: 10,
//                                     ),
//                                     prefixIcon: Icon(
//                                       CupertinoIcons.device_phone_portrait,
//                                       size: 22.0,
//                                     ),
//                                   ),
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return 'This field cannot be empty';
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                                 SizedBox(height: 10),
//                                 FormBuilderTextField(
//                                   name: 'reason',
//                                   controller: reasonController,
//                                   style: GoogleFonts.inter(fontSize: 12.0),
//                                   decoration: InputDecoration(
//                                     contentPadding: EdgeInsets.symmetric(
//                                       vertical: 10.0,
//                                       horizontal: 22.0,
//                                     ),
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(10.0),
//                                     ),
//                                     hintText: 'Enter your reason of emergency',
//                                     hintStyle: GoogleFonts.inter(),
//                                     labelStyle: GoogleFonts.inter(
//                                       fontSize: 12.0,
//                                     ),
//                                     errorStyle: GoogleFonts.inter(
//                                       fontSize: 10,
//                                     ),
//                                     prefixIcon: Icon(
//                                       CupertinoIcons.question_circle_fill,
//                                       size: 22.0,
//                                     ),
//                                   ),
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return 'This field cannot be empty';
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 40),
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 28),
//                           child: MaterialButton(
//                             onPressed: () {
//                               if (_formKey.currentState!.validate()) {
//                                 FocusScope.of(context).unfocus();
//                                 LatLng coords = currentPosition;
//                                 String id = data[0].id.toString();
//                                 sendPanicRequest(
//                                   id,
//                                   emergencyContactController.text,
//                                   reasonController.text,
//                                   currentAddress!.toString(),
//                                   coords.latitude.toString(),
//                                   coords.longitude.toString(),
//                                 );
//                               }
//                             },
//                             elevation: 0,
//                             height: 50,
//                             minWidth: 200,
//                             textColor: Color(0xFFFFFFFF),
//                             color: Theme.of(context).primaryColor,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             child: Text(
//                               'Confirm',
//                               style: GoogleFonts.inter(
//                                 color: Color(0xFFFFFFFF),
//                                 fontSize: 18.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                       ],
//                     );
//             }
//             return Center(child: CircularProgressIndicator());
//           },
//         ),
//       ),
//     );
//   }
// }
