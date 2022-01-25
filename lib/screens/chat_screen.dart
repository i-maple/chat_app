import 'package:chat_app/components/text_input.dart';
import 'package:chat_app/utils/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static const routeId = 'chat_screen';
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

var loggedInUser;

class _ChatScreenState extends State<ChatScreen> {
  final _firestore = FirebaseFirestore.instance;
  String messageText = '';
  bool buttonEnabled = false;
  int id = 1;
  final editingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  final _auth = FirebaseAuth.instance;
  void getCurrentUser() async {
    var myCurrentUser = await _auth.currentUser;
    if (myCurrentUser != null) {
      loggedInUser = myCurrentUser;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          leading: null,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () async {
                  var signOut = await _auth.signOut();
                  try {
                    Navigator.pop(context);
                  } catch (e) {
                    print(e);
                  }
                }),
          ],
          title: Text('⚡️Chat'),
          backgroundColor: Colors.lightBlueAccent,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('messages')
                    .orderBy("id", descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  final messageData = snapshot.data!.docs.reversed;
                  if (snapshot.hasData) {
                    List<MessageBubble> textWidgets = [];
                    for (var messages in messageData) {
                      String messageText = messages.get('message');
                      String sender = messages.get('sender');
                      int highestId = messages.get('id');

                      id = highestId;

                      textWidgets.add(MessageBubble(
                        sender: sender,
                        message: messageText,
                        isMe: sender == _auth.currentUser?.email,
                      ));
                    }
                    return Expanded(
                      child: ListView(
                        reverse: true,
                        children: textWidgets,
                      ),
                    );
                  }
                  throw ('Error');
                },
              ),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextInputWidget(
                          controller: editingController,
                          onChanged: (value) {
                            setState(() {
                              if (value != null) {
                                buttonEnabled = true;
                              }
                            });
                            messageText = value;
                          },
                          hintText: 'Message',
                          icon: Icons.message,
                          isPassword: false),
                    ),
                    TextButton(
                      onPressed: buttonEnabled
                          ? () async {
                              if (messageText != null) {
                                var storeMessage = await _firestore
                                    .collection('messages')
                                    .add({
                                  'sender': _auth.currentUser?.email,
                                  'message': messageText,
                                  'id' : id+1,
                                });
                              }
                            }
                          : null,
                      child: Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble(
      {required this.sender, required this.message, required this.isMe});

  final String sender;
  final String message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.topRight : Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              sender,
              style: TextStyle(color: Colors.grey),
            ),
            Align(
              alignment: isMe ? Alignment.topRight : Alignment.topLeft,
              child: Material(
                borderRadius: isMe
                    ? BorderRadius.circular(30.0)
                        .copyWith(topRight: Radius.circular(0.0))
                    : BorderRadius.circular(30.0)
                        .copyWith(topLeft: Radius.circular(0.0)),
                elevation: 12.0,
                color: isMe ? Colors.lightBlue : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    message,
                    style: TextStyle(
                        color: isMe ? Colors.white : Colors.black,
                        fontSize: 16.0),
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
