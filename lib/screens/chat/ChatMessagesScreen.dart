import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hc_morocco_doctors/models/ChatMessageModel.dart';
import 'package:hc_morocco_doctors/models/UserModel.dart';
import 'package:hc_morocco_doctors/services/FirebaseHelper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class ChatMessagesScreen extends StatefulWidget {
  final String doctorId;

  ChatMessagesScreen({required this.doctorId});

  @override
  _ChatMessagesScreenState createState() => _ChatMessagesScreenState();
}

class _ChatMessagesScreenState extends State<ChatMessagesScreen> {
  TextEditingController _messageController = TextEditingController();
  final fireStoreUtils = FireStoreUtils();
  UserModel? user;
  final picker = ImagePicker(); // New instance of ImagePicker

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      auth.User? firebaseUser = auth.FirebaseAuth.instance.currentUser;
      print("There is a user");
      UserModel? userData =
          await FireStoreUtils.getUserByEmail(firebaseUser!.email.toString());
      print(userData!.toJson().toString());
      print("OOOOOOOOOOOOOOOOOOOOOOOOO");
      print(userData?.firstname);

      setState(() {
        user = userData;
      });
    } catch (e) {
      // Handle any exceptions that may occur during data fetching.
      print('Error fetching data: $e');
    }
  }

  void _sendMessage() {
    String messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      FirebaseFirestore.instance.collection('chat').add({
        'senderId': user!.id,
        'receiverId': widget.doctorId,
        'message': messageText,
        'imageUrl': '', // Use the image path or URL here
        'timestamp': FieldValue.serverTimestamp(),
        'isRead': false
      });
      _messageController.clear();
    }
  }

  // New method to handle image selection and sending
  Future<void> _sendImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      // You can upload the image to Firebase Storage and send its URL in the message
      // Alternatively, you can use Firebase Cloud Storage directly and store the URL in Firestore
      // For simplicity, let's just display the image in the chat for now without uploading it.
      FirebaseFirestore.instance.collection('chat').add({
        'senderId': user!.id,
        'receiverId': widget.doctorId,
        'message': '', // Empty message, as it's an image
        'imageUrl': imageFile.path, // Use the image path or URL here
        'timestamp': FieldValue.serverTimestamp(),
        'isRead': false
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('⚡ Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chat')
                  .where('senderId', whereIn: [user!.id, widget!.doctorId])
                  // .where('receiverId', whereIn: [user!.id,widget.doctorId])
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                List<ChatMessageModel> messages = snapshot.data!.docs
                    .map((doc) => ChatMessageModel(
                          senderId: doc['senderId'],
                          receiverId: doc['receiverId'],
                          message: doc['message'],
                          imageUrl: doc['imageUrl'],
                          // Get the image URL from Firestore
                          timestamp: (doc['timestamp'] as Timestamp).toDate(),
                          isRead: false,
                        ))
                    .toList();

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    if (messages[index].imageUrl != null && messages[index].imageUrl!.isNotEmpty) {
                      // If the message contains an image URL, display the image
                      return ListTile(
                        title: Text('Image'),
                        subtitle: Image.network(messages[index].imageUrl!),
                      );
                    } else {
                      // Otherwise, display the regular text message
                      return ListTile(
                        title: Text(messages[index].message),
                        subtitle: Text(messages[index].timestamp.toString()),
                      );
                    }
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.image),
                  onPressed:
                      _sendImage, // Call the _sendImage method when the image button is pressed
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
