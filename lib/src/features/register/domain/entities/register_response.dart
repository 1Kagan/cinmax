import 'package:flutter_base/src/features/register/domain/entities/register_user.dart';

class RegisterResponse {
  final String token;
  final RegisterUser user;

  RegisterResponse({
    required this.token,
    required this.user,
  });
}
