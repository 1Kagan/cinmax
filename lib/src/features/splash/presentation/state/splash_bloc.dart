import 'package:bloc/bloc.dart';
import 'package:flutter_base/src/features/splash/domain/use_cases/check_auth_status_usecase.dart';
import 'package:flutter_base/src/features/splash/presentation/state/splash_event.dart';
import 'package:flutter_base/src/features/splash/presentation/state/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final CheckAuthStatusUseCase _checkAuthStatusUseCase;

  SplashBloc({required CheckAuthStatusUseCase checkAuthStatusUseCase})
      : _checkAuthStatusUseCase = checkAuthStatusUseCase,
        super(SplashInitial()) {
    on<CheckAuthStatus>(_onCheckAuthStatus);
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<SplashState> emit,
  ) async {
    final token = await _checkAuthStatusUseCase();
    if (token != null) {
      emit(Authenticated());
    } else {
      emit(Unauthenticated());
    }
  }
}
