import 'package:flutter_base/src/features/register/domain/entities/register_response.dart';

abstract class RegisterRepository {
  Future<RegisterResponse> register({
    required String email,
    required String name,
    required String password,
  });
}
