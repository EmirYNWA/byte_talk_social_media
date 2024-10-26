import 'dart:typed_data';

abstract class StorageRepo {
  // upload profile pictures on mobile platforms
  Future<String?> uploadProfileImageMobile(String path, String fileName);

  // upload profile pictures on web platforms
  Future<String?> uploadProfileImageWeb(Uint8List path, String fileName);
}