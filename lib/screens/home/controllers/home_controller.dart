// ignore_for_file: use_build_context_synchronously

import 'package:chatapp/blocs/bloc_exports.dart';
import 'package:chatapp/helpers/local_storage.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:chatapp/res/res_exports.dart';
import 'package:flutter/material.dart';

@immutable
abstract class HomeController {
  static void refereshCurrentUser(BuildContext context) {
    try {
      Constants.usersCollection
          .doc(LocalStorage.readUser().uid)
          .snapshots()
          .listen((documentSnapshot) async {
        if (documentSnapshot.exists) {
          UserModel userModel = UserModel.fromMap(
              documentSnapshot.data() as Map<String, dynamic>);
          await LocalStorage.saveUser(userModel);
          context
              .read<AuthBloc>()
              .add(RefreshCurrentUserEvent(userModel: userModel));
        } else {
          context.read<AuthBloc>().add(LogOutEvent());
        }
      });
    } catch (e) {
      // error
    }
  }
}
