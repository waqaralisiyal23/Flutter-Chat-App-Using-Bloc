import 'package:chatapp/models/message.dart';
import 'package:chatapp/res/res_exports.dart';
import 'package:chatapp/screens/chat/components/chat_input_field.dart';
import 'package:chatapp/screens/chat/components/message_layout.dart';
import 'package:flutter/material.dart';

class IndividualChatScreen extends StatelessWidget {
  const IndividualChatScreen({Key? key}) : super(key: key);
  static const name = '/individual_chat_screen';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: buildAppBar(),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding:
                    const EdgeInsets.only(bottom: Constants.defaultPadding),
                itemCount: demeChatMessages.length,
                itemBuilder: (context, index) {
                  Message message = demeChatMessages[index];
                  message = message.copyWith(isSender: message.senderId == 'W');
                  return Container(
                    alignment: message.isSender!
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: MessageLayout(message: message),
                  );
                },
              ),
            ),
            ChatInputField(
              isWriting: true,
              sendTextMessage: () {},
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Row(
        children: [
          const BackButton(),
          const CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: AssetImage(Images.profile),
          ),
          const SizedBox(width: Constants.defaultPadding * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Kristin Watson',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Online',
                style: TextStyle(fontSize: 12),
              )
            ],
          )
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.local_phone),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.videocam),
          onPressed: () {},
        ),
        const SizedBox(width: Constants.defaultPadding / 2),
      ],
    );
  }
}
