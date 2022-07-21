enum MessageType {
  text('text'),
  image('image'),
  audio('audio'),
  video('video'),
  gif('gif');

  const MessageType(this.type);
  final String type;
}

// Using an extension
// Enhanced enums

extension ConvertMessage on String {
  MessageType toMessageType() {
    switch (this) {
      case 'audio':
        return MessageType.audio;
      case 'image':
        return MessageType.image;
      case 'text':
        return MessageType.text;
      case 'gif':
        return MessageType.gif;
      case 'video':
        return MessageType.video;
      default:
        return MessageType.text;
    }
  }
}
