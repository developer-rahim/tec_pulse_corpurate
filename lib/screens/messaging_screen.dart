// import 'dart:convert';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:tacpulse/models/message.dart';
// import 'package:tacpulse/globals.dart' as globals;

// class MessagingScreen extends StatefulWidget {
//   final int? receiverId;
//   final String? name;
//   MessagingScreen({this.receiverId, this.name});

//   @override
//   _MessagingScreenState createState() => _MessagingScreenState();
// }

// class _MessagingScreenState extends State<MessagingScreen> {
//   TextEditingController messageController = TextEditingController();

//   Future<List<Message>> fetchMessages() async {
//     var response = await http.get(
//       Uri.parse('https://tacpulse.animo-ai.co/api/chat/list/'),
//       headers: {
//         "Authorization": 'Token ' + globals.token,
//       },
//     );
//     if (response.statusCode == 200) {
//       List jsonData = jsonDecode(response.body);
//       return jsonData.map((data) => new Message.fromJson(data)).toList();
//     } else {
//       throw Exception('Failed to load messages');
//     }
//   }

//   Future sendMessage(String senderId, String receiverId, String message) async {
//     Map data = {
//       "sender": senderId,
//       "receiver": receiverId,
//       "message": message,
//     };
//     var response = await http.post(
//       Uri.parse('https://tacpulse.animo-ai.co/api/chat/'),
//       headers: {
//         "Authorization": 'Token ' + globals.token,
//       },
//       body: data,
//     );
//     if (response.statusCode == 200) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text(
//               'SUCCESS!',
//               style: GoogleFonts.inter(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             content: Text(
//               'Your message has been sent',
//               style: GoogleFonts.inter(
//                 fontSize: 14,
//               ),
//             ),
//             actions: [
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                   Navigator.pop(context);
//                 },
//                 child: Text('Okay'),
//               )
//             ],
//           );
//         },
//       );
//     } else {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text(
//               'FAILED',
//               style: GoogleFonts.inter(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             content: Text(
//               'Please try again',
//               style: GoogleFonts.inter(
//                 fontSize: 14,
//               ),
//             ),
//             actions: [
//               ElevatedButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text('Retry'),
//               )
//             ],
//           );
//         },
//       );
//     }
//   }

//   late Future<List<Message>> messages = fetchMessages();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//               title: Text(
//                 'Enter your message',
//                 style: GoogleFonts.inter(
//                   fontSize: 16.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               content: FormBuilder(
//                 child: FormBuilderTextField(
//                   name: 'message',
//                   controller: messageController,
//                   style: GoogleFonts.inter(
//                     fontSize: 14,
//                   ),
//                 ),
//               ),
//               actions: [
//                 ElevatedButton(
//                   onPressed: () {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         backgroundColor: Colors.transparent,
//                         elevation: 0,
//                         duration: Duration(milliseconds: 500),
//                         content: Container(
//                           color: Colors.transparent,
//                           child: Text(
//                             'Sending Message',
//                             textAlign: TextAlign.center,
//                             style: GoogleFonts.inter(
//                               fontSize: 16.0,
//                               color: Theme.of(context).primaryColor,
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                     sendMessage(globals.id!.toString(),
//                         widget.receiverId!.toString(), messageController.text);
//                     Navigator.pop(context);
//                   },
//                   child: Text(
//                     'Send',
//                     style: GoogleFonts.inter(),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//         backgroundColor: Theme.of(context).primaryColor,
//         label: Text(
//           ' Send Message',
//           style: GoogleFonts.inter(
//             color: Color(0xFFFFFFFF),
//             fontWeight: FontWeight.bold,
//             fontSize: 12,
//           ),
//         ),
//         icon: Icon(
//           FontAwesomeIcons.telegramPlane,
//           color: Color(0xFFFFFFFF),
//           size: 22,
//         ),
//       ),
//       appBar: AppBar(
//         title: Padding(
//           padding: EdgeInsets.only(top: 2.0),
//           child: Text(
//             widget.name.toString(),
//             style: GoogleFonts.inter(
//               color: Colors.black54,
//               fontSize: 20.0,
//             ),
//           ),
//         ),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         leading: Padding(
//           padding: EdgeInsets.only(left: 20.0),
//           child: IconButton(
//             icon: Icon(CupertinoIcons.chevron_left),
//             iconSize: 24.0,
//             color: Colors.black54,
//             focusColor: Colors.transparent,
//             highlightColor: Colors.transparent,
//             hoverColor: Colors.transparent,
//             splashColor: Colors.transparent,
//             onPressed: () => Navigator.pop(context),
//           ),
//         ),
//       ),
//       body: FutureBuilder(
//         future: messages,
//         builder: (context, AsyncSnapshot<dynamic> snapshot) {
//           if (snapshot.connectionState != ConnectionState.done) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasData) {
//             List<Message> data = snapshot.data;
//             return Padding(
//               padding: EdgeInsets.only(left: 20, right: 20, bottom: 80),
//               child: ListView.builder(
//                 physics: BouncingScrollPhysics(),
//                 itemCount: data.length,
//                 itemBuilder: (context, index) {
//                   if (data[index].receiverId == widget.receiverId &&
//                       data[index].senderId == globals.id) {
//                     return ListTile(
//                       title: Text(
//                         data[index].message.toString(),
//                         textAlign: TextAlign.end,
//                         style: GoogleFonts.inter(),
//                       ),
//                       subtitle: Text(
//                         'Sent: ' +
//                             data[index].sentTime.toString().substring(0, 10) +
//                             ' at ' +
//                             data[index].sentTime.toString().substring(11, 16),
//                         textAlign: TextAlign.end,
//                       ),
//                       trailing: CircleAvatar(
//                         backgroundImage: NetworkImage(
//                           data[index].senderProfilePic.toString(),
//                         ),
//                       ),
//                     );
//                   } else if (data[index].receiverId == globals.id &&
//                       data[index].senderId == widget.receiverId) {
//                     return ListTile(
//                       title: Text(
//                         data[index].message.toString(),
//                         style: GoogleFonts.inter(),
//                       ),
//                       subtitle: Text(
//                         'Sent: ' +
//                             data[index].sentTime.toString().substring(0, 10) +
//                             ' at ' +
//                             data[index].sentTime.toString().substring(11, 16),
//                       ),
//                       leading: CircleAvatar(
//                         backgroundImage: NetworkImage(
//                           data[index].senderProfilePic.toString(),
//                         ),
//                       ),
//                     );
//                   }
//                   return Container();
//                 },
//               ),
//             );
//           }
//           return Center(
//             child: Text(
//               'No messages',
//               style: GoogleFonts.inter(),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
