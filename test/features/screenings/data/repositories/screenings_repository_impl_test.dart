import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/core/network/network_info.dart';
import 'package:south_cinema/features/screenings/data/datasources/screenings_service.dart';
import 'package:south_cinema/features/screenings/data/repositories/screenings_repository_impl.dart';
import 'package:south_cinema/features/screenings/domain/entities/repertoire_screening.dart';
import 'package:south_cinema/features/screenings/domain/entities/room.dart';
import 'package:south_cinema/features/screenings/domain/entities/screening.dart';

import 'screenings_repository_impl_test.mocks.dart';

@GenerateMocks([ScreeningsService, NetworkInfo])
void main() {
  late ScreeningsRepositoryImpl repositoryImpl;
  late MockScreeningsService mockScreeningsService;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockScreeningsService = MockScreeningsService();
    repositoryImpl = ScreeningsRepositoryImpl(
      screeningsService: mockScreeningsService,
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

  group('getRepertoireForDate', () {
    const tDate = '15/03/2023';
    const tRepertoireList = [
      RepertoireScreening(
        id: 'id',
        title: 'title',
        date: 'date',
        screenings: [],
      )
    ];
    const tGettingDataError = GettingDataError();

    test('should check if device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockScreeningsService.getRepertoireForDate(any))
          .thenAnswer((_) async => tRepertoireList);
      // act
      repositoryImpl.getRepertoireForDate(date: tDate);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test('''should return list of RepertoireScreening when 
        getting data for date was successful''', () async {
        // arrange
        when(mockScreeningsService.getRepertoireForDate(any))
            .thenAnswer((_) async => tRepertoireList);
        // act
        final result = await repositoryImpl.getRepertoireForDate(date: tDate);
        // assert
        verify(mockScreeningsService.getRepertoireForDate(tDate));
        expect(result, const Right(tRepertoireList));
      });

      test('should return error when getting data was unsuccessful', () async {
        // arrange
        when(mockScreeningsService.getRepertoireForDate(any))
            .thenThrow(tGettingDataError);
        // act
        final result = await repositoryImpl.getRepertoireForDate(date: tDate);
        // assert
        verify(mockScreeningsService.getRepertoireForDate(tDate));
        verifyNoMoreInteractions(mockScreeningsService);
        expect(result, const Left(tGettingDataError));
      });
    });

    runTestsOffline(() {
      test('should return NetworkError when device is offline', () async {
        // act
        final result = await repositoryImpl.getRepertoireForDate(date: tDate);
        // assert
        verifyZeroInteractions(mockScreeningsService);
        expect(result, const Left(NetworkError()));
      });
    });
  });

  group('getRoomById', () {
    const tId = 'testId';
    const tRoom = Room(id: 'testId', name: 'name', rows: 10, rowsLength: 10);
    const tGettingDataError = GettingDataError();

    test('should check if device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockScreeningsService.getRoomById(any))
          .thenAnswer((_) async => tRoom);
      // act
      repositoryImpl.getRoomById(id: tId);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test('should return Room when getting data for id was successful',
          () async {
        // arrange
        when(mockScreeningsService.getRoomById(any))
            .thenAnswer((_) async => tRoom);
        // act
        final result = await repositoryImpl.getRoomById(id: tId);
        // assert
        verify(mockScreeningsService.getRoomById(tId));
        expect(result, const Right(tRoom));
      });

      test('should return error when getting data was unsuccessful', () async {
        // arrange
        when(mockScreeningsService.getRoomById(any))
            .thenThrow(tGettingDataError);
        // act
        final result = await repositoryImpl.getRoomById(id: tId);
        // assert
        verify(mockScreeningsService.getRoomById(tId));
        verifyNoMoreInteractions(mockScreeningsService);
        expect(result, const Left(tGettingDataError));
      });
    });

    runTestsOffline(() {
      test('should return NetworkError when device is offline', () async {
        // act
        final result = await repositoryImpl.getRoomById(id: tId);
        // assert
        verifyZeroInteractions(mockScreeningsService);
        expect(result, const Left(NetworkError()));
      });
    });
  });

  group('getScreeningById', () {
    const tId = 'testId';
    const tGettingDataError = GettingDataError();
    final tScreening = Screening(
      id: 'testId',
      date: Timestamp.fromDate(DateTime(2023, 3, 15)),
      movieID: 'movieID',
      movieTitle: 'movieTitle',
      roomID: 'roomID',
      reservationOn: true,
      seatsTaken: const ['0101', '0102'],
    );

    test('should check if device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockScreeningsService.getScreeningById(any))
          .thenAnswer((_) async => tScreening);
      // act
      repositoryImpl.getScreeningById(id: tId);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test('should return Screening when getting data for id was successful',
          () async {
        // arrange
        when(mockScreeningsService.getScreeningById(any))
            .thenAnswer((_) async => tScreening);
        // act
        final result = await repositoryImpl.getScreeningById(id: tId);
        // assert
        verify(mockScreeningsService.getScreeningById(tId));
        expect(result, Right(tScreening));
      });

      test('should return error when getting data was unsuccessful', () async {
        // arrange
        when(mockScreeningsService.getScreeningById(any))
            .thenThrow(tGettingDataError);
        // act
        final result = await repositoryImpl.getScreeningById(id: tId);
        // assert
        verify(mockScreeningsService.getScreeningById(tId));
        verifyNoMoreInteractions(mockScreeningsService);
        expect(result, const Left(tGettingDataError));
      });
    });

    runTestsOffline(() {
      test('should return NetworkError when device is offline', () async {
        // act
        final result = await repositoryImpl.getScreeningById(id: tId);
        // assert
        verifyZeroInteractions(mockScreeningsService);
        expect(result, const Left(NetworkError()));
      });
    });
  });
}
