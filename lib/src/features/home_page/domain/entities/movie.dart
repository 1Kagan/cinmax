import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final String id;
  final String title;
  final String poster;
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

  const Movie({
    required this.id,
    required this.title,
    required this.poster,
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

  Movie copyWith({
    String? id,
    String? title,
    String? poster,
    String? plot,
    String? year,
    String? rated,
    String? released,
    String? runtime,
    String? genre,
    String? director,
    String? writer,
    String? actors,
    String? language,
    String? country,
    String? awards,
    String? metascore,
    String? imdbRating,
    String? imdbVotes,
    List<String>? images,
    bool? isFavorite,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
      poster: poster ?? this.poster,
      plot: plot ?? this.plot,
      year: year ?? this.year,
      rated: rated ?? this.rated,
      released: released ?? this.released,
      runtime: runtime ?? this.runtime,
      genre: genre ?? this.genre,
      director: director ?? this.director,
      writer: writer ?? this.writer,
      actors: actors ?? this.actors,
      language: language ?? this.language,
      country: country ?? this.country,
      awards: awards ?? this.awards,
      metascore: metascore ?? this.metascore,
      imdbRating: imdbRating ?? this.imdbRating,
      imdbVotes: imdbVotes ?? this.imdbVotes,
      images: images ?? this.images,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory Movie.fromJson(Map<String, dynamic> json) {
    var poster = json['Poster'] as String? ?? '';
    if (poster.startsWith('http://')) {
      poster = poster.replaceFirst('http://', 'https://');
    }
    return Movie(
      id: json['_id'] as String? ?? '',
      title: json['Title'] as String? ?? '',
      poster: poster,
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
  List<Object> get props => [
        id,
        title,
        poster,
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
