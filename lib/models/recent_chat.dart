import 'package:cloud_firestore/cloud_firestore.dart';

class RecentChat {
  final String messageId;
  final String senderId;
  final String receiverId;
  final String type;
  final String message;
  final Timestamp timestamp;

  RecentChat({
    required this.messageId,
    required this.senderId,
    required this.receiverId,
    required this.type,
    required this.message,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'messageId': messageId,
      'senderId': senderId,
      'receiverId': receiverId,
      'type': type,
      'message': message,
      'timestamp': timestamp,
    };
  }

  factory RecentChat.fromMap(Map<String, dynamic> map) {
    return RecentChat(
      messageId: map['messageId'] as String,
      senderId: map['senderId'] as String,
      receiverId: map['receiverId'] as String,
      type: map['type'] as String,
      message: map['message'] as String,
      timestamp: map['timestamp'] as Timestamp,
    );
  }
}
