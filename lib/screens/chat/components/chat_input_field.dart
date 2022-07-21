import 'package:chatapp/blocs/bloc_exports.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:chatapp/res/res_exports.dart';
import 'package:flutter/material.dart';

class ChatInputField extends StatelessWidget {
  final UserModel receiver;
  final TextEditingController controller;
  const ChatInputField({
    Key? key,
    required this.receiver,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Constants.defaultPadding,
            vertical: Constants.defaultPadding / 2,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 32,
                color: const Color(0xFF087949).withOpacity(0.08),
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Constants.defaultPadding * 0.75,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.sentiment_satisfied_alt_outlined,
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .color!
                              .withOpacity(0.64),
                        ),
                        const SizedBox(width: Constants.defaultPadding / 4),
                        Expanded(
                          child: TextField(
                            maxLines: 3,
                            minLines: 1,
                            controller: controller,
                            onChanged: (value) {
                              if (value.trim().isNotEmpty) {
                                context
                                    .read<ChatBloc>()
                                    .add(const UpdateIsWriting(true));
                              } else {
                                context
                                    .read<ChatBloc>()
                                    .add(const UpdateIsWriting(false));
                              }
                            },
                            textInputAction: TextInputAction.done,
                            decoration: const InputDecoration(
                              hintText: 'Type message',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.attach_file,
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .color!
                              .withOpacity(0.64),
                        ),
                        const SizedBox(width: Constants.defaultPadding / 4),
                        Icon(
                          Icons.camera_alt_outlined,
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .color!
                              .withOpacity(0.64),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: Constants.defaultPadding),
                state.isWriting
                    ? InkWell(
                        onTap: () {
                          String message = controller.text.trim();
                          controller.clear();
                          context.read<ChatBloc>().add(
                                SendTextMessage(
                                  text: message,
                                  receiver: receiver,
                                ),
                              );
                        },
                        child: const Icon(
                          Icons.send,
                          color: AppColors.primaryColor,
                        ),
                      )
                    : InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.mic,
                          color: AppColors.primaryColor,
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
