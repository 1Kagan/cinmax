import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base/src/features/home_page/domain/use_cases/get_movies_usecase.dart';
import 'package:flutter_base/src/features/home_page/domain/use_cases/toggle_favorite_usecase.dart';
import 'package:flutter_base/src/features/home_page/presentation/state/home_page_event.dart';
import 'package:flutter_base/src/features/home_page/presentation/state/home_page_state.dart';
import 'package:stream_transform/stream_transform.dart';

const _duration = Duration(milliseconds: 300);
EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final GetMoviesUseCase _getMoviesUseCase;
  final ToggleFavoriteUseCase _toggleFavoriteUseCase;
  HomePageBloc(this._getMoviesUseCase, this._toggleFavoriteUseCase)
      : super(const HomePageState()) {
    on<MoviesFetched>(_onMoviesFetched, transformer: debounce(_duration));
    on<MoviesRefreshed>(_onMoviesRefreshed);
    on<HomePageIndexChanged>(_onPageIndexChanged);
    on<CardExpansionChanged>(_onCardExpansionChanged);
    on<FavoriteTogglePressed>(_onFavoriteTogglePressed);
  }

  void _onCardExpansionChanged(
    CardExpansionChanged event,
    Emitter<HomePageState> emit,
  ) {
    emit(state.copyWith(isCardExpanded: event.isExpanded));
  }

  Future<void> _onPageIndexChanged(
    HomePageIndexChanged event,
    Emitter<HomePageState> emit,
  ) async {
    emit(state.copyWith(currentMovieIndex: event.index));
  }

  Future<void> _onMoviesRefreshed(
      MoviesRefreshed event, Emitter<HomePageState> emit) async {
    emit(const HomePageState());
    await _onMoviesFetched(MoviesFetched(), emit);
  }

  Future<void> _onFavoriteTogglePressed(
    FavoriteTogglePressed event,
    Emitter<HomePageState> emit,
  ) async {
    final movieIndex = state.movies.indexWhere((m) => m.id == event.movieId);
    if (movieIndex == -1) return;

    final originalMovie = state.movies[movieIndex];
    final updatedMovie =
        originalMovie.copyWith(isFavorite: !originalMovie.isFavorite);

    var moviesCopy = List<dynamic>.from(state.movies);
    moviesCopy[movieIndex] = updatedMovie;

    emit(state.copyWith(movies: List<dynamic>.from(moviesCopy).cast()));

    try {
      await _toggleFavoriteUseCase(event.movieId);
    } catch (e) {
      moviesCopy = List<dynamic>.from(state.movies);
      moviesCopy[movieIndex] = originalMovie;
      emit(state.copyWith(
        movies: List<dynamic>.from(moviesCopy).cast(),
        errorMessage: 'Could not update favorite.',
      ));
    }
  }

  Future<void> _onMoviesFetched(
      MoviesFetched event, Emitter<HomePageState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == HomePageStatus.initial) {
        final response = await _getMoviesUseCase.call(page: 1);
        return emit(
          state.copyWith(
            status: HomePageStatus.success,
            movies: response.movies,
            hasReachedMax: response.maxPage <= 1,
            currentPage: 1,
          ),
        );
      }
      final nextPage = state.currentPage + 1;
      final response = await _getMoviesUseCase.call(page: nextPage);
      emit(
        response.movies.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
                status: HomePageStatus.success,
                movies: List.of(state.movies)..addAll(response.movies),
                hasReachedMax: response.maxPage <= nextPage,
                currentPage: nextPage,
              ),
      );
    } catch (_) {
      emit(state.copyWith(status: HomePageStatus.failure));
    }
  }
}
