import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/core/network/network_info.dart';
import 'package:south_cinema/features/reservations/data/datasources/reservations_service.dart';
import 'package:south_cinema/features/reservations/data/repositories/reservations_repository_impl.dart';
import 'package:south_cinema/features/reservations/domain/entities/reservation.dart';

import 'reservations_repository_impl_test.mocks.dart';

@GenerateMocks([ReservationService, NetworkInfo])
void main() {
  late ReservationsRepositoryImpl repositoryImpl;
  late MockReservationService mockReservationService;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockReservationService = MockReservationService();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = ReservationsRepositoryImpl(
      reservationService: mockReservationService,
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

  group('createNewReservation', () {
    final tReservation = Reservation(
      id: 'id',
      screeningId: 'screeningId',
      userId: 'userId',
      createdAt: Timestamp.now(),
      phoneNumber: 'phoneNumber',
      seats: const ['0101', '0102'],
    );
    const tSettingDataError = SettingDataError();

    test('should check if device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockReservationService.createNewReservation(any))
          .thenAnswer((_) async => true);
      // act
      repositoryImpl.createNewReservation(reservation: tReservation);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test('should return true when creating reservation was successful',
          () async {
        // arrange
        when(mockReservationService.createNewReservation(any))
            .thenAnswer((_) async => true);
        // act
        final result = await repositoryImpl.createNewReservation(
          reservation: tReservation,
        );
        // assert
        verify(mockReservationService.createNewReservation(tReservation));
        expect(result, const Right(true));
      });

      test('should return error when creating reservation was unsuccessful',
          () async {
        // arrange
        when(mockReservationService.createNewReservation(any))
            .thenThrow(tSettingDataError);
        // act
        final result = await repositoryImpl.createNewReservation(
          reservation: tReservation,
        );
        // assert
        verify(mockReservationService.createNewReservation(tReservation));
        verifyNoMoreInteractions(mockReservationService);
        expect(result, const Left(tSettingDataError));
      });
    });

    runTestsOffline(() {
      test('should return NetworkError when device is offline', () async {
        // act
        final result = await repositoryImpl.createNewReservation(
          reservation: tReservation,
        );
        // assert
        verifyZeroInteractions(mockReservationService);
        expect(result, const Left(NetworkError()));
      });
    });
  });

  group('getUserReservations', () {
    const tId = 'userId';
    final tReservationsList = [
      Reservation(
        id: 'id',
        screeningId: 'screeningId',
        userId: 'userId',
        createdAt: Timestamp.now(),
        phoneNumber: 'phoneNumber',
        seats: const ['0101', '0102'],
      ),
      Reservation(
        id: 'id2',
        screeningId: 'screeningId2',
        userId: 'userId',
        createdAt: Timestamp.now(),
        phoneNumber: 'phoneNumber',
        seats: const ['0101', '0102'],
      )
    ];
    const tGettingDataError = GettingDataError();

    test('should check if device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockReservationService.getUserReservations(any))
          .thenAnswer((_) async => tReservationsList);
      // act
      repositoryImpl.getUserReservations(uid: tId);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test('should return list of Reservation when getting data was successful',
          () async {
        // arrange
        when(mockReservationService.getUserReservations(any))
            .thenAnswer((_) async => tReservationsList);
        // act
        final result = await repositoryImpl.getUserReservations(uid: tId);
        // assert
        verify(mockReservationService.getUserReservations(tId));
        expect(result, Right(tReservationsList));
      });

      test('should return error when getting data was unsuccessful', () async {
        // arrange
        when(mockReservationService.getUserReservations(any))
            .thenThrow(tGettingDataError);
        // act
        final result = await repositoryImpl.getUserReservations(uid: tId);
        // assert
        verify(mockReservationService.getUserReservations(tId));
        verifyNoMoreInteractions(mockReservationService);
        expect(result, const Left(tGettingDataError));
      });
    });

    runTestsOffline(() {
      test('should return NetworkError when device is offline', () async {
        // act
        final result = await repositoryImpl.getUserReservations(uid: tId);
        // assert
        verifyZeroInteractions(mockReservationService);
        expect(result, const Left(NetworkError()));
      });
    });
  });
}
