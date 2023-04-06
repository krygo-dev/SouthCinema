import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final String id;
  final int ageRestriction;
  final String description;
  final String director;
  final String distribution;
  final String format;
  final String posterUrl;
  final String premiereDate;
  final String productionCountry;
  final String title;
  final String trailerUrl;
  final int durationMin;
  final bool subtitles;
  final bool currentlyPlayed;
  final List<String> cast;
  final List<String> genre;

  const Movie({
    required this.id,
    required this.ageRestriction,
    required this.description,
    required this.director,
    required this.distribution,
    required this.format,
    required this.posterUrl,
    required this.premiereDate,
    required this.productionCountry,
    required this.title,
    required this.trailerUrl,
    required this.durationMin,
    required this.subtitles,
    required this.currentlyPlayed,
    required this.cast,
    required this.genre,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      ageRestriction: json['ageRestriction'],
      description: json['description'],
      director: json['director'],
      distribution: json['distribution'],
      format: json['format'],
      posterUrl: json['posterUrl'],
      premiereDate: json['premiereDate'],
      productionCountry: json['productionCountry'],
      title: json['title'],
      trailerUrl: json['trailerUrl'],
      durationMin: json['durationMin'],
      subtitles: json['subtitles'],
      currentlyPlayed: json['currentlyPlayed'],
      cast: (json['cast']! as List).cast<String>(),
      genre: (json['genre']! as List).cast<String>(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        ageRestriction,
        description,
        director,
        distribution,
        format,
        posterUrl,
        premiereDate,
        productionCountry,
        title,
        trailerUrl,
        durationMin,
        subtitles,
        currentlyPlayed,
        cast,
        genre,
      ];
}

const sampleListOfMovies = [
  Movie(
    id: "id",
    ageRestriction: 15,
    description: "description",
    director: "director",
    distribution: "distribution",
    format: "format",
    posterUrl: "posterUrl",
    premiereDate: "premiereDate",
    productionCountry: "productionCountry",
    title: "title",
    trailerUrl: "trailerUrl",
    durationMin: 100,
    subtitles: true,
    currentlyPlayed: true,
    cast: ["Test", "Test2"],
    genre: ["SF"],
  ),
  Movie(
    id: "id",
    ageRestriction: 15,
    description: "description",
    director: "director",
    distribution: "distribution",
    format: "format",
    posterUrl: "posterUrl",
    premiereDate: "premiereDate",
    productionCountry: "productionCountry",
    title: "title",
    trailerUrl: "trailerUrl",
    durationMin: 130,
    subtitles: true,
    currentlyPlayed: true,
    cast: ["Test3", "Test4"],
    genre: ["SF"],
  ),
];
