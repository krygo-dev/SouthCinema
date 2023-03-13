import 'package:flutter_test/flutter_test.dart';
import 'package:south_cinema/features/movies/domain/entities/movie.dart';

void main() {
  test('should return valid Movie entity from json', () {
    // arrange
    const tMovie = Movie(
      id: 'id',
      ageRestriction: 15,
      description: 'description',
      director: 'director',
      distribution: 'distribution',
      format: 'format',
      posterUrl: 'posterUrl',
      premiereDate: 'premiereDate',
      productionCountry: 'productionCountry',
      title: 'title',
      trailerUrl: 'trailerUrl',
      durationMin: 120,
      subtitles: false,
      cast: ['test', 'test2'],
      genre: ['test', 'test2'],
    );

    const tJson = {
      'id': 'id',
      'ageRestriction': 15,
      'description': 'description',
      'director': 'director',
      'distribution': 'distribution',
      'format': 'format',
      'posterUrl': 'posterUrl',
      'premiereDate': 'premiereDate',
      'productionCountry': 'productionCountry',
      'title': 'title',
      'trailerUrl': 'trailerUrl',
      'durationMin': 120,
      'subtitles': false,
      'cast': ['test', 'test2'],
      'genre': ['test', 'test2'],
    };
    // act
    final result = Movie.fromJson(tJson);
    // assert
    expect(result, tMovie);
  });
}
