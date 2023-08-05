import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String messageId;
  final String senderId;
  final String content;
  final DateTime timestamp;

  Message({
    required this.messageId,
    required this.senderId,
    required this.content,
    required this.timestamp,
  });

  factory Message.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Message(
      messageId: snapshot.id,
      senderId: data['senderId'],
      content: data['content'],
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }
}