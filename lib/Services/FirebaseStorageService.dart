import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final _firebaseStorage = FirebaseStorage();

  uploadFile({File file, String title}) async {
    final fileName = title + DateTime.now().millisecondsSinceEpoch.toString();
    final fileReference = _firebaseStorage.ref().child(fileName);
    final fileUploadTask = fileReference.putFile(file);
    final fileSnapshot = await fileUploadTask.onComplete;
    final downloadUrl = await fileSnapshot.ref.getDownloadURL();
    return downloadUrl.toString();
  }
}
