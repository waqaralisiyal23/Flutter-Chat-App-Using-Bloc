import 'package:chatapp/global_widgets.dart';
import 'package:chatapp/helpers/local_storage.dart';
import 'package:chatapp/models/message.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:chatapp/res/res_exports.dart';
import 'package:chatapp/screens/chat/components/message_layout.dart';
import 'package:chatapp/services/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class MessagesList extends StatelessWidget {
  final UserModel receiver;
  final ScrollController scrollController;
  const MessagesList({
    Key? key,
    required this.receiver,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
      stream: ChatService.getChatStream(receiver.uid),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: circularProgress());
        }
        if (snapshot.data!.isEmpty) {
          return const SizedBox(width: 0, height: 0);
        }

        // Scroll to the end
        SchedulerBinding.instance.addPostFrameCallback((_) {
          scrollToBottom(scrollController);
        });

        return ListView.builder(
          padding: const EdgeInsets.only(bottom: Constants.defaultPadding),
          controller: scrollController,
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            Message message = snapshot.data![index];
            message = message.copyWith(
                isSender: message.senderId == LocalStorage.readUser().uid);
            return Container(
              alignment: message.isSender!
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: MessageLayout(message: message),
            );
          },
        );
      },
    );
  }
}
