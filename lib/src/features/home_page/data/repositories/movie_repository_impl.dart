import 'package:flutter_base/src/core/network/dio_client.dart';
import 'package:flutter_base/src/features/home_page/domain/entities/movie.dart';
import 'package:flutter_base/src/features/home_page/domain/repositories/movie_repository.dart';
import 'package:flutter_base/src/injector.dart';

class MovieRepositoryImpl implements MovieRepository {
  final _dio = injector<DioClient>();

  @override
  Future<MovieListResponse> getMovies({required int page}) async {
    try {
      final response =
          await _dio.get('/movie/list', queryParameters: {'page': page});
      final data = response.data['data'] as Map<String, dynamic>;
      final moviesData = data['movies'] as List;
      final paginationData = data['pagination'] as Map<String, dynamic>;

      final movies = moviesData
          .map((movie) => Movie.fromJson(movie as Map<String, dynamic>))
          .toList();
      final maxPage = paginationData['maxPage'] as int;

      return MovieListResponse(movies: movies, maxPage: maxPage);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> toggleFavorite(String movieId) async {
    try {
      await _dio.post('/movie/favorite/$movieId');
    } catch (e) {
      rethrow;
    }
  }
}
