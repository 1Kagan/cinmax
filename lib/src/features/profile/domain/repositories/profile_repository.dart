import 'package:flutter_base/src/features/profile/domain/entities/favorite_movie.dart';
import 'package:flutter_base/src/features/profile/domain/entities/user_profile.dart';

abstract class ProfileRepository {
  Future<UserProfile> getUserProfile();
  Future<List<FavoriteMovie>> getFavoriteMovies();
}
