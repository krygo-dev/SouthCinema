import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/movies/domain/entities/movie.dart';
import 'package:south_cinema/features/movies/domain/repositories/movies_repository.dart';
import 'package:south_cinema/features/movies/domain/usecases/get_movie_by_id.dart';

import 'get_movie_by_id_test.mocks.dart';

@GenerateMocks([MoviesRepository])

void main() {
  late GetMovieById usecase;
  late MockMoviesRepository mockMoviesRepository;

  setUp(() {
    mockMoviesRepository = MockMoviesRepository();
    usecase = GetMovieById(mockMoviesRepository);
  });

  const tId = 'id';
  const tGettingDataError = GettingDataError();
  final tMovie = sampleListOfMovies.first;

  test('should return Movie for provided id from repository', () async {
    // arrange
    when(mockMoviesRepository.getMovieById(id: anyNamed('id'))).thenAnswer((_) async => Right(tMovie));
    // act
    final result = await usecase(id: tId);
    // assert
    expect(result, Right(tMovie));
    verify(mockMoviesRepository.getMovieById(id: tId));
    verifyNoMoreInteractions(mockMoviesRepository);
  });

  test('should return error when getting data was unsuccessful', () async {
    // arrange
    when(mockMoviesRepository.getMovieById(id: anyNamed('id')))
        .thenAnswer((_) async => const Left(tGettingDataError));
    // act
    final result = await usecase(id: tId);
    // assert
    expect(result, const Left(tGettingDataError));
    verify(mockMoviesRepository.getMovieById(id: tId));
    verifyNoMoreInteractions(mockMoviesRepository);
  });
}