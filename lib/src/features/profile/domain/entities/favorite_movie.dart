import 'package:equatable/equatable.dart';

class FavoriteMovie extends Equatable {
  final String id;
  final String title;
  final String posterUrl;
  final String plot;
  final String year;
  final String rated;
  final String released;
  final String runtime;
  final String genre;
  final String director;
  final String writer;
  final String actors;
  final String language;
  final String country;
  final String awards;
  final String metascore;
  final String imdbRating;
  final String imdbVotes;
  final List<String> images;
  final bool isFavorite;

  const FavoriteMovie({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.plot,
    required this.year,
    required this.rated,
    required this.released,
    required this.runtime,
    required this.genre,
    required this.director,
    required this.writer,
    required this.actors,
    required this.language,
    required this.country,
    required this.awards,
    required this.metascore,
    required this.imdbRating,
    required this.imdbVotes,
    required this.images,
    required this.isFavorite,
  });

  factory FavoriteMovie.fromJson(Map<String, dynamic> json) {
    var poster = json['Poster'] as String? ?? '';
    if (poster.startsWith('http://')) {
      poster = poster.replaceFirst('http://', 'https://');
    }
    return FavoriteMovie(
      id: json['_id'] as String? ?? '',
      title: json['Title'] as String? ?? 'No Title',
      posterUrl: poster,
      plot: json['Plot'] as String? ?? '',
      year: json['Year'] as String? ?? '',
      rated: json['Rated'] as String? ?? '',
      released: json['Released'] as String? ?? '',
      runtime: json['Runtime'] as String? ?? '',
      genre: json['Genre'] as String? ?? '',
      director: json['Director'] as String? ?? '',
      writer: json['Writer'] as String? ?? '',
      actors: json['Actors'] as String? ?? '',
      language: json['Language'] as String? ?? '',
      country: json['Country'] as String? ?? '',
      awards: json['Awards'] as String? ?? '',
      metascore: json['Metascore'] as String? ?? '',
      imdbRating: json['imdbRating'] as String? ?? '',
      imdbVotes: json['imdbVotes'] as String? ?? '',
      images: List<String>.from(
          (json['Images'] as List<dynamic>?)?.map((e) => e.toString()) ?? []),
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        posterUrl,
        plot,
        year,
        rated,
        released,
        runtime,
        genre,
        director,
        writer,
        actors,
        language,
        country,
        awards,
        metascore,
        imdbRating,
        imdbVotes,
        images,
        isFavorite,
      ];
}
