import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/core/network/network_info.dart';
import 'package:south_cinema/features/reservations/data/datasources/purchase_service.dart';
import 'package:south_cinema/features/reservations/data/datasources/reservations_service.dart';
import 'package:south_cinema/features/reservations/data/repositories/reservations_repository_impl.dart';
import 'package:south_cinema/features/reservations/domain/entities/purchase.dart';
import 'package:south_cinema/features/reservations/domain/entities/reservation.dart';

import 'reservations_repository_impl_test.mocks.dart';

@GenerateMocks([ReservationService, PurchaseService, NetworkInfo])
void main() {
  late ReservationsRepositoryImpl repositoryImpl;
  late MockReservationService mockReservationService;
  late MockPurchaseService mockPurchaseService;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockReservationService = MockReservationService();
    mockPurchaseService = MockPurchaseService();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = ReservationsRepositoryImpl(
      reservationService: mockReservationService,
      purchaseService: mockPurchaseService,
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
      fullName: 'Full Name',
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
        fullName: 'Full Name',
        createdAt: Timestamp.now(),
        phoneNumber: 'phoneNumber',
        seats: const ['0101', '0102'],
      ),
      Reservation(
        id: 'id2',
        screeningId: 'screeningId2',
        userId: 'userId',
        fullName: 'Full Name',
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

  group('createNewPurchase', () {
    final tPurchase = Purchase(
      id: 'id',
      screeningId: 'screeningId',
      userId: 'userId',
      fullName: 'fullName',
      createdAt: Timestamp.now(),
      phoneNumber: 'phoneNumber',
      email: 'email',
      tickets: const {'0101': 'ADULT', '0102': 'STUDENT'},
      totalPrice: 15.0,
    );

    const tSettingDataError = SettingDataError();

    test('should check if device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockPurchaseService.createNewPurchase(any))
          .thenAnswer((_) async => true);
      // act
      repositoryImpl.createNewPurchase(purchase: tPurchase);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test('should return true when creating purchase was successful',
          () async {
        // arrange
        when(mockPurchaseService.createNewPurchase(any))
            .thenAnswer((_) async => true);
        // act
        final result = await repositoryImpl.createNewPurchase(
          purchase: tPurchase,
        );
        // assert
        verify(mockPurchaseService.createNewPurchase(tPurchase));
        expect(result, const Right(true));
      });

      test('should return error when creating purchase was unsuccessful',
          () async {
        // arrange
        when(mockPurchaseService.createNewPurchase(any))
            .thenThrow(tSettingDataError);
        // act
        final result = await repositoryImpl.createNewPurchase(
          purchase: tPurchase,
        );
        // assert
        verify(mockPurchaseService.createNewPurchase(tPurchase));
        verifyNoMoreInteractions(mockPurchaseService);
        expect(result, const Left(tSettingDataError));
      });
    });

    runTestsOffline(() {
      test('should return NetworkError when device is offline', () async {
        // act
        final result = await repositoryImpl.createNewPurchase(
          purchase: tPurchase,
        );
        // assert
        verifyZeroInteractions(mockPurchaseService);
        expect(result, const Left(NetworkError()));
      });
    });
  });

  group('getUserPurchasedTickets', () {
    const tId = 'id';
    const tGettingDataError = GettingDataError();
    final tPurchasedTicketsList = [
      Purchase(
        id: 'id',
        screeningId: 'screeningId',
        userId: 'userId',
        fullName: 'fullName',
        createdAt: Timestamp.now(),
        phoneNumber: 'phoneNumber',
        email: 'email',
        tickets: const {'0101': 'ADULT', '0102': 'STUDENT'},
        totalPrice: 15.0,
      ),
      Purchase(
        id: 'id2',
        screeningId: 'screeningId',
        userId: 'userId',
        fullName: 'fullName',
        createdAt: Timestamp.now(),
        phoneNumber: 'phoneNumber',
        email: 'email',
        tickets: const {'0101': 'ADULT', '0102': 'STUDENT'},
        totalPrice: 15.0,
      )
    ];

    test('should check if device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockPurchaseService.getUserPurchasedTickets(any))
          .thenAnswer((_) async => tPurchasedTicketsList);
      // act
      repositoryImpl.getUserPurchasedTickets(uid: tId);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test('should return list of Purchased tickets when getting data was successful',
              () async {
            // arrange
            when(mockPurchaseService.getUserPurchasedTickets(any))
                .thenAnswer((_) async => tPurchasedTicketsList);
            // act
            final result = await repositoryImpl.getUserPurchasedTickets(uid: tId);
            // assert
            verify(mockPurchaseService.getUserPurchasedTickets(tId));
            expect(result, Right(tPurchasedTicketsList));
          });

      test('should return error when getting data was unsuccessful', () async {
        // arrange
        when(mockPurchaseService.getUserPurchasedTickets(any))
            .thenThrow(tGettingDataError);
        // act
        final result = await repositoryImpl.getUserPurchasedTickets(uid: tId);
        // assert
        verify(mockPurchaseService.getUserPurchasedTickets(tId));
        verifyNoMoreInteractions(mockPurchaseService);
        expect(result, const Left(tGettingDataError));
      });
    });

    runTestsOffline(() {
      test('should return NetworkError when device is offline', () async {
        // act
        final result = await repositoryImpl.getUserPurchasedTickets(uid: tId);
        // assert
        verifyZeroInteractions(mockPurchaseService);
        expect(result, const Left(NetworkError()));
      });
    });
  });
}
