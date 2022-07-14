import 'package:chatapp/enums/message_type.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class Utils {
  static MessageType getMessageType(String type) {
    if (type == 'text') {
      return MessageType.text;
    } else if (type == 'image') {
      return MessageType.image;
    } else if (type == 'file') {
      return MessageType.file;
    } else {
      return MessageType.audio;
    }
  }

  static String getMessageTypeString(MessageType messageType) {
    switch (messageType) {
      case MessageType.text:
        return 'text';
      case MessageType.image:
        return 'image';
      case MessageType.file:
        return 'file';
      case MessageType.audio:
        return 'audio';
    }
  }
}
