import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageHelper {
  FirebaseStorageHelper._();
  static FirebaseStorageHelper firebaseStorageHelper = FirebaseStorageHelper._();
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  uploadImage(File file) async {
    String filePath = file.path;
    String fileName = filePath.split('/').last;
    String path = 'imgs/profiles/$fileName';
    Reference reference = firebaseStorage.ref(path);

    await reference.putFile(file);

    String imgUrl = await reference.getDownloadURL();

    return imgUrl;
  }
}