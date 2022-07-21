import 'package:chatapp/enums/message_type.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';

@immutable
abstract class Utils {
  static String getLastMessageAccordingToMessageType(
    MessageType messageType,
    String message,
  ) {
    switch (messageType) {
      case MessageType.text:
        return message;
      case MessageType.image:
        return '📷 Photo';
      case MessageType.audio:
        return '🎵 Audio';
      case MessageType.video:
        return '📸 Video';
      case MessageType.gif:
        return 'GIF';
    }
  }
}
