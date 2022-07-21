import 'package:chatapp/blocs/bloc_exports.dart';
import 'package:chatapp/enums/message_type.dart';
import 'package:chatapp/enums/snackbar_message.dart';
import 'package:chatapp/global_widgets.dart';
import 'package:chatapp/helpers/local_storage.dart';
import 'package:chatapp/models/message.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:chatapp/services/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:uuid/uuid.dart';
part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(const ChatState.initial()) {
    on<UpdateIsWriting>((event, emit) {
      emit(ChatState(isWriting: event.isWriting));
    });
    on<SendTextMessage>(_onSendTextMessage);
  }

  void _onSendTextMessage(
      SendTextMessage event, Emitter<ChatState> emit) async {
    try {
      String messageId = const Uuid().v1();
      Message message = Message(
        messageId: messageId,
        senderId: LocalStorage.readUser().uid,
        receiverId: event.receiver.uid,
        messageType: MessageType.text,
        message: event.text,
        timestamp: Timestamp.now(),
      );
      await ChatService.saveMessage(message);
    } on FirebaseException catch (e) {
      showSnackbar(SnackbarMessage.error, e.message ?? e.toString());
    } catch (e) {
      showSnackbar(SnackbarMessage.error, e.toString());
    }
  }
}
