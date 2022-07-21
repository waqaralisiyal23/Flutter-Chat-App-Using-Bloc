import 'package:chatapp/global_widgets.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:chatapp/screens/chat/chat_screen.dart';
import 'package:chatapp/screens/find_people/components/user_item.dart';
import 'package:chatapp/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PeopleListScreen extends StatelessWidget {
  const PeopleListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UserModel>>(
        stream: UserService.getUsersStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: circularProgress());
          }
          if (snapshot.data!.isEmpty) {
            return const SizedBox(width: 0, height: 0);
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              UserModel userModel = snapshot.data![index];
              return UserItem(
                userModel: userModel,
                onPressed: () =>
                    Get.toNamed(ChatScreen.name, arguments: userModel),
              );
            },
          );
        });
  }
}
