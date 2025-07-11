import 'package:flutter_base/src/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> login({
    required String email,
    required String password,
  });

  Future<void> logout();
}
