
import 'package:cloud_firestore/cloud_firestore.dart';

class Conversation {
  final String chatId;
  final String userImage;
  final String userName;
  final String lastMessage;
  final DateTime timestamp;

  Conversation({
    required this.chatId,
    required this.userImage,
    required this.userName,
    required this.lastMessage,
    required this.timestamp,
  });

  factory Conversation.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Conversation(
      chatId: snapshot.id,
      userImage: data['userImage'],
      userName: data['userName'],
      lastMessage: data['lastMessage'],
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }
}