import 'package:flutter_base/src/features/profile/domain/entities/favorite_movie.dart';
import 'package:flutter_base/src/features/profile/domain/repositories/profile_repository.dart';

class GetFavoriteMoviesUseCase {
  final ProfileRepository _repository;

  GetFavoriteMoviesUseCase(this._repository);

  Future<List<FavoriteMovie>> call() {
    return _repository.getFavoriteMovies();
  }
}
