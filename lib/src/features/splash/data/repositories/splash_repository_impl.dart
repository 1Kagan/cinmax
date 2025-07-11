import 'package:flutter_base/src/core/cache/secure_storage.dart';
import 'package:flutter_base/src/core/constants/secure_storage_keys.dart';
import 'package:flutter_base/src/features/splash/domain/repositories/splash_repository.dart';
import 'package:loggy/loggy.dart';

class SplashRepositoryImpl with UiLoggy implements SplashRepository {
  final SecureStorage _secureStorage;

  SplashRepositoryImpl(this._secureStorage);

  @override
  Future<String?> checkAuthStatus() async {
    print('Checking auth status...');
    final token =
        await _secureStorage.storage.read(key: SecureStorageKeys.token);
    print('Token from storage: $token');
    return token;
  }
}
