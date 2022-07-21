import 'package:chatapp/helpers/local_storage.dart';
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

  static Future<void> updateProifle({
    required String uid,
    required Map<String, dynamic> dataToUpdate,
  }) async {
    await Constants.usersCollection.doc(uid).update(dataToUpdate);
  }

  static Stream<List<UserModel>> getUsersStream() {
    return Constants.usersCollection
        .orderBy('name')
        .snapshots()
        .map((querySnapshot) {
      List<UserModel> retVal = [];
      for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
        UserModel userModel =
            UserModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
        if (userModel.uid != LocalStorage.readUser().uid) {
          retVal.add(userModel);
        }
      }
      return retVal;
    });
  }

  static Stream<UserModel> userDataStream(String uid) {
    return Constants.usersCollection
        .doc(uid)
        .snapshots()
        .map((documentSnapshot) {
      UserModel userModel =
          UserModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
      return userModel;
    });
  }
}
