import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class Constants {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Collections
  static final CollectionReference usersCollection =
      firestore.collection('users');
  static final CollectionReference messagesCollection =
      firestore.collection('messages');

  static CollectionReference recentChatCollection(String uid) {
    return firestore.collection('users').doc(uid).collection('recentChats');
  }

  // Strings
  static const String currentUserKey = 'currentUser';

  // UI
  static const double defaultPadding = 20.0;
}
