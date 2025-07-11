import 'package:equatable/equatable.dart';
import 'package:flutter_base/src/features/home_page/domain/entities/movie.dart';

enum HomePageStatus { initial, loading, success, failure }

class HomePageState extends Equatable {
  final HomePageStatus status;
  final List<Movie> movies;
  final int currentPage;
  final bool hasReachedMax;
  final String? errorMessage;
  final int currentMovieIndex;
  final bool isCardExpanded;

  const HomePageState({
    this.status = HomePageStatus.initial,
    this.movies = const [],
    this.currentPage = 1,
    this.hasReachedMax = false,
    this.errorMessage,
    this.currentMovieIndex = 0,
    this.isCardExpanded = false,
  });

  HomePageState copyWith({
    HomePageStatus? status,
    List<Movie>? movies,
    int? currentPage,
    bool? hasReachedMax,
    String? errorMessage,
    int? currentMovieIndex,
    bool? isCardExpanded,
  }) {
    return HomePageState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
      currentMovieIndex: currentMovieIndex ?? this.currentMovieIndex,
      isCardExpanded: isCardExpanded ?? this.isCardExpanded,
    );
  }

  @override
  List<Object?> get props => [
        status,
        movies,
        currentPage,
        hasReachedMax,
        errorMessage,
        currentMovieIndex,
        isCardExpanded,
      ];
}
