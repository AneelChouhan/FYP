// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseHelper {
  static Future<String> uploadFile(File? file) async {
    Reference storage = FirebaseStorage.instance.ref();

    String filename = path.basename(file!.path);
    String extension = path.extension(file.path);
    String randomChars = DateTime.now().millisecondsSinceEpoch.toString();
    String uniqueFilename = '$filename-$randomChars$extension';

    UploadTask uploadTask = storage
        .child(uniqueFilename)
        .putFile(file);
    await uploadTask;
    String downloadURL = await storage
        .child(uniqueFilename)
        .getDownloadURL();
    return downloadURL;
  }
}