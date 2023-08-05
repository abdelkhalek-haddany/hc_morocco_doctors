import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hc_morocco_doctors/screens/chat/ChatRoomScreen.dart';

import '../../models/Conversation.dart';
import '../../services/FirebaseHelper.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
      body: StreamBuilder<List<Conversation>>(
        stream: FireStoreUtils.getConversations(), // Your method to fetch conversations from Firestore
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final conversations = snapshot.data!;
            return ListView.builder(
              itemCount: conversations.length,
              itemBuilder: (context, index) {
                final conversation = conversations[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(conversation.userImage),
                  ),
                  title: Text(conversation.userName),
                  subtitle: Text(conversation.lastMessage),
                  trailing: Text(conversation.timestamp.toString()),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatRoomScreen(
                          // Pass the necessary data to the chat room screen
                          conversation: conversation,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
