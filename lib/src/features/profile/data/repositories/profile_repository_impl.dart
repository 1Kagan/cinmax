import 'package:flutter_base/src/core/network/dio_client.dart';
import 'package:flutter_base/src/features/profile/domain/entities/favorite_movie.dart';
import 'package:flutter_base/src/features/profile/domain/entities/user_profile.dart';
import 'package:flutter_base/src/features/profile/domain/repositories/profile_repository.dart';
import 'package:flutter_base/src/injector.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final _dio = injector<DioClient>();

  @override
  Future<UserProfile> getUserProfile() async {
    try {
      final response = await _dio.get('/user/profile');
      final data = response.data['data'] as Map<String, dynamic>;
      return UserProfile.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<FavoriteMovie>> getFavoriteMovies() async {
    try {
      final response = await _dio.get('/movie/favorites');
      final moviesData = response.data['data'] as List;
      return moviesData
          .map((movie) => FavoriteMovie.fromJson(movie as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
