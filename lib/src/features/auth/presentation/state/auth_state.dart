import 'package:equatable/equatable.dart';
import 'package:flutter_base/src/features/auth/domain/entities/user.dart';

enum AuthStatus { initial, loading, success, failure, unauthenticated }

class AuthState extends Equatable {
  final String email;
  final String password;
  final String? emailError;
  final String? passwordError;
  final AuthStatus status;
  final String? submissionError;
  final User? user;

  const AuthState({
    this.email = '',
    this.password = '',
    this.emailError,
    this.passwordError,
    this.status = AuthStatus.initial,
    this.submissionError,
    this.user,
  });

  AuthState copyWith({
    String? email,
    String? password,
    String? emailError,
    String? passwordError,
    AuthStatus? status,
    String? submissionError,
    User? user,
  }) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailError: emailError,
      passwordError: passwordError,
      status: status ?? this.status,
      submissionError: submissionError,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        emailError,
        passwordError,
        status,
        submissionError,
        user,
      ];
}
