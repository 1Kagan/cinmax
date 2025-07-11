import 'dart:io';
import 'package:flutter_base/src/features/upload_photo/domain/repositories/upload_photo_repository.dart';

class UploadPhotoUseCase {
  final UploadPhotoRepository _repository;

  UploadPhotoUseCase(this._repository);

  Future<void> call(File file) {
    return _repository.uploadPhoto(file);
  }
}
