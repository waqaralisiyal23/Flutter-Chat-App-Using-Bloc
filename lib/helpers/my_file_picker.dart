import 'dart:io';

import 'package:flutter/foundation.dart' show immutable;
import 'package:image_picker/image_picker.dart';

@immutable
abstract class MyFilePicker {
  static final ImagePicker _picker = ImagePicker();

  static Future<File?> pickImage(ImageSource imageSource) async {
    final XFile? pickedImage = await _picker.pickImage(source: imageSource);
    return pickedImage == null ? null : File(pickedImage.path);
  }
}
