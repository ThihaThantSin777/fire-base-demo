import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FileUploadToFireBaseUtils {
  static final _firebaseStorage = FirebaseStorage.instance;

  static Future<String> uploadToFirebaseStorage(File file, String path) {
    return _firebaseStorage.ref(path).child(DateTime.now().millisecondsSinceEpoch.toString()).putFile(file).then((takeSnapShot) {
      return takeSnapShot.ref.getDownloadURL().then((value) {
        return value;
      });
    });
  }
}
