import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_base/src/core/network/dio_client.dart';
import 'package:flutter_base/src/features/upload_photo/domain/repositories/upload_photo_repository.dart';

class UploadPhotoRepositoryImpl implements UploadPhotoRepository {
  final DioClient _dioClient;

  UploadPhotoRepositoryImpl(this._dioClient);

  @override
  Future<void> uploadPhoto(File file) async {
    try {
      print('📡 Starting upload to server...');
      print('📁 File path: ${file.path}');
      print('📏 File size: ${file.lengthSync()} bytes');

      final fileName = file.path.split('/').last;
      print('📝 File name: $fileName');

      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path, filename: fileName),
      });

      print('🌐 Sending POST request to /user/upload_photo');
      final response =
          await _dioClient.post('/user/upload_photo', data: formData);
      print('✅ Upload response: ${response.statusCode}');
    } catch (e) {
      print('❌ Upload error: $e');
      rethrow;
    }
  }
}
