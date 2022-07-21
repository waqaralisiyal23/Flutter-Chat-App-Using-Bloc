part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {
  const ChatEvent();
}

@immutable
class UpdateIsWriting implements ChatEvent {
  final bool isWriting;
  const UpdateIsWriting(this.isWriting);
}

@immutable
class SendTextMessage implements ChatEvent {
  final String text;
  final UserModel receiver;
  const SendTextMessage({
    required this.text,
    required this.receiver,
  });
}
