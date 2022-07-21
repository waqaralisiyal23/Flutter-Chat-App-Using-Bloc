import 'package:chatapp/helpers/local_storage.dart';
import 'package:chatapp/helpers/utils.dart';
import 'package:chatapp/models/message.dart';
import 'package:chatapp/models/recent_chat.dart';
import 'package:chatapp/res/res_exports.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class ChatService {
  static const String chatsCollection = 'chats';
  static const String messagesCollection = 'messages';

  static Future<void> saveMessage(Message message) async {
    // Add for sender
    await Constants.usersCollection
        .doc(message.senderId)
        .collection(chatsCollection)
        .doc(message.receiverId)
        .collection(messagesCollection)
        .doc(message.messageId)
        .set(message.toMap());

    // Add for receiver
    await Constants.usersCollection
        .doc(message.receiverId)
        .collection(chatsCollection)
        .doc(message.senderId)
        .collection(messagesCollection)
        .doc(message.messageId)
        .set(message.toMap());

    RecentChat addForSender = RecentChat(
      chatUserId: message.receiverId,
      messageSenderId: message.senderId,
      message: Utils.getLastMessageAccordingToMessageType(
        message.messageType,
        message.message,
      ),
      timestamp: message.timestamp,
      messageType: message.messageType,
    );

    RecentChat addForReceiver = RecentChat(
      chatUserId: message.senderId,
      messageSenderId: message.senderId,
      message: Utils.getLastMessageAccordingToMessageType(
        message.messageType,
        message.message,
      ),
      timestamp: message.timestamp,
      messageType: message.messageType,
    );

    await Constants.usersCollection
        .doc(message.senderId)
        .collection(chatsCollection)
        .doc(message.receiverId)
        .set(addForSender.toMap());

    await Constants.usersCollection
        .doc(message.receiverId)
        .collection(chatsCollection)
        .doc(message.senderId)
        .set(addForReceiver.toMap());
  }

  static Stream<List<Message>> getChatStream(String recieverUserId) {
    return Constants.usersCollection
        .doc(LocalStorage.readUser().uid)
        .collection(chatsCollection)
        .doc(recieverUserId)
        .collection(messagesCollection)
        .orderBy('timestamp')
        .snapshots()
        .map((querySnapshot) {
      List<Message> retVal = [];
      for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Message message =
            Message.fromMap(documentSnapshot.data() as Map<String, dynamic>);
        retVal.add(message);
      }
      return retVal;
    });
  }

  static Stream<List<RecentChat>> getRecentChatsStream() {
    return Constants.usersCollection
        .doc(LocalStorage.readUser().uid)
        .collection(chatsCollection)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((querySnapshot) {
      List<RecentChat> retVal = [];
      for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
        RecentChat recentChat =
            RecentChat.fromMap(documentSnapshot.data() as Map<String, dynamic>);
        retVal.add(recentChat);
      }
      return retVal;
    });
  }
}
