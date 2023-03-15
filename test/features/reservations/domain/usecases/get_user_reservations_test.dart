import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/reservations/domain/entities/reservation.dart';
import 'package:south_cinema/features/reservations/domain/repositories/reservations_repository.dart';
import 'package:south_cinema/features/reservations/domain/usecases/get_user_reservations.dart';

import 'get_user_reservations_test.mocks.dart';

@GenerateMocks([ReservationsRepository])
void main() {
  late GetUserReservations usecase;
  late MockReservationsRepository mockReservationsRepository;

  setUp(() {
    mockReservationsRepository = MockReservationsRepository();
    usecase = GetUserReservations(mockReservationsRepository);
  });

  const tId = 'userId';
  const tGettingDataError = GettingDataError();
  final tReservationsList = [
    Reservation(
      id: 'id',
      screeningId: 'screeningId',
      userId: 'userId',
      createdAt: Timestamp.now(),
      phoneNumber: 'phoneNumber',
      seats: const ['0101'],
    ),
    Reservation(
      id: 'id2',
      screeningId: 'screeningId2',
      userId: 'userId2',
      createdAt: Timestamp.now(),
      phoneNumber: 'phoneNumber2',
      seats: const ['0102'],
    ),
  ];

  test(
      'should return list of Reservation entity when getting data was successful',
      () async {
    // arrange
    when(mockReservationsRepository.getUserReservations(uid: anyNamed('uid')))
        .thenAnswer((_) async => Right(tReservationsList));
    // act
    final result = await usecase(uid: tId);
    // arrange
    expect(result, Right(tReservationsList));
    verify(mockReservationsRepository.getUserReservations(uid: tId));
    verifyNoMoreInteractions(mockReservationsRepository);
  });

  test('should return error when getting data was unsuccessful', () async {
    // arrange
    when(mockReservationsRepository.getUserReservations(uid: anyNamed('uid')))
        .thenAnswer((_) async => const Left(tGettingDataError));
    // act
    final result = await usecase(uid: tId);
    // arrange
    expect(result, const Left(tGettingDataError));
    verify(mockReservationsRepository.getUserReservations(uid: tId));
    verifyNoMoreInteractions(mockReservationsRepository);
  });
}
