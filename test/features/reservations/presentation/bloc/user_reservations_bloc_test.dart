import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/reservations/domain/entities/reservation.dart';
import 'package:south_cinema/features/reservations/domain/usecases/get_user_reservations.dart';
import 'package:south_cinema/features/reservations/presentation/bloc/user_reservations_bloc.dart';

import 'user_reservations_bloc_test.mocks.dart';

@GenerateMocks([GetUserReservations])
void main() {
  late UserReservationsBloc bloc;
  late MockGetUserReservations mockGetUserReservations;

  setUp(() {
    mockGetUserReservations = MockGetUserReservations();
    bloc = UserReservationsBloc(getUserReservation: mockGetUserReservations);
  });

  test('initial state should be Empty', () {
    // assert
    expect(bloc.state, equals(UserReservationsEmpty()));
  });

  group('getUserReservations', () {
    const tUid = '01234';
    final tResList = [
      Reservation(
        id: 'id',
        screeningId: 'screeningId',
        userId: '01234',
        fullName: 'fullName',
        createdAt: Timestamp.now(),
        phoneNumber: '+48999000999',
        email: 'email',
        seats: const ['0101', '0102'],
      ),
      Reservation(
        id: 'id2',
        screeningId: 'screeningId',
        userId: '01234',
        fullName: 'fullName',
        createdAt: Timestamp.now(),
        phoneNumber: '+48999000999',
        email: 'email',
        seats: const ['0201', '0202'],
      )
    ];

    test('''should call GetUserReservations usecase to get list of Reservation 
      entity for provided uid''', () async {
      // arrange
      when(mockGetUserReservations(uid: anyNamed('uid')))
          .thenAnswer((_) async => Right(tResList));
      // act
      bloc.add(GetUserReservationsEvent(tUid));
      await untilCalled(mockGetUserReservations(uid: anyNamed('uid')));
      // assert
      verify(mockGetUserReservations(uid: tUid));
    });

    test('should emit [Loading, Loaded] when getting data was successful', () async {
      // arrange
      when(mockGetUserReservations(uid: anyNamed('uid')))
          .thenAnswer((_) async => Right(tResList));
      // assert later
      final expected = [
        UserReservationsLoading(),
        UserReservationsLoaded(reservationsList: tResList),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(GetUserReservationsEvent(tUid));
    });

    test('should emit [Loading, Error] when getting data fails', () async {
      // arrange
      when(mockGetUserReservations(uid: anyNamed('uid')))
          .thenAnswer((_) async => const Left(GettingDataError()));
      // assert later
      final expected = [
        UserReservationsLoading(),
        UserReservationsError(message: const GettingDataError().message),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(GetUserReservationsEvent(tUid));
    });

    test('''should emit [Loading, Error] with proper message for the 
      error when getting data fails''', () async {
      // arrange
      when(mockGetUserReservations(uid: anyNamed('uid')))
          .thenAnswer((_) async => const Left(NetworkError()));
      // assert later
      final expected = [
        UserReservationsLoading(),
        UserReservationsError(message: const NetworkError().message),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(GetUserReservationsEvent(tUid));
    });
  });
}
