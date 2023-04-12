import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FileUploader {
  static Future<String?> uploadFileMobile({String? path}) async {
    try {
      final file = File(path!);
      if (!file.existsSync()) {
        throw Exception("Oops! Cannot find the file");
      }
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child("images/${DateTime
          .now()
          .millisecondsSinceEpoch}");

      UploadTask uploadTask = firebaseStorageRef.putFile(File(file.path));
      TaskSnapshot taskSnapshot = await uploadTask;

      return taskSnapshot.ref.getDownloadURL().then((value) => (value));
    } catch (e, st) {
      print(e);
      log("setOnBoardingData------FileUploader-------$e--------$st");
    }
    return null;
  }
}
