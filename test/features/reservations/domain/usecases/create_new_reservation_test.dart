import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/reservations/domain/entities/reservation.dart';
import 'package:south_cinema/features/reservations/domain/repositories/reservations_repository.dart';
import 'package:south_cinema/features/reservations/domain/usecases/create_new_reservation.dart';

import 'create_new_reservation_test.mocks.dart';

@GenerateMocks([ReservationsRepository])
void main() {
  late CreateNewReservation usecase;
  late MockReservationsRepository mockReservationsRepository;

  setUp(() {
    mockReservationsRepository = MockReservationsRepository();
    usecase = CreateNewReservation(mockReservationsRepository);
  });

  final tReservation = Reservation(
    id: 'id',
    screeningId: 'screeningId',
    userId: 'userId',
    createdAt: Timestamp.now(),
    phoneNumber: 'phoneNumber',
    seats: const ['0101', '0102'],
  );
  const tSettingDataError = SettingDataError();

  test('should return true when creating new reservation was successful',
      () async {
    // arrange
    when(mockReservationsRepository.createNewReservation(
      reservation: anyNamed('reservation'),
    )).thenAnswer((_) async => const Right(true));
    // act
    final result = await usecase(reservation: tReservation);
    // assert
    expect(result, const Right(true));
    verify(mockReservationsRepository.createNewReservation(
        reservation: tReservation));
    verifyNoMoreInteractions(mockReservationsRepository);
  });

  test('should return error when creating new reservation was unsuccessful',
      () async {
    // arrange
    when(mockReservationsRepository.createNewReservation(
      reservation: anyNamed('reservation'),
    )).thenAnswer((_) async => const Left(tSettingDataError));
    // act
    final result = await usecase(reservation: tReservation);
    // assert
    expect(result, const Left(tSettingDataError));
    verify(mockReservationsRepository.createNewReservation(
        reservation: tReservation));
    verifyNoMoreInteractions(mockReservationsRepository);
  });
}
