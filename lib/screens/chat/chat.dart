import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  var loggedInUser;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser!;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
        print(loggedInUser.displayName);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(1,229, 243, 245),
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Stack(children: [
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  decoration: kMessageContainerDecoration,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            //Do something with the user input.
                          },
                          decoration: kMessageTextFieldDecoration,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          //Implement send functionality.
                        },
                        child: const Text(
                          'Send',
                          style: TextStyle(
                            color: Colors.lightBlueAccent,
                            fontSize: 20
                          ),

                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
