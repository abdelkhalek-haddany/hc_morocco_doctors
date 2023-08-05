import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hc_morocco_doctors/enums/snackbar_message.dart';
import 'package:hc_morocco_doctors/screens/blog/widgets/widgets.dart';
import 'package:hc_morocco_doctors/themes/style.dart';
import '../../constants.dart';

final _firestore = FirebaseFirestore.instance;
String username = 'User';
String email = 'user@example.com';
String messageText = "";
var loggedInUser;

class ChatterScreen extends StatefulWidget {
  @override
  _ChatterScreenState createState() => _ChatterScreenState();
}

class _ChatterScreenState extends State<ChatterScreen> {
  final chatMsgTextController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getMessages();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser!;
      if (user != null) {
        loggedInUser = user;
        setState(() {
          username = loggedInUser.displayName;
          email = loggedInUser.email;
        });

        // setState(() {
        //   username = "abdelkhalek";
        //   email = "haddany@gmail.com";
        // });
      }
    } catch (e) {
      showSnackbar(SnackbarMessage.error, 'Unknown Error Occurred');
      // EdgeAlert.show(context,
      //     title: 'Something Went Wrong',
      //     description: e.toString(),
      //     gravity: EdgeAlert.BOTTOM,
      //     icon: Icons.error,
      //     backgroundColor: Colors.deepPurple[900]);
    }
  }

  void getMessages()async{
    final messages=await _firestore.collection('messages').get();
    for(var message in messages.docs){
      print(message.data);
    }
  }

  void messageStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      snapshot.docs;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(70),
                      border: Border.all(width: 2, color: Colors.blueGrey),
                    ),
                    child: Image.asset("assets/icons/doctor.png"),
                  ),
                  SizedBox(height: 10,),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Abdelkhalek HADDANY")
                          ]))
                ],
              )),
          ChatStream(),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: kMessageContainerDecoration,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Material(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                    elevation: 5,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, top: 2, bottom: 2),
                      child: TextField(
                        onChanged: (value) {
                          messageText = value;
                        },
                        controller: chatMsgTextController,
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                  ),
                ),
                MaterialButton(
                    shape: CircleBorder(),
                    color: primaryColor,
                    onPressed: () {
                      chatMsgTextController.clear();
                      _firestore.collection('messages').add({
                        'sender': username,
                        'text': messageText,
                        'timestamp': DateTime.now().millisecondsSinceEpoch,
                        'senderemail': email
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    )
                    // Text(
                    //   'Send',
                    //   style: kSendButtonTextStyle,
                    // ),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:
          _firestore.collection('messages').orderBy('timestamp').snapshots(),
      builder: (context, snapshot) {
        if (true) {
          final messages = [
            {
              'sender': 'abdelkhalek',
              'text':
                  "Lorem ipsum dolor sit amet consectetur adipisicing elit. Eaque neque vitae saepe voluptatum dolor commodi harum magnam, veritatis delectus reiciendis? Adipisci fuga sed nisi dolorum quia laudantium nam hic et?",
              'timestamp': DateTime.now().millisecondsSinceEpoch,
              'senderemail': email
            },
            {
              'sender': 'haddany',
              'text': "hello world",
              'timestamp': DateTime.now().millisecondsSinceEpoch,
              'senderemail': email
            },
            {
              'sender': username,
              'text': "hello world",
              'timestamp': DateTime.now().millisecondsSinceEpoch,
              'senderemail': email
            },
            {
              'sender': 'abdelkhalek',
              'text':
              "Lorem ipsum dolor sit amet consectetur adipisicing elit. Eaque neque vitae saepe voluptatum dolor commodi harum magnam, veritatis delectus reiciendis? Adipisci fuga sed nisi dolorum quia laudantium nam hic et?",
              'timestamp': DateTime.now().millisecondsSinceEpoch,
              'senderemail': email
            },
            {
              'sender': 'haddany',
              'text': "hello world",
              'timestamp': DateTime.now().millisecondsSinceEpoch,
              'senderemail': email
            },
            {
              'sender': username,
              'text': "hello world",
              'timestamp': DateTime.now().millisecondsSinceEpoch,
              'senderemail': email
            },
            {
              'sender': 'abdelkhalek',
              'text':
              "Lorem ipsum dolor sit amet consectetur adipisicing elit. Eaque neque vitae saepe voluptatum dolor commodi harum magnam, veritatis delectus reiciendis? Adipisci fuga sed nisi dolorum quia laudantium nam hic et?",
              'timestamp': DateTime.now().millisecondsSinceEpoch,
              'senderemail': email
            },
            {
              'sender': 'haddany',
              'text': "hello world",
              'timestamp': DateTime.now().millisecondsSinceEpoch,
              'senderemail': email
            },
            {
              'sender': username,
              'text': "hello world",
              'timestamp': DateTime.now().millisecondsSinceEpoch,
              'senderemail': email
            }
          ];
          List<MessageBubble> messageWidgets = [];
          for (var message in messages) {
            final msgText = message['text'];
            final msgSender = message['sender'];
            // final msgSenderEmail = message.data['senderemail'];
            // final currentUser = loggedInUser.displayName;
            final currentUser = "mohammed";
            // print('MSG'+msgSender + '  CURR'+currentUser);
            final msgBubble = MessageBubble(
                msgText: msgText.toString(),
                msgSender: msgSender.toString(),
                user: currentUser == msgSender);
            messageWidgets.add(msgBubble);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              children: messageWidgets,
            ),
          );
        } else {
          return Center(
            child:
                CircularProgressIndicator(backgroundColor: Colors.deepPurple),
          );
        }
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String msgText;
  final String msgSender;
  final bool user;

  MessageBubble(
      {required this.msgText, required this.msgSender, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment:
            user ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              msgSender,
              style: TextStyle(
                  fontSize: 13, fontFamily: 'Poppins', color: primaryColor),
            ),
          ),
          Material(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              topLeft: user ? Radius.circular(50) : Radius.circular(0),
              bottomRight: Radius.circular(50),
              topRight: user ? Radius.circular(0) : Radius.circular(50),
            ),
            color: user ? Colors.blue : Colors.white,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                msgText,
                style: TextStyle(
                  color: user ? Colors.white : Colors.black,
                  fontFamily: 'Poppins',
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
