import 'package:flutter_base/src/features/splash/domain/repositories/splash_repository.dart';

class CheckAuthStatusUseCase {
  final SplashRepository _repository;

  CheckAuthStatusUseCase(this._repository);

  Future<String?> call() {
    return _repository.checkAuthStatus();
  }
}
