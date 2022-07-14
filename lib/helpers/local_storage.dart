import 'dart:convert';
import 'package:chatapp/models/user_model.dart';
import 'package:chatapp/res/res_exports.dart';
import 'package:get_storage/get_storage.dart';

class LocalStorage {
  static final GetStorage getStorage = GetStorage();

  static Future<void> saveUser(UserModel userModel) async {
    await getStorage.write(
      Constants.currentUserKey,
      json.encode(userModel.toMap()),
    );
  }

  static UserModel readUser() {
    return UserModel.fromMap(
        json.decode(getStorage.read(Constants.currentUserKey)));
  }

  static bool hasCurrentUser() {
    return getStorage.hasData(Constants.currentUserKey);
  }

  static Future<void> removeCurrentUser() async {
    await getStorage.remove(Constants.currentUserKey);
  }
}
