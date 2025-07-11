import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base/src/features/profile/domain/entities/favorite_movie.dart';
import 'package:flutter_base/src/features/profile/domain/entities/user_profile.dart';
import 'package:flutter_base/src/features/profile/domain/use_cases/get_favorite_movies_usecase.dart';
import 'package:flutter_base/src/features/profile/domain/use_cases/get_user_profile_usecase.dart';
import 'package:flutter_base/src/features/profile/presentation/state/profile_event.dart';
import 'package:flutter_base/src/features/profile/presentation/state/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserProfileUseCase _getUserProfileUseCase;
  final GetFavoriteMoviesUseCase _getFavoriteMoviesUseCase;

  ProfileBloc(
    this._getUserProfileUseCase,
    this._getFavoriteMoviesUseCase,
  ) : super(const ProfileState()) {
    on<ProfileDataFetched>(_onProfileDataFetched);
  }

  Future<void> _onProfileDataFetched(
    ProfileDataFetched event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      final results = await Future.wait([
        _getUserProfileUseCase(),
        _getFavoriteMoviesUseCase(),
      ]);

      final userProfile = results[0] as UserProfile;
      final favoriteMovies = results[1] as List<FavoriteMovie>;

      emit(state.copyWith(
        status: ProfileStatus.success,
        userProfile: userProfile,
        favoriteMovies: favoriteMovies,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProfileStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
