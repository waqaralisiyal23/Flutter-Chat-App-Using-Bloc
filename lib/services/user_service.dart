import 'package:chatapp/models/user_model.dart';
import 'package:chatapp/res/res_exports.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class UserService {
  static Future<void> saveUser(UserModel userModel) async {
    await Constants.usersCollection.doc(userModel.uid).set(userModel.toMap());
  }

  static Future<UserModel?> getUserDetails(String uid) async {
    DocumentSnapshot documentSnapshot =
        await Constants.usersCollection.doc(uid).get();
    if (!documentSnapshot.exists) return null;
    UserModel userModel =
        UserModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
    return userModel;
  }
}
