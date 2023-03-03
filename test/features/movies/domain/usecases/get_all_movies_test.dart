import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:south_cinema/features/movies/domain/entities/movie.dart';
import 'package:south_cinema/features/movies/domain/repositories/movies_repository.dart';
import 'package:south_cinema/features/movies/domain/usecases/get_all_movies.dart';

import 'get_all_movies_test.mocks.dart';

@GenerateMocks([MoviesRepository])
void main() {
  late GetAllMovies usecase;
  late MockMoviesRepository mockMoviesRepository;

  setUp(() {
    mockMoviesRepository = MockMoviesRepository();
    usecase = GetAllMovies(mockMoviesRepository);
  });

  const tMoviesList = sampleListOfMovies;

  test('should get list of all movies from the repository', () async {
    // arrange
    when(mockMoviesRepository.getAllMovies())
        .thenAnswer((_) async => const Right(tMoviesList));
    // act
    final result = await usecase();
    // assert
    expect(result, const Right(tMoviesList));
    verify(mockMoviesRepository.getAllMovies());
    verifyNoMoreInteractions(mockMoviesRepository);
  });
}
