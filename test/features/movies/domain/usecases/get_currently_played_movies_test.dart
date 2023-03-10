import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/movies/domain/entities/movie.dart';
import 'package:south_cinema/features/movies/domain/repositories/movies_repository.dart';
import 'package:south_cinema/features/movies/domain/usecases/get_currently_played_movies.dart';

import 'get_currently_played_movies_test.mocks.dart';

@GenerateMocks([MoviesRepository])
void main() {
  late GetCurrentlyPlayedMovies usecase;
  late MockMoviesRepository mockMoviesRepository;

  setUp(() {
    mockMoviesRepository = MockMoviesRepository();
    usecase = GetCurrentlyPlayedMovies(mockMoviesRepository);
  });

  const tMoviesList = sampleListOfMovies;
  const tGettingDataError = GettingDataError();

  test('should get list of currently played movies from the repository', () async {
    // arrange
    when(mockMoviesRepository.getCurrentlyPlayedMovies())
        .thenAnswer((_) async => const Right(tMoviesList));
    // act
    final result = await usecase();
    // assert
    expect(result, const Right(tMoviesList));
    verify(mockMoviesRepository.getCurrentlyPlayedMovies());
    verifyNoMoreInteractions(mockMoviesRepository);
  });

  test('should return error when getting data was unsuccessful', () async {
    // arrange
    when(mockMoviesRepository.getCurrentlyPlayedMovies())
        .thenAnswer((_) async => const Left(tGettingDataError));
    // act
    final result = await usecase();
    // assert
    expect(result, const Left(tGettingDataError));
    verify(mockMoviesRepository.getCurrentlyPlayedMovies());
    verifyNoMoreInteractions(mockMoviesRepository);
  });
}
