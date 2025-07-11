import 'package:flutter_base/src/features/home_page/domain/repositories/movie_repository.dart';

class GetMoviesUseCase {
  final MovieRepository _repository;

  GetMoviesUseCase(this._repository);

  Future<MovieListResponse> call({required int page}) {
    return _repository.getMovies(page: page);
  }
}
