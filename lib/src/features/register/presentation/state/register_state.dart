import 'package:equatable/equatable.dart';
import 'package:flutter_base/src/features/register/domain/entities/register_response.dart';

enum SubmissionStatus { initial, loading, success, failure }

class RegisterState extends Equatable {
  final String name;
  final String email;
  final String password;
  final String passwordAgain;

  final String? nameError;
  final String? emailError;
  final String? passwordError;
  final String? passwordAgainError;

  final SubmissionStatus status;
  final String? submissionError;
  final RegisterResponse? response;

  const RegisterState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.passwordAgain = '',
    this.nameError,
    this.emailError,
    this.passwordError,
    this.passwordAgainError,
    this.status = SubmissionStatus.initial,
    this.submissionError,
    this.response,
  });

  RegisterState copyWith({
    String? name,
    String? email,
    String? password,
    String? passwordAgain,
    String? nameError,
    String? emailError,
    String? passwordError,
    String? passwordAgainError,
    SubmissionStatus? status,
    String? submissionError,
    RegisterResponse? response,
  }) {
    return RegisterState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      passwordAgain: passwordAgain ?? this.passwordAgain,
      nameError: nameError, // Directly assign, allowing null
      emailError: emailError, // Directly assign, allowing null
      passwordError: passwordError, // Directly assign, allowing null
      passwordAgainError: passwordAgainError, // Directly assign, allowing null
      status: status ?? this.status,
      submissionError: submissionError ?? this.submissionError,
      response: response ?? this.response,
    );
  }

  @override
  List<Object?> get props => [
        name,
        email,
        password,
        passwordAgain,
        nameError,
        emailError,
        passwordError,
        passwordAgainError,
        status,
        submissionError,
        response,
      ];
}
