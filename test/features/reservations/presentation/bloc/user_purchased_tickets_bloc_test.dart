import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/reservations/domain/entities/purchase.dart';
import 'package:south_cinema/features/reservations/domain/usecases/get_user_purchased_tickets.dart';
import 'package:south_cinema/features/reservations/presentation/bloc/user_purchased_tickets_bloc.dart';

import 'user_purchased_tickets_bloc_test.mocks.dart';

@GenerateMocks([GetUserPurchasedTickets])
void main() {
  late UserPurchasedTicketsBloc bloc;
  late MockGetUserPurchasedTickets mockGetUserPurchasedTickets;

  setUp(() {
    mockGetUserPurchasedTickets = MockGetUserPurchasedTickets();
    bloc = UserPurchasedTicketsBloc(
      getUserPurchasedTickets: mockGetUserPurchasedTickets,
    );
  });

  test('initial state should be Empty', () {
    // assert
    expect(bloc.state, equals(UserPurchasedTicketsEmpty()));
  });

  group('getUserPurchasedTickets', () {
    const tUid = '01234';
    final tPurchasedTicketsList = [
      Purchase(
        id: 'id',
        screeningId: 'screeningId',
        userId: '01234',
        fullName: 'fullName',
        createdAt: Timestamp.now(),
        phoneNumber: '+48777888999',
        email: 'email',
        tickets: const {'0101': 'ADULT', '0102': 'STUDENT'},
        totalPrice: 11.0,
      ),
      Purchase(
        id: 'id',
        screeningId: 'screeningId',
        userId: '01234',
        fullName: 'fullName',
        createdAt: Timestamp.now(),
        phoneNumber: '+48777888999',
        email: 'email',
        tickets: const {'0201': 'ADULT', '0202': 'STUDENT'},
        totalPrice: 11.0,
      ),
    ];

    test('''should call GetUserPurchasedTickets usecase to get list of Purchase 
      entity for provided uid''', () async {
      // arrange
      when(mockGetUserPurchasedTickets(uid: anyNamed('uid')))
          .thenAnswer((_) async => Right(tPurchasedTicketsList));
      // act
      bloc.add(GetUserPurchasedTicketsEvent(tUid));
      await untilCalled(mockGetUserPurchasedTickets(uid: anyNamed('uid')));
      // assert
      verify(mockGetUserPurchasedTickets(uid: tUid));
    });

    test('should emit [Loading, Loaded] when getting data was successful', () async {
      // arrange
      when(mockGetUserPurchasedTickets(uid: anyNamed('uid')))
          .thenAnswer((_) async => Right(tPurchasedTicketsList));
      // assert later
      final expected = [
        UserPurchasedTicketsLoading(),
        UserPurchasedTicketsLoaded(purchasedTicketsList: tPurchasedTicketsList),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(GetUserPurchasedTicketsEvent(tUid));
    });

    test('should emit [Loading, Error] when getting data fails', () async {
      // arrange
      when(mockGetUserPurchasedTickets(uid: anyNamed('uid')))
          .thenAnswer((_) async => const Left(GettingDataError()));
      // assert later
      final expected = [
        UserPurchasedTicketsLoading(),
        UserPurchasedTicketsError(message: const GettingDataError().message),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(GetUserPurchasedTicketsEvent(tUid));
    });

    test('''should emit [Loading, Error] with proper message for the 
      error when getting data fails''', () async {
      // arrange
      when(mockGetUserPurchasedTickets(uid: anyNamed('uid')))
          .thenAnswer((_) async => const Left(NetworkError()));
      // assert later
      final expected = [
        UserPurchasedTicketsLoading(),
        UserPurchasedTicketsError(message: const NetworkError().message),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(GetUserPurchasedTicketsEvent(tUid));
    });
  });
}
