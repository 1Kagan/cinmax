import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

class RegisterNameChanged extends RegisterEvent {
  final String name;
  const RegisterNameChanged(this.name);

  @override
  List<Object?> get props => [name];
}

class RegisterEmailChanged extends RegisterEvent {
  final String email;
  const RegisterEmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class RegisterPasswordChanged extends RegisterEvent {
  final String password;
  const RegisterPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class RegisterPasswordAgainChanged extends RegisterEvent {
  final String passwordAgain;
  const RegisterPasswordAgainChanged(this.passwordAgain);

  @override
  List<Object?> get props => [passwordAgain];
}

class RegisterSubmitted extends RegisterEvent {
  final BuildContext context;
  const RegisterSubmitted(this.context);

  @override
  List<Object?> get props => [context];
}
