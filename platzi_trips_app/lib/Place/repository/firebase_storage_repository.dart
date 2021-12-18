import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import 'firebase_storage_api.dart';

class FirebaseStorageRepository {
  final _firebaseStorageAPI = FirebaseStorageAPI();

  Future<UploadTask> uploadFile(String path, File image) async =>
      _firebaseStorageAPI.uploadFile(path, image);
}
