import 'package:chatapp/enums/message_type.dart';
import 'package:chatapp/helpers/utils.dart';
import 'package:chatapp/models/message.dart';
import 'package:chatapp/res/res_exports.dart';
import 'package:chatapp/screens/chat/components/text_message.dart';
import 'package:flutter/material.dart';

class MessageLayout extends StatelessWidget {
  final Message message;
  const MessageLayout({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Constants.defaultPadding),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: message.isSender!
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!message.isSender!) ...[
              const CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.primaryColor,
                backgroundImage: AssetImage(Images.profile),
              ),
              const SizedBox(width: Constants.defaultPadding / 2),
            ],
            messageContent(),
          ],
        ),
      ),
    );
  }

  Widget messageContent() {
    final MessageType messageType = Utils.getMessageType(message.type);
    switch (messageType) {
      case MessageType.text:
        return TextMessage(message: message);
      case MessageType.image:
        return const SizedBox(width: 0, height: 0);
      case MessageType.file:
        return const SizedBox(width: 0, height: 0);
      case MessageType.audio:
        return const SizedBox(width: 0, height: 0);
    }
  }
}
