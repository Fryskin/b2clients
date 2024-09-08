import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderID;
  final String senderFullname;
  final String receiverID;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.senderID,
    required this.senderFullname,
    required this.receiverID,
    required this.message,
    required this.timestamp,
  });

  // convert to a map
  Map<String, dynamic> toMap() {
    return {
      'sender_id': senderID,
      'sender_fullname': senderFullname,
      'receiver_id': receiverID,
      'message': message,
      'timestamp': timestamp,
      'isRead': false,
    };
  }
}
