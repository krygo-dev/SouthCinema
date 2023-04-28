import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/reservations/domain/entities/purchase.dart';
import 'package:south_cinema/features/reservations/domain/repositories/reservations_repository.dart';
import 'package:south_cinema/features/reservations/domain/usecases/create_new_purchase.dart';

import 'create_new_purchase_test.mocks.dart';

@GenerateMocks([ReservationsRepository])
void main() {
  late CreateNewPurchase usecase;
  late MockReservationsRepository mockReservationsRepository;

  setUp(() {
    mockReservationsRepository = MockReservationsRepository();
    usecase = CreateNewPurchase(mockReservationsRepository);
  });

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

  test('should return true when creating new purchase was successful',
      () async {
    // arrange
    when(mockReservationsRepository.createNewPurchase(
      purchase: anyNamed('purchase'),
    )).thenAnswer((_) async => const Right(true));
    // act
    final result = await usecase(purchase: tPurchase);
    // assert
    expect(result, const Right(true));
    verify(mockReservationsRepository.createNewPurchase(
      purchase: tPurchase,
    ));
    verifyNoMoreInteractions(mockReservationsRepository);
  });

  test('should return error when creating new purchase was unsuccessful',
      () async {
    // arrange
    when(mockReservationsRepository.createNewPurchase(
      purchase: anyNamed('purchase'),
    )).thenAnswer((_) async => const Left(tSettingDataError));
    // act
    final result = await usecase(purchase: tPurchase);
    // assert
    expect(result, const Left(tSettingDataError));
    verify(mockReservationsRepository.createNewPurchase(
      purchase: tPurchase,
    ));
    verifyNoMoreInteractions(mockReservationsRepository);
  });
}
