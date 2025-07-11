import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base/l10n/l10n.dart';
import 'package:flutter_base/src/features/auth/domain/use_cases/login_usecase.dart';
import 'package:flutter_base/src/features/auth/domain/use_cases/logout_usecase.dart';
import 'package:flutter_base/src/features/auth/presentation/state/auth_event.dart';
import 'package:flutter_base/src/features/auth/presentation/state/auth_state.dart';
import 'package:dio/dio.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;

  AuthBloc(this._loginUseCase, this._logoutUseCase) : super(const AuthState()) {
    on<AuthEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email, status: AuthStatus.initial));
    });
    on<AuthPasswordChanged>((event, emit) {
      emit(
          state.copyWith(password: event.password, status: AuthStatus.initial));
    });
    on<AuthSubmitted>(_onSubmitted);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _logoutUseCase();
      emit(
        state.copyWith(
          status: AuthStatus.unauthenticated,
          user: null,
          email: '',
          password: '',
        ),
      );
    } catch (e) {}
  }

  Future<void> _onSubmitted(
    AuthSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    final l10n = event.context.l10n;
    final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    final emailError = state.email.isEmpty
        ? l10n.translate('email_required')
        : !emailRegExp.hasMatch(state.email)
            ? l10n.translate('invalid_email')
            : null;

    final passwordError =
        state.password.isEmpty ? l10n.translate('password_required') : null;

    if (emailError != null || passwordError != null) {
      emit(state.copyWith(
        emailError: emailError,
        passwordError: passwordError,
      ));
      return;
    }

    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final user = await _loginUseCase(
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(status: AuthStatus.success, user: user));
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 400) {
        emit(state.copyWith(
          status: AuthStatus.failure,
          submissionError: l10n.translate('account_not_found'),
        ));
      } else {
        emit(state.copyWith(
          status: AuthStatus.failure,
          submissionError: e.toString(),
        ));
      }
    }
  }
}
