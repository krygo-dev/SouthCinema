// Mocks generated by Mockito 5.4.0 from annotations
// in south_cinema/test/features/reservations/domain/usecases/get_user_reservations_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:south_cinema/core/error/error.dart' as _i5;
import 'package:south_cinema/features/reservations/domain/entities/purchase.dart'
    as _i7;
import 'package:south_cinema/features/reservations/domain/entities/reservation.dart'
    as _i6;
import 'package:south_cinema/features/reservations/domain/repositories/reservations_repository.dart'
    as _i3;

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

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ReservationsRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockReservationsRepository extends _i1.Mock
    implements _i3.ReservationsRepository {
  MockReservationsRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.BaseError, bool>> createNewReservation(
          {required _i6.Reservation? reservation}) =>
      (super.noSuchMethod(
        Invocation.method(
          #createNewReservation,
          [],
          {#reservation: reservation},
        ),
        returnValue: _i4.Future<_i2.Either<_i5.BaseError, bool>>.value(
            _FakeEither_0<_i5.BaseError, bool>(
          this,
          Invocation.method(
            #createNewReservation,
            [],
            {#reservation: reservation},
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.BaseError, bool>>);
  @override
  _i4.Future<
      _i2.Either<_i5.BaseError, List<_i6.Reservation>>> getUserReservations(
          {required String? uid}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserReservations,
          [],
          {#uid: uid},
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.BaseError, List<_i6.Reservation>>>.value(
                _FakeEither_0<_i5.BaseError, List<_i6.Reservation>>(
          this,
          Invocation.method(
            #getUserReservations,
            [],
            {#uid: uid},
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.BaseError, List<_i6.Reservation>>>);
  @override
  _i4.Future<_i2.Either<_i5.BaseError, bool>> createNewPurchase(
          {required _i7.Purchase? purchase}) =>
      (super.noSuchMethod(
        Invocation.method(
          #createNewPurchase,
          [],
          {#purchase: purchase},
        ),
        returnValue: _i4.Future<_i2.Either<_i5.BaseError, bool>>.value(
            _FakeEither_0<_i5.BaseError, bool>(
          this,
          Invocation.method(
            #createNewPurchase,
            [],
            {#purchase: purchase},
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.BaseError, bool>>);
  @override
  _i4.Future<_i2.Either<_i5.BaseError, List<_i7.Purchase>>>
      getUserPurchasedTickets({required String? uid}) => (super.noSuchMethod(
            Invocation.method(
              #getUserPurchasedTickets,
              [],
              {#uid: uid},
            ),
            returnValue:
                _i4.Future<_i2.Either<_i5.BaseError, List<_i7.Purchase>>>.value(
                    _FakeEither_0<_i5.BaseError, List<_i7.Purchase>>(
              this,
              Invocation.method(
                #getUserPurchasedTickets,
                [],
                {#uid: uid},
              ),
            )),
          ) as _i4.Future<_i2.Either<_i5.BaseError, List<_i7.Purchase>>>);
}
