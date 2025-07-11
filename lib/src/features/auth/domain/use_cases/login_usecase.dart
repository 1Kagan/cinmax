import 'package:dartz/dartz.dart';
import 'package:flutter_base/src/core/models/error_model/error_model.dart';
import 'package:flutter_base/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_base/src/features/auth/domain/entities/user.dart';

class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<User> call({required String email, required String password}) async {
    return await _repository.login(email: email, password: password);
  }
}
