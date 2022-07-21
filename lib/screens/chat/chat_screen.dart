import 'package:chatapp/blocs/bloc_exports.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:chatapp/res/res_exports.dart';
import 'package:chatapp/screens/chat/components/chat_input_field.dart';
import 'package:chatapp/screens/chat/components/messages_list.dart';
import 'package:chatapp/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  late final UserModel receiver;
  ChatScreen({Key? key}) : super(key: key) {
    receiver = Get.arguments as UserModel;
  }
  static const name = '/chat_screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final ScrollController scrollController;
  late final TextEditingController messageController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    messageController = TextEditingController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: buildAppBar(),
          body: Column(
            children: [
              Expanded(
                child: MessagesList(
                  receiver: widget.receiver,
                  scrollController: scrollController,
                ),
              ),
              ChatInputField(
                receiver: widget.receiver,
                controller: messageController,
              ),
            ],
          ),
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
          CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: widget.receiver.profileImage == null
                ? const AssetImage(Images.profile)
                : NetworkImage(widget.receiver.profileImage!) as ImageProvider,
          ),
          const SizedBox(width: Constants.defaultPadding * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.receiver.name,
                style: const TextStyle(fontSize: 16),
              ),
              StreamBuilder<UserModel>(
                stream: UserService.userDataStream(widget.receiver.uid),
                builder: (context, snapshot) {
                  return Text(
                    snapshot.hasData && snapshot.data!.status
                        ? 'online'
                        : 'offline',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                    ),
                  );
                },
              ),
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
