import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String messageId;
  final String senderId;
  final String receiverId;
  final String type;
  final String message;
  final Timestamp timestamp;
  final bool? isSender;

  Message({
    required this.messageId,
    required this.senderId,
    required this.receiverId,
    required this.type,
    required this.message,
    required this.timestamp,
    this.isSender,
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

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      messageId: map['messageId'] as String,
      senderId: map['senderId'] as String,
      receiverId: map['receiverId'] as String,
      type: map['type'] as String,
      message: map['message'] as String,
      timestamp: map['timestamp'] as Timestamp,
    );
  }

  Message copyWith({
    String? messageId,
    String? senderId,
    String? receiverId,
    String? type,
    String? message,
    Timestamp? timestamp,
    bool? isSender,
  }) {
    return Message(
      messageId: messageId ?? this.messageId,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      type: type ?? this.type,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      isSender: isSender ?? this.isSender,
    );
  }
}

List<Message> demeChatMessages = [
  Message(
    messageId: '1',
    senderId: 'W',
    receiverId: 'A',
    type: 'text',
    message: 'Hello',
    timestamp: Timestamp.now(),
  ),
  Message(
    messageId: '2',
    senderId: 'A',
    receiverId: 'W',
    type: 'text',
    message: 'Hello',
    timestamp: Timestamp.now(),
  ),
  Message(
    messageId: '3',
    senderId: 'W',
    receiverId: 'A',
    type: 'text',
    message: 'Hello',
    timestamp: Timestamp.now(),
  ),
  Message(
    messageId: '4',
    senderId: 'W',
    receiverId: 'A',
    type: 'text',
    message: 'Hello',
    timestamp: Timestamp.now(),
  ),
  Message(
    messageId: '5',
    senderId: 'A',
    receiverId: 'W',
    type: 'text',
    message: 'Hello',
    timestamp: Timestamp.now(),
  ),
  Message(
    messageId: '6',
    senderId: 'W',
    receiverId: 'A',
    type: 'text',
    message: 'Hello',
    timestamp: Timestamp.now(),
  ),
  Message(
    messageId: '7',
    senderId: 'A',
    receiverId: 'W',
    type: 'text',
    message: 'Hello',
    timestamp: Timestamp.now(),
  ),
  Message(
    messageId: '8',
    senderId: 'A',
    receiverId: 'W',
    type: 'text',
    message: 'h',
    timestamp: Timestamp.now(),
  ),
  Message(
    messageId: '9',
    senderId: 'A',
    receiverId: 'W',
    type: 'text',
    message:
        'Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello',
    timestamp: Timestamp.now(),
  ),
  Message(
    messageId: '10',
    senderId: 'W',
    receiverId: 'A',
    type: 'text',
    message:
        'Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello',
    timestamp: Timestamp.now(),
  ),
];
