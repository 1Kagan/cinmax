import 'package:flutter_base/src/features/home_page/domain/entities/movie.dart';

class MovieListResponse {
  final List<Movie> movies;
  final int maxPage;

  MovieListResponse({required this.movies, required this.maxPage});
}

abstract class MovieRepository {
  Future<MovieListResponse> getMovies({required int page});
  Future<void> toggleFavorite(String movieId);
}
