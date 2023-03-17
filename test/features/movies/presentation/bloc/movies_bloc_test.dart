import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/movies/domain/entities/movie.dart';
import 'package:south_cinema/features/movies/domain/usecases/get_announced_movies.dart';
import 'package:south_cinema/features/movies/domain/usecases/get_currently_played_movies.dart';
import 'package:south_cinema/features/movies/presentation/bloc/movies_bloc.dart';

import 'movies_bloc_test.mocks.dart';

@GenerateMocks([GetCurrentlyPlayedMovies, GetAnnouncedMovies])
void main() {
  late MoviesBloc bloc;
  late MockGetCurrentlyPlayedMovies mockGetCurrentlyPlayedMovies;
  late MockGetAnnouncedMovies mockGetAnnouncedMovies;

  setUp(() {
    mockGetCurrentlyPlayedMovies = MockGetCurrentlyPlayedMovies();
    mockGetAnnouncedMovies = MockGetAnnouncedMovies();
    bloc = MoviesBloc(
      getCurrentlyPlayedMovies: mockGetCurrentlyPlayedMovies,
      getAnnouncedMovies: mockGetAnnouncedMovies,
    );
  });

  test('initial state should be Empty', () {
    // assert
    expect(bloc.state, equals(Empty()));
  });

  group('GetCurrentlyPlayedMovies', () {
    const tMoviesList = [
      Movie(
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
        currentlyPlayed: true,
        cast: ['test', 'test2'],
        genre: ['test', 'test2'],
      )
    ];

    test('should get data from GetCurrentlyPlayedMovies usecase', () async {
      // arrange
      when(mockGetCurrentlyPlayedMovies())
          .thenAnswer((_) async => const Right(tMoviesList));
      // act
      bloc.add(GetCurrentlyPlayedMoviesEvent());
      await untilCalled(mockGetCurrentlyPlayedMovies());
      // assert
      verify(mockGetCurrentlyPlayedMovies());
    });

    test('should emit [Loading, Loaded] when getting data was successful',
        () async {
      // arrange
      when(mockGetCurrentlyPlayedMovies())
          .thenAnswer((_) async => const Right(tMoviesList));
      // assert later
      final expected = [Loading(), Loaded(moviesList: tMoviesList)];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(GetCurrentlyPlayedMoviesEvent());
    });

    test('should emit [Loading, Error] when getting data was unsuccessful',
        () async {
      // arrange
      when(mockGetCurrentlyPlayedMovies())
          .thenAnswer((_) async => const Left(GettingDataError()));
      // assert later
      final expected = [
        Loading(),
        Error(message: const GettingDataError().message),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(GetCurrentlyPlayedMoviesEvent());
    });

    test('''should emit [Loading, Error] with proper message when getting 
      data was unsuccessful''', () async {
      // arrange
      when(mockGetCurrentlyPlayedMovies())
          .thenAnswer((_) async => const Left(NetworkError()));
      // assert later
      final expected = [
        Loading(),
        Error(message: const NetworkError().message),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(GetCurrentlyPlayedMoviesEvent());
    });
  });

  group('GetAnnouncedMovies', () {
    const tMoviesList = [
      Movie(
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
        currentlyPlayed: true,
        cast: ['test', 'test2'],
        genre: ['test', 'test2'],
      )
    ];

    test('should get data from GetAnnouncedMovies usecase', () async {
      // arrange
      when(mockGetAnnouncedMovies())
          .thenAnswer((_) async => const Right(tMoviesList));
      // act
      bloc.add(GetAnnouncedMoviesEvent());
      await untilCalled(mockGetAnnouncedMovies());
      // assert
      verify(mockGetAnnouncedMovies());
    });

    test('should emit [Loading, Loaded] when getting data was successful',
            () async {
          // arrange
          when(mockGetAnnouncedMovies())
              .thenAnswer((_) async => const Right(tMoviesList));
          // assert later
          final expected = [Loading(), Loaded(moviesList: tMoviesList)];
          expectLater(bloc.stream, emitsInOrder(expected));
          // act
          bloc.add(GetAnnouncedMoviesEvent());
        });

    test('should emit [Loading, Error] when getting data was unsuccessful',
            () async {
          // arrange
          when(mockGetAnnouncedMovies())
              .thenAnswer((_) async => const Left(GettingDataError()));
          // assert later
          final expected = [
            Loading(),
            Error(message: const GettingDataError().message),
          ];
          expectLater(bloc.stream, emitsInOrder(expected));
          // act
          bloc.add(GetAnnouncedMoviesEvent());
        });

    test('''should emit [Loading, Error] with proper message when getting 
      data was unsuccessful''', () async {
      // arrange
      when(mockGetAnnouncedMovies())
          .thenAnswer((_) async => const Left(NetworkError()));
      // assert later
      final expected = [
        Loading(),
        Error(message: const NetworkError().message),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(GetAnnouncedMoviesEvent());
    });
  });
}
