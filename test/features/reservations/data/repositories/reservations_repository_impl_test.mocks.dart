// Mocks generated by Mockito 5.4.0 from annotations
// in south_cinema/test/features/reservations/data/repositories/reservations_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:south_cinema/core/network/network_info.dart' as _i7;
import 'package:south_cinema/features/reservations/data/datasources/purchase_service.dart'
    as _i5;
import 'package:south_cinema/features/reservations/data/datasources/reservations_service.dart'
    as _i2;
import 'package:south_cinema/features/reservations/domain/entities/purchase.dart'
    as _i6;
import 'package:south_cinema/features/reservations/domain/entities/reservation.dart'
    as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [ReservationService].
///
/// See the documentation for Mockito's code generation for more information.
class MockReservationService extends _i1.Mock
    implements _i2.ReservationService {
  MockReservationService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<bool> createNewReservation(_i4.Reservation? reservation) =>
      (super.noSuchMethod(
        Invocation.method(
          #createNewReservation,
          [reservation],
        ),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
  @override
  _i3.Future<List<_i4.Reservation>> getUserReservations(String? uid) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserReservations,
          [uid],
        ),
        returnValue:
            _i3.Future<List<_i4.Reservation>>.value(<_i4.Reservation>[]),
      ) as _i3.Future<List<_i4.Reservation>>);
}

/// A class which mocks [PurchaseService].
///
/// See the documentation for Mockito's code generation for more information.
class MockPurchaseService extends _i1.Mock implements _i5.PurchaseService {
  MockPurchaseService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<bool> createNewPurchase(_i6.Purchase? purchase) =>
      (super.noSuchMethod(
        Invocation.method(
          #createNewPurchase,
          [purchase],
        ),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
  @override
  _i3.Future<List<_i6.Purchase>> getUserPurchasedTickets(String? uid) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserPurchasedTickets,
          [uid],
        ),
        returnValue: _i3.Future<List<_i6.Purchase>>.value(<_i6.Purchase>[]),
      ) as _i3.Future<List<_i6.Purchase>>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i7.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<bool> get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
}
