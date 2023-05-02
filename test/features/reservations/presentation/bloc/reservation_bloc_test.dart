import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/reservations/domain/entities/reservation.dart';
import 'package:south_cinema/features/reservations/domain/usecases/create_new_reservation.dart';
import 'package:south_cinema/features/reservations/presentation/bloc/reservation_bloc.dart';

import 'reservation_bloc_test.mocks.dart';

@GenerateMocks([CreateNewReservation])
void main() {
  late ReservationBloc bloc;
  late MockCreateNewReservation mockCreateNewReservation;

  setUp(() {
    mockCreateNewReservation = MockCreateNewReservation();
    bloc = ReservationBloc(createNewReservation: mockCreateNewReservation);
  });

  test('initial state should be Empty', () {
    // assert
    expect(bloc.state, equals(ReservationEmpty()));
  });

  group('createNewReservation', () {
    const tResult = true;
    final tReservation = Reservation(
      id: 'id',
      screeningId: 'screeningId',
      fullName: 'fullName',
      createdAt: Timestamp.now(),
      phoneNumber: '+48999000999',
      email: 'email',
      seats: const ['0101', '0102'],
    );

    test('''should call CreateNewReservation usecase to create new 
      reservation at firebase''', () async {
      // arrange
      when(mockCreateNewReservation(reservation: anyNamed('reservation')))
          .thenAnswer((_) async => const Right(tResult));
      // act
      bloc.add(CreateNewReservationEvent(tReservation));
      await untilCalled(
          mockCreateNewReservation(reservation: anyNamed('reservation')));
      // assert
      verify(mockCreateNewReservation(reservation: tReservation));
    });

    test('''should emit [Loading, Loaded] when creating reservation 
      was successful''', () async {
      // arrange
      when(mockCreateNewReservation(reservation: anyNamed('reservation')))
          .thenAnswer((_) async => const Right(tResult));
      // assert later
      final expected = [
        ReservationLoading(),
        ReservationLoaded(reservationSuccessful: tResult),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(CreateNewReservationEvent(tReservation));
    });

    test('''should emit [Loading, Error] when creating reservation 
      was unsuccessful''', () async {
      // arrange
      when(mockCreateNewReservation(reservation: anyNamed('reservation')))
          .thenAnswer((_) async => const Left(SettingDataError()));
      // assert later
      final expected = [
        ReservationLoading(),
        ReservationError(message: const SettingDataError().message),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(CreateNewReservationEvent(tReservation));
    });

    test('''should emit [Loading, Error] with proper message for the 
      error when setting data fails''', () async {
      // arrange
      when(mockCreateNewReservation(reservation: anyNamed('reservation')))
          .thenAnswer((_) async => const Left(NetworkError()));
      // assert later
      final expected = [
        ReservationLoading(),
        ReservationError(message: const NetworkError().message),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(CreateNewReservationEvent(tReservation));
    });
  });
}
