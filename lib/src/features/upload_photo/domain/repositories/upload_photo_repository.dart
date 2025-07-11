import 'dart:io';

abstract class UploadPhotoRepository {
  Future<void> uploadPhoto(File file);
}
