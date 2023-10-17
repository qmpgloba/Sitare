import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String senderId;
  final String senderPhoneNumber;
  final String receiverId;
  final String message;
  final Timestamp timestamp;

  MessageModel(
      {required this.senderId,
      required this.senderPhoneNumber,
      required this.receiverId,
      required this.message,
      required this.timestamp});

  toJson() {
    return {
      'senderId': senderId,
      'sender phone number': senderPhoneNumber,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
