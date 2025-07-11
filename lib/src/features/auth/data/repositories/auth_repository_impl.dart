import 'package:dio/dio.dart';
import 'package:flutter_base/src/core/cache/secure_storage.dart';
import 'package:flutter_base/src/core/constants/secure_storage_keys.dart';
import 'package:flutter_base/src/core/network/dio_client.dart';
import 'package:flutter_base/src/features/auth/domain/entities/user.dart';
import 'package:flutter_base/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_base/src/injector.dart';
import 'package:loggy/loggy.dart';

class AuthRepositoryImpl with UiLoggy implements AuthRepository {
  AuthRepositoryImpl();

  final _dio = injector<DioClient>();
  final _secureStorage = injector<SecureStorage>();

  @override
  Future<User> login({required String email, required String password}) async {
    try {
      final response = await _dio.post(
        '/user/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      final responseData = response.data as Map<String, dynamic>;
      final data = responseData['data'] as Map<String, dynamic>?;

      if (data == null) {
        throw Exception('Login response is missing the "data" object.');
      }

      final token = data['token'] as String?;
      if (token == null) {
        throw Exception('Login response is missing the "token".');
      }

      final user = User.fromJson(data);
      loggy.info('Token received: $token');
      await _secureStorage.storage
          .write(key: SecureStorageKeys.token, value: token);
      loggy.info('Token saved to secure storage.');

      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception('Hesap Bulunamadı');
      }
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    await _secureStorage.storage.delete(key: SecureStorageKeys.token);
    loggy.info('Token deleted from secure storage.');
  }
}
