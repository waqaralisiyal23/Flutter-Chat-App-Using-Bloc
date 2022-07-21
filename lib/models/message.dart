import 'package:chatapp/enums/message_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String messageId;
  final String senderId;
  final String receiverId;
  final MessageType messageType;
  final String message;
  final Timestamp timestamp;
  final bool? isSender;

  Message({
    required this.messageId,
    required this.senderId,
    required this.receiverId,
    required this.messageType,
    required this.message,
    required this.timestamp,
    this.isSender,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'messageId': messageId,
      'senderId': senderId,
      'receiverId': receiverId,
      'messageType': messageType.type,
      'message': message,
      'timestamp': timestamp,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      messageId: map['messageId'] as String,
      senderId: map['senderId'] as String,
      receiverId: map['receiverId'] as String,
      messageType: (map['messageType'] as String).toMessageType(),
      message: map['message'] as String,
      timestamp: map['timestamp'] as Timestamp,
    );
  }

  Message copyWith({
    String? messageId,
    String? senderId,
    String? receiverId,
    MessageType? messageType,
    String? message,
    Timestamp? timestamp,
    bool? isSender,
  }) {
    return Message(
      messageId: messageId ?? this.messageId,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      messageType: messageType ?? this.messageType,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      isSender: isSender ?? this.isSender,
    );
  }
}
