import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_media_app/features/storage/domain/storage_repo.dart';

class FirebaseStorageRepo implements StorageRepo {
  final FirebaseStorage storage = FirebaseStorage.instance;

  /*
    Profile pictures - upload images to storage
  */

  @override
  Future<String?> uploadProfileImageMobile(String path, String fileName) {
    return _uploadFile(path, fileName, 'profile_images');
  }

  @override
  Future<String?> uploadProfileImageWeb(Uint8List fileBytes, String fileName) {
    return _uploadFileBytes(fileBytes, fileName, 'profile_images');
  }

  /*
    Post images - upload images to storage
  */

  @override
  Future<String?> uploadPostImageMobile(String path, String fileName) {
    return _uploadFile(path, fileName, 'post_images');
  }

  @override
  Future<String?> uploadPostImageWeb(Uint8List fileBytes, String fileName) {
    return _uploadFileBytes(fileBytes, fileName, 'post_images');
  }

  /*
  Helper methods - to upload files to storage
   */

  // mobile platforms (file)

  Future<String?> _uploadFile(String path, String fileName, String folder) async {
    try {
      // get file
      final file = File(path);

      // find storage place
      final storageRef = storage.ref().child('$folder/$fileName');

      // upload
      final uploadTask = await storageRef.putFile(file);

      // get img download URL
      final downloadUrl = await uploadTask.ref.getDownloadURL();
      return downloadUrl;
    }

    catch (e) {
      return null;
    }
  }

  // web platforms (bytes)
  Future<String?> _uploadFileBytes(Uint8List fileBytes, String fileName, String folder) async {
    try {
      // find storage place
      final storageRef = storage.ref().child('$folder/$fileName');

      // upload
      final uploadTask = await storageRef.putData(fileBytes);

      // get img download URL
      final downloadUrl = await uploadTask.ref.getDownloadURL();
      return downloadUrl;
    }

    catch (e) {
      return null;
    }
  }
}