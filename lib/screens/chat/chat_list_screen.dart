import 'package:chatapp/global_widgets.dart';
import 'package:chatapp/models/recent_chat.dart';
import 'package:chatapp/screens/chat/components/chat_list_item.dart';
import 'package:chatapp/services/chat_service.dart';
import 'package:flutter/material.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<RecentChat>>(
        stream: ChatService.getRecentChatsStream(),
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
              RecentChat recentChat = snapshot.data![index];
              return ChatListItem(recentChat: recentChat);
            },
          );
        });
  }
}
