import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/core/network/network_info.dart';
import 'package:south_cinema/features/movies/data/datasources/movies_service.dart';
import 'package:south_cinema/features/movies/data/repositories/movies_repository_impl.dart';
import 'package:south_cinema/features/movies/domain/entities/movie.dart';

import 'movies_repository_impl_test.mocks.dart';

@GenerateMocks([MoviesService, NetworkInfo])
void main() {
  late MoviesRepositoryImpl repositoryImpl;
  late MockMoviesService mockMoviesService;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockMoviesService = MockMoviesService();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = MoviesRepositoryImpl(
      moviesService: mockMoviesService,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getCurrentlyPlayedMovies', () {
    const tMoviesList = sampleListOfMovies;
    const tGettingDataError = GettingDataError();

    test('should check if device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockMoviesService.getCurrentlyPlayedMovies())
          .thenAnswer((_) async => tMoviesList);
      // act
      repositoryImpl.getCurrentlyPlayedMovies();
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test('''should return list of Movie entity when 
        getting currently played movies data was successful''', () async {
        // arrange
        when(mockMoviesService.getCurrentlyPlayedMovies())
            .thenAnswer((_) async => tMoviesList);
        // act
        final result = await repositoryImpl.getCurrentlyPlayedMovies();
        // assert
        verify(mockMoviesService.getCurrentlyPlayedMovies());
        expect(result, const Right(tMoviesList));
      });

      test('should return error when getting data was unsuccessful', () async {
        // arrange
        when(mockMoviesService.getCurrentlyPlayedMovies())
            .thenThrow(tGettingDataError);
        // act
        final result = await repositoryImpl.getCurrentlyPlayedMovies();
        // assert
        verify(mockMoviesService.getCurrentlyPlayedMovies());
        verifyNoMoreInteractions(mockMoviesService);
        expect(result, const Left(tGettingDataError));
      });
    });

    runTestsOffline(() {
      test('should return NetworkError when device is offline', () async {
        // act
        final result = await repositoryImpl.getCurrentlyPlayedMovies();
        // assert
        verifyZeroInteractions(mockMoviesService);
        expect(result, const Left(NetworkError()));
      });
    });
  });

  group('getAnnouncedMovies', () {
    const tMoviesList = sampleListOfMovies;
    const tGettingDataError = GettingDataError();

    test('should check if device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockMoviesService.getAnnouncedMovies())
          .thenAnswer((_) async => tMoviesList);
      // act
      repositoryImpl.getAnnouncedMovies();
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test('''should return list of Movie entity when 
        getting announced movies data was successful''', () async {
        // arrange
        when(mockMoviesService.getAnnouncedMovies())
            .thenAnswer((_) async => tMoviesList);
        // act
        final result = await repositoryImpl.getAnnouncedMovies();
        // assert
        verify(mockMoviesService.getAnnouncedMovies());
        expect(result, const Right(tMoviesList));
      });

      test('should return error when getting data was unsuccessful', () async {
        // arrange
        when(mockMoviesService.getAnnouncedMovies())
            .thenThrow(tGettingDataError);
        // act
        final result = await repositoryImpl.getAnnouncedMovies();
        // assert
        verify(mockMoviesService.getAnnouncedMovies());
        verifyNoMoreInteractions(mockMoviesService);
        expect(result, const Left(tGettingDataError));
      });
    });

    runTestsOffline(() {
      test('should return NetworkError when device is offline', () async {
        // act
        final result = await repositoryImpl.getAnnouncedMovies();
        // assert
        verifyZeroInteractions(mockMoviesService);
        expect(result, const Left(NetworkError()));
      });
    });
  });

  group('getMovieById', () {
    const tId = 'id';
    final tMovie = sampleListOfMovies[0];
    const tGettingDataError = GettingDataError();

    test('should check if device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockMoviesService.getMovieById(id: anyNamed('id')))
          .thenAnswer((_) async => tMovie);
      // act
      repositoryImpl.getMovieById(id: tId);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test('''should return Movie entity when getting 
        data for provided id was successful''', () async {
        // arrange
        when(mockMoviesService.getMovieById(id: anyNamed('id')))
            .thenAnswer((_) async => tMovie);
        // act
        final result = await repositoryImpl.getMovieById(id: tId);
        // assert
        verify(mockMoviesService.getMovieById(id: tId));
        expect(result, Right(tMovie));
      });

      test('should return error when getting data was unsuccessful', () async {
        // arrange
        when(mockMoviesService.getMovieById(id: anyNamed('id'))).thenThrow(tGettingDataError);
        // act
        final result = await repositoryImpl.getMovieById(id: tId);
        // assert
        verify(mockMoviesService.getMovieById(id: tId));
        verifyNoMoreInteractions(mockMoviesService);
        expect(result, const Left(tGettingDataError));
      });
    });

    runTestsOffline(() {
      test('should return NetworkError when device is offline', () async {
        // act
        final result = await repositoryImpl.getMovieById(id: tId);
        // assert
        verifyZeroInteractions(mockMoviesService);
        expect(result, const Left(NetworkError()));
      });
    });
  });
}
