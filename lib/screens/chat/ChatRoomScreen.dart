import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hc_morocco_doctors/models/Conversation.dart';
import 'package:hc_morocco_doctors/models/Message.dart';
import 'package:hc_morocco_doctors/services/FirebaseHelper.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;


class ChatRoomScreen extends StatefulWidget {
  final Conversation conversation;

  const ChatRoomScreen({Key? key, required this.conversation})
      : super(key: key);

  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final TextEditingController _messageController = TextEditingController();
  bool _isSendingMessage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.conversation.userName),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: FireStoreUtils.getMessages(widget.conversation.chatId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final messages = snapshot.data!;
                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return MessageWidget(message: message);
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _isSendingMessage ? null : _sendMessage,
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isNotEmpty) {
      setState(() {
        _isSendingMessage = true;
      });

      FireStoreUtils.sendMessage(
        widget.conversation.chatId,
        Message(
          senderId: auth.FirebaseAuth.instance.currentUser!.uid,
          content: message,
          timestamp: DateTime.now(),
          messageId: '',
        ),
      );

      _messageController.clear();
      setState(() {
        _isSendingMessage = false;
      });
    }
  }
}
class MessageWidget extends StatelessWidget {
  final Message message;

  const MessageWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isCurrentUser = message.senderId == auth.FirebaseAuth.instance.currentUser?.uid;
    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isCurrentUser ? Colors.blue : Colors.grey,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Text(
          message.content,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

