import 'package:chatapp/helpers/date_time_operations.dart';
import 'package:chatapp/helpers/local_storage.dart';
import 'package:chatapp/models/recent_chat.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:chatapp/res/res_exports.dart';
import 'package:chatapp/screens/chat/chat_screen.dart';
import 'package:chatapp/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatListItem extends StatelessWidget {
  final RecentChat recentChat;
  const ChatListItem({Key? key, required this.recentChat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
        future: UserService.getUserDetails(recentChat.chatUserId),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return const SizedBox(width: 0, height: 0);
          }
          UserModel userModel = snapshot.data!;
          return InkWell(
            onTap: () => Get.toNamed(ChatScreen.name, arguments: userModel),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Constants.defaultPadding,
                vertical: Constants.defaultPadding * 0.75,
              ),
              child: Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.grey,
                        backgroundImage: userModel.profileImage == null
                            ? const AssetImage(Images.profile)
                            : NetworkImage(userModel.profileImage!)
                                as ImageProvider,
                      ),
                      if (userModel.status)
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            height: 16,
                            width: 16,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                width: 3,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Constants.defaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userModel.name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 8),
                          Opacity(
                            opacity: 0.64,
                            child: Text(
                              recentChat.messageSenderId ==
                                      LocalStorage.readUser().uid
                                  ? 'You: ${recentChat.message}'
                                  : recentChat.message,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: 0.64,
                    child: Text(
                      DateTimeOperations.getFormattedTime(recentChat.timestamp),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
