import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tacpulse/models/message.dart';
import 'package:tacpulse/models/task.dart';
import 'package:tacpulse/models/user.dart';
import 'package:tacpulse/services/db_services.dart';

class ChatScreen extends StatefulWidget {
  final Task? task;
  const ChatScreen({Key? key, this.task}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  DbServices _dbServices = DbServices();
  TextEditingController _messageController = TextEditingController();

  late Future<List<User>> _profileData;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var _storage = FlutterSecureStorage();
  String? _myEmail;
  _getMyEmail() async {
    String? email = await _storage.read(key: 'username');
    setState(() {
      _myEmail = email;
    });
  }

  Stream<List<Message>> _loadMessagesList() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      yield await _dbServices.fetchMessages(widget.task!.parent!.id!);
    }
  }

  @override
  void initState() {
    _getMyEmail();
    _profileData = _dbServices.getUserProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.only(top: 2.0),
            child: Text(
              'Chat Messagging',
              style: GoogleFonts.inter(
                color: Colors.black87,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          backgroundColor: Color(0xFFFFFFFF),
          centerTitle: false,
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
        body: FutureBuilder(
          future: _profileData,
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              List<User> profileData = snapshot.data;
              User user = profileData[0];
              return Container(
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: Material(
                        elevation: 20,
                        child: Container(
                          height: 80,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 15,
                              right: 5,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: FormBuilderTextField(
                                      name: 'message',
                                      controller: _messageController,
                                      style: GoogleFonts.inter(
                                        fontSize: 13,
                                      ),
                                      cursorColor: Colors.black87,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.grey[300],
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        focusedErrorBorder: InputBorder.none,
                                        hintText: 'Write your message here...',
                                        hintStyle: GoogleFonts.inter(
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                ElevatedButton(
                                  onPressed: () {
                                    if (_messageController.text != "") {
                                      FocusScope.of(context).unfocus();
                                      _dbServices.sendMessage(
                                        id: widget.task!.parent!.id,
                                        message: _messageController.text,
                                        senderId: user.id.toString(),
                                        context: _scaffoldKey.currentContext,
                                      );
                                      _messageController.clear();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    padding: const EdgeInsets.all(11),
                                  ),
                                  child: Icon(
                                    Icons.send,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    StreamBuilder<List<Message>>(
                      stream: _loadMessagesList(),
                      builder:
                          (context, AsyncSnapshot<List<Message>> snapshot) {
                        if (snapshot.hasData) {
                          List<Message> messages = snapshot.data!;
                          return Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              bottom: 80,
                            ),
                            child: ListView.builder(
                              padding: const EdgeInsets.only(
                                bottom: 5,
                                top: 5,
                              ),
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                if (messages[index].senderEmail != _myEmail) {
                                  return Container(
                                    margin: const EdgeInsets.only(
                                      top: 5,
                                      bottom: 5,
                                      left: 5,
                                      right: 60,
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 7.5,
                                      ),
                                      child: Text(
                                        messages[index].message.toString(),
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(15),
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container(
                                    margin: const EdgeInsets.only(
                                      top: 5,
                                      bottom: 5,
                                      right: 5,
                                      left: 60,
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 7.5,
                                      ),
                                      child: Text(
                                        messages[index].message.toString(),
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(15),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ],
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
