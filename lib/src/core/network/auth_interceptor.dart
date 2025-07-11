import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_base/src/injector.dart';
import 'package:flutter_base/src/core/constants/secure_storage_keys.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final storage = injector<FlutterSecureStorage>();
    final token = await storage.read(key: SecureStorageKeys.token);

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }
}
