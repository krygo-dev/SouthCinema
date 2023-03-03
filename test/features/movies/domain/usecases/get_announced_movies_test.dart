import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:south_cinema/features/movies/domain/entities/movie.dart';
import 'package:south_cinema/features/movies/domain/repositories/movies_repository.dart';
import 'package:south_cinema/features/movies/domain/usecases/get_announced_movies.dart';

import 'get_announced_movies_test.mocks.dart';

@GenerateMocks([MoviesRepository])
void main() {
  late GetAnnouncedMovies usecase;
  late MockMoviesRepository mockMoviesRepository;

  setUp(() {
    mockMoviesRepository = MockMoviesRepository();
    usecase = GetAnnouncedMovies(mockMoviesRepository);
  });

  const tMoviesList = sampleListOfMovies;

  test('should get list of announced movies from the repository', () async {
    // arrange
    when(mockMoviesRepository.getAnnouncedMovies())
        .thenAnswer((_) async => const Right(tMoviesList));
    // act
    final result = await usecase();
    // assert
    expect(result, const Right(tMoviesList));
    verify(mockMoviesRepository.getAnnouncedMovies());
    verifyNoMoreInteractions(mockMoviesRepository);
  });
}
