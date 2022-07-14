import 'package:chatapp/screens/chat/components/chat_list_item.dart';
import 'package:chatapp/screens/chat/individual_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return ChatListItem(
          onPressed: () => Get.toNamed(IndividualChatScreen.name),
        );
      },
    );
  }
}
