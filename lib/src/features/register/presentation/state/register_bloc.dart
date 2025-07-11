import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base/l10n/l10n.dart';
import 'package:flutter_base/src/features/register/domain/use_cases/register_usecase.dart';
import 'package:flutter_base/src/features/register/presentation/state/register_event.dart';
import 'package:flutter_base/src/features/register/presentation/state/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterBloc({required this.registerUseCase}) : super(const RegisterState()) {
    on<RegisterNameChanged>((event, emit) {
      emit(state.copyWith(name: event.name));
    });
    on<RegisterEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });
    on<RegisterPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });
    on<RegisterPasswordAgainChanged>((event, emit) {
      emit(state.copyWith(passwordAgain: event.passwordAgain));
    });
    on<RegisterSubmitted>(_onRegisterSubmitted);
  }

  Future<void> _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    final l10n = event.context.l10n;
    final nameError =
        state.name.isEmpty ? l10n.translate('full_name_required') : null;
    final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    final emailError = state.email.isEmpty
        ? l10n.translate('email_required')
        : !emailRegExp.hasMatch(state.email)
            ? l10n.translate('invalid_email')
            : null;
    final passwordError = state.password.isEmpty
        ? l10n.translate('password_required')
        : state.password.length < 6
            ? l10n.translate('password_min_length')
            : null;
    final passwordAgainError = state.passwordAgain.isEmpty
        ? l10n.translate('password_again_required')
        : state.password != state.passwordAgain
            ? l10n.translate('passwords_do_not_match')
            : null;

    final isFormValid = nameError == null &&
        emailError == null &&
        passwordError == null &&
        passwordAgainError == null;

    if (!isFormValid) {
      emit(state.copyWith(
        nameError: nameError,
        emailError: emailError,
        passwordError: passwordError,
        passwordAgainError: passwordAgainError,
      ));
      return;
    }

    emit(state.copyWith(status: SubmissionStatus.loading));
    try {
      final response = await registerUseCase(
        name: state.name,
        email: state.email,
        password: state.password,
      );
      emit(
          state.copyWith(status: SubmissionStatus.success, response: response));
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        emit(state.copyWith(
          status: SubmissionStatus.failure,
          submissionError: l10n.translate('email_already_registered'),
        ));
      } else {
        emit(state.copyWith(
          status: SubmissionStatus.failure,
          submissionError: e.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: SubmissionStatus.failure,
        submissionError: e.toString(),
      ));
    }
  }
}
