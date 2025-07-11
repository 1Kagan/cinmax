import 'package:flutter_base/src/features/home_page/domain/repositories/movie_repository.dart';

class ToggleFavoriteUseCase {
  final MovieRepository _repository;

  ToggleFavoriteUseCase(this._repository);

  Future<void> call(String movieId) async {
    return _repository.toggleFavorite(movieId);
  }
}
