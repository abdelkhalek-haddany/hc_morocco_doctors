import 'package:hc_morocco_doctors/models/UserModel.dart';
import 'package:hc_morocco_doctors/services/FirebaseHelper.dart';

class ChatMessageModel {
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime timestamp;
  final String imageUrl;
  final bool isRead;

  ChatMessageModel({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timestamp,
    required this.isRead,
    required this.imageUrl,
  });

  Future<UserModel?> sender() async {
    UserModel? user;
    try {
      user = await FireStoreUtils.getUserById(this.senderId);
    } catch (e) {
      print("erroooooooooooooooooooooor");
    }
    return user;
  }

  Future<UserModel?> receiver() async {
    UserModel? user;
    try {
      user = await FireStoreUtils.getUserById(this.receiverId);
    } catch (e) {
      print("erroooooooooooooooooooooor");
    }
    return user;
  }
}
