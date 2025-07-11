import 'package:flutter_base/src/features/register/domain/entities/register_response.dart';
import 'package:flutter_base/src/features/register/domain/repositories/register_repository.dart';

class RegisterUseCase {
  final RegisterRepository repository;

  RegisterUseCase(this.repository);

  Future<RegisterResponse> call({
    required String email,
    required String name,
    required String password,
  }) async {
    return await repository.register(
        email: email, name: name, password: password);
  }
}
