part of 'chat_bloc.dart';

@immutable
class ChatState {
  final bool isWriting;

  const ChatState({required this.isWriting});

  const ChatState.initial() : isWriting = false;
}
