import 'package:equatable/equatable.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object> get props => [];
}

class MoviesFetched extends HomePageEvent {}

class MoviesRefreshed extends HomePageEvent {}

class HomePageIndexChanged extends HomePageEvent {
  final int index;
  const HomePageIndexChanged(this.index);

  @override
  List<Object> get props => [index];
}

class CardExpansionChanged extends HomePageEvent {
  final bool isExpanded;
  const CardExpansionChanged(this.isExpanded);

  @override
  List<Object> get props => [isExpanded];
}

class FavoriteTogglePressed extends HomePageEvent {
  final String movieId;

  const FavoriteTogglePressed(this.movieId);

  @override
  List<Object> get props => [movieId];
}
