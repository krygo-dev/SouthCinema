import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/reservations/domain/entities/purchase.dart';
import 'package:south_cinema/features/reservations/domain/repositories/reservations_repository.dart';
import 'package:south_cinema/features/reservations/domain/usecases/get_user_purchased_tickets.dart';

import 'get_user_purchased_tickets_test.mocks.dart';

@GenerateMocks([ReservationsRepository])
void main() {
  late GetUserPurchasedTickets usecase;
  late MockReservationsRepository mockReservationsRepository;

  setUp(() {
    mockReservationsRepository = MockReservationsRepository();
    usecase = GetUserPurchasedTickets(mockReservationsRepository);
  });

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
    ),
  ];
  const tGettingDataError = GettingDataError();
  const tId = 'userId';

  test(
      'should return list of Purchase entity when getting data was successful',
          () async {
        // arrange
        when(mockReservationsRepository.getUserPurchasedTickets(uid: anyNamed('uid')))
            .thenAnswer((_) async => Right(tPurchasedTicketsList));
        // act
        final result = await usecase(uid: tId);
        // arrange
        expect(result, Right(tPurchasedTicketsList));
        verify(mockReservationsRepository.getUserPurchasedTickets(uid: tId));
        verifyNoMoreInteractions(mockReservationsRepository);
      });

  test('should return error when getting data was unsuccessful', () async {
    // arrange
    when(mockReservationsRepository.getUserPurchasedTickets(uid: anyNamed('uid')))
        .thenAnswer((_) async => const Left(tGettingDataError));
    // act
    final result = await usecase(uid: tId);
    // arrange
    expect(result, const Left(tGettingDataError));
    verify(mockReservationsRepository.getUserPurchasedTickets(uid: tId));
    verifyNoMoreInteractions(mockReservationsRepository);
  });
}
