import 'package:equatable/equatable.dart';
import 'package:flutter_base/src/features/profile/domain/entities/favorite_movie.dart';
import 'package:flutter_base/src/features/profile/domain/entities/user_profile.dart';

enum ProfileStatus { initial, loading, success, failure }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final UserProfile? userProfile;
  final List<FavoriteMovie> favoriteMovies;
  final String? errorMessage;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.userProfile,
    this.favoriteMovies = const [],
    this.errorMessage,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    UserProfile? userProfile,
    List<FavoriteMovie>? favoriteMovies,
    String? errorMessage,
  }) {
    return ProfileState(
      status: status ?? this.status,
      userProfile: userProfile ?? this.userProfile,
      favoriteMovies: favoriteMovies ?? this.favoriteMovies,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [status, userProfile, favoriteMovies, errorMessage];
}
