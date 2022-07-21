import 'package:chatapp/enums/message_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecentChat {
  final String chatUserId;
  final String messageSenderId;
  final String message;
  final MessageType messageType;
  final Timestamp timestamp;

  RecentChat({
    required this.chatUserId,
    required this.messageSenderId,
    required this.message,
    required this.messageType,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chatUserId': chatUserId,
      'messageSenderId': messageSenderId,
      'message': message,
      'messageType': messageType.type,
      'timestamp': timestamp,
    };
  }

  factory RecentChat.fromMap(Map<String, dynamic> map) {
    return RecentChat(
      chatUserId: map['chatUserId'] as String,
      messageSenderId: map['messageSenderId'] as String,
      message: map['message'] as String,
      messageType: (map['messageType'] as String).toMessageType(),
      timestamp: map['timestamp'] as Timestamp,
    );
  }
}
