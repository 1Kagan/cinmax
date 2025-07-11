import 'package:dio/dio.dart';
import 'package:flutter_base/src/config/router/app_router.dart';
import 'package:flutter_base/src/core/cache/secure_storage.dart';
import 'package:flutter_base/src/core/cubit/app_language/app_language_cubit.dart';
import 'package:flutter_base/src/core/cubit/app_theme/app_theme_cubit.dart';
import 'package:flutter_base/src/core/network/dio_client.dart';
import 'package:flutter_base/src/core/theme/app_theme.dart';
import 'package:flutter_base/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_base/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_base/src/features/auth/domain/use_cases/login_usecase.dart';
import 'package:flutter_base/src/features/auth/domain/use_cases/logout_usecase.dart';
import 'package:flutter_base/src/features/auth/presentation/state/auth_bloc.dart';
import 'package:flutter_base/src/features/home_page/data/repositories/movie_repository_impl.dart';
import 'package:flutter_base/src/features/home_page/domain/repositories/movie_repository.dart';
import 'package:flutter_base/src/features/home_page/domain/use_cases/get_movies_usecase.dart';
import 'package:flutter_base/src/features/home_page/domain/use_cases/toggle_favorite_usecase.dart';
import 'package:flutter_base/src/features/home_page/presentation/state/home_page_bloc.dart';
import 'package:flutter_base/src/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:flutter_base/src/features/profile/domain/repositories/profile_repository.dart';
import 'package:flutter_base/src/features/profile/domain/use_cases/get_favorite_movies_usecase.dart';
import 'package:flutter_base/src/features/profile/domain/use_cases/get_user_profile_usecase.dart';
import 'package:flutter_base/src/features/profile/presentation/state/profile_bloc.dart';
import 'package:flutter_base/src/features/register/data/repositories/register_repository_impl.dart';
import 'package:flutter_base/src/features/register/domain/repositories/register_repository.dart';
import 'package:flutter_base/src/features/register/domain/use_cases/register_usecase.dart';
import 'package:flutter_base/src/features/register/presentation/state/register_bloc.dart';
import 'package:flutter_base/src/features/splash/data/repositories/splash_repository_impl.dart';
import 'package:flutter_base/src/features/splash/domain/repositories/splash_repository.dart';
import 'package:flutter_base/src/features/splash/domain/use_cases/check_auth_status_usecase.dart';
import 'package:flutter_base/src/features/splash/presentation/state/splash_bloc.dart';
import 'package:flutter_base/src/features/upload_photo/data/repositories/upload_photo_repository_impl.dart';
import 'package:flutter_base/src/features/upload_photo/domain/repositories/upload_photo_repository.dart';
import 'package:flutter_base/src/features/upload_photo/domain/use_cases/upload_photo_usecase.dart';
import 'package:flutter_base/src/features/upload_photo/presentation/state/upload_photo_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final injector = GetIt.instance;

void init() {
  injector
    //* USECASES
    ..registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(injector<AuthRepository>()),
    )
    ..registerLazySingleton<RegisterUseCase>(
      () => RegisterUseCase(injector<RegisterRepository>()),
    )
    ..registerLazySingleton<GetMoviesUseCase>(
      () => GetMoviesUseCase(injector<MovieRepository>()),
    )
    ..registerLazySingleton<ToggleFavoriteUseCase>(
      () => ToggleFavoriteUseCase(injector<MovieRepository>()),
    )
    ..registerLazySingleton<GetUserProfileUseCase>(
      () => GetUserProfileUseCase(injector<ProfileRepository>()),
    )
    ..registerLazySingleton<GetFavoriteMoviesUseCase>(
      () => GetFavoriteMoviesUseCase(injector<ProfileRepository>()),
    )
    ..registerLazySingleton<UploadPhotoUseCase>(
      () => UploadPhotoUseCase(injector<UploadPhotoRepository>()),
    )
    ..registerLazySingleton<LogoutUseCase>(
      () => LogoutUseCase(injector<AuthRepository>()),
    )
    ..registerLazySingleton<CheckAuthStatusUseCase>(
      () => CheckAuthStatusUseCase(injector<SplashRepository>()),
    )

    //* REPOSITORIES
    ..registerLazySingleton<AuthRepository>(
      AuthRepositoryImpl.new,
    )
    ..registerLazySingleton<RegisterRepository>(
      RegisterRepositoryImpl.new,
    )
    ..registerLazySingleton<MovieRepository>(
      MovieRepositoryImpl.new,
    )
    ..registerLazySingleton<ProfileRepository>(
      ProfileRepositoryImpl.new,
    )
    ..registerLazySingleton<UploadPhotoRepository>(
      () => UploadPhotoRepositoryImpl(injector<DioClient>()),
    )
    ..registerLazySingleton<SplashRepository>(
      () => SplashRepositoryImpl(injector<SecureStorage>()),
    )

    //* BLoC & CUBIT
    ..registerFactory(AppLanguageCubit.new)
    ..registerFactory(AppThemeCubit.new)
    ..registerLazySingleton(
      () => AuthBloc(injector<LoginUseCase>(), injector<LogoutUseCase>()),
    )
    ..registerFactory(
      () => HomePageBloc(
        injector<GetMoviesUseCase>(),
        injector<ToggleFavoriteUseCase>(),
      ),
    )
    ..registerFactory(
      () => ProfileBloc(
        injector<GetUserProfileUseCase>(),
        injector<GetFavoriteMoviesUseCase>(),
      ),
    )
    ..registerFactory(
      () => UploadPhotoBloc(injector<UploadPhotoUseCase>()),
    )
    ..registerFactory(
      () => SplashBloc(
          checkAuthStatusUseCase: injector<CheckAuthStatusUseCase>()),
    )
    //* REGISTER
    ..registerFactory(
        () => RegisterBloc(registerUseCase: injector<RegisterUseCase>()))

    //* NETWORK
    ..registerLazySingleton(Dio.new)
    ..registerLazySingleton(() => DioClient(injector()))

    //* ROUTER
    ..registerLazySingleton(AppRouter.new)

    //* THEME
    ..registerLazySingleton(AppTheme.new)

    //* STORAGE
    ..registerLazySingleton(FlutterSecureStorage.new)
    ..registerLazySingleton(
        () => SecureStorage(injector<FlutterSecureStorage>()));
}
