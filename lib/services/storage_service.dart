import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class StorageService {
  static final Reference _storageReference = FirebaseStorage.instance.ref();

  static Future<String> uploadFile({
    required File file,
    required String path,
  }) async {
    await _storageReference.child(path).putFile(file);
    String downloadURL = await _storageReference.child(path).getDownloadURL();
    return downloadURL;
  }
}
