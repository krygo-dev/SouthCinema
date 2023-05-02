import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/reservations/domain/entities/purchase.dart';
import 'package:south_cinema/features/reservations/domain/usecases/create_new_purchase.dart';
import 'package:south_cinema/features/reservations/presentation/bloc/purchase_bloc.dart';

import 'purchase_bloc_test.mocks.dart';

@GenerateMocks([CreateNewPurchase])
void main() {
  late PurchaseBloc bloc;
  late MockCreateNewPurchase mockCreateNewPurchase;

  setUp(() {
    mockCreateNewPurchase = MockCreateNewPurchase();
    bloc = PurchaseBloc(createNewPurchase: mockCreateNewPurchase);
  });

  test('initial state should be Empty', () {
    // assert
    expect(bloc.state, equals(PurchaseEmpty()));
  });

  group('CreateNewPurchase', () {
    const tResult = true;
    final tPurchase = Purchase(
      id: 'id',
      screeningId: 'screeningId',
      fullName: 'fullName',
      createdAt: Timestamp.now(),
      phoneNumber: '+48777888999',
      email: 'email',
      tickets: const {'0101': 'ADULT', '0102': 'STUDENT'},
      totalPrice: 11.0,
    );

    test('''should call CreateNewPurchase usecase to create new 
      purchase at firebase''', () async {
      // arrange
      when(mockCreateNewPurchase(purchase: anyNamed('purchase')))
          .thenAnswer((_) async => const Right(tResult));
      // act
      bloc.add(CreateNewPurchaseEvent(tPurchase));
      await untilCalled(mockCreateNewPurchase(purchase: anyNamed('purchase')));
      // assert
      verify(mockCreateNewPurchase(purchase: tPurchase));
    });

    test(
        'should emit [Loading, Loaded] when creating purchase was successful',
            () async {
          // arrange
          when(mockCreateNewPurchase(purchase: anyNamed('purchase')))
              .thenAnswer((_) async => const Right(tResult));
          // assert later
          final expected = [
            PurchaseLoading(),
            PurchaseLoaded(purchaseSuccessful: tResult),
          ];
          expectLater(bloc.stream, emitsInOrder(expected));
          // act
          bloc.add(CreateNewPurchaseEvent(tPurchase));
        });

    test(
        'should emit [Loading, Error] when creating purchase was unsuccessful',
            () async {
          // arrange
          when(mockCreateNewPurchase(purchase: anyNamed('purchase')))
              .thenAnswer((_) async => const Left(SettingDataError()));
          // assert later
          final expected = [
            PurchaseLoading(),
            PurchaseError(message: const SettingDataError().message),
          ];
          expectLater(bloc.stream, emitsInOrder(expected));
          // act
          bloc.add(CreateNewPurchaseEvent(tPurchase));
        });

    test('''should emit [Loading, Error] with proper message for the 
      error when setting data fails''', () async {
        // arrange
        when(mockCreateNewPurchase(purchase: anyNamed('purchase')))
            .thenAnswer((_) async => const Left(NetworkError()));
        // assert later
        final expected = [
          PurchaseLoading(),
          PurchaseError(message: const NetworkError().message),
        ];
        expectLater(bloc.stream, emitsInOrder(expected));
        // act
        bloc.add(CreateNewPurchaseEvent(tPurchase));
    });
  });
}
