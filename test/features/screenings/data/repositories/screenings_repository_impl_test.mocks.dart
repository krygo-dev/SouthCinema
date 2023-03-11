// Mocks generated by Mockito 5.3.2 from annotations
// in south_cinema/test/features/screenings/data/repositories/screenings_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:mockito/mockito.dart' as _i1;
import 'package:south_cinema/core/network/network_info.dart' as _i7;
import 'package:south_cinema/features/screenings/data/datasources/screenings_service.dart'
    as _i4;
import 'package:south_cinema/features/screenings/domain/entities/repertoire_screening.dart'
    as _i6;
import 'package:south_cinema/features/screenings/domain/entities/room.dart'
    as _i2;
import 'package:south_cinema/features/screenings/domain/entities/screening.dart'
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

class _FakeRoom_0 extends _i1.SmartFake implements _i2.Room {
  _FakeRoom_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeScreening_1 extends _i1.SmartFake implements _i3.Screening {
  _FakeScreening_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ScreeningsService].
///
/// See the documentation for Mockito's code generation for more information.
class MockScreeningsService extends _i1.Mock implements _i4.ScreeningsService {
  MockScreeningsService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<List<_i6.RepertoireScreening>> getRepertoireForDate(
          String? date) =>
      (super.noSuchMethod(
        Invocation.method(
          #getRepertoireForDate,
          [date],
        ),
        returnValue: _i5.Future<List<_i6.RepertoireScreening>>.value(
            <_i6.RepertoireScreening>[]),
      ) as _i5.Future<List<_i6.RepertoireScreening>>);
  @override
  _i5.Future<_i2.Room> getRoomById(String? id) => (super.noSuchMethod(
        Invocation.method(
          #getRoomById,
          [id],
        ),
        returnValue: _i5.Future<_i2.Room>.value(_FakeRoom_0(
          this,
          Invocation.method(
            #getRoomById,
            [id],
          ),
        )),
      ) as _i5.Future<_i2.Room>);
  @override
  _i5.Future<_i3.Screening> getScreeningById(String? id) => (super.noSuchMethod(
        Invocation.method(
          #getScreeningById,
          [id],
        ),
        returnValue: _i5.Future<_i3.Screening>.value(_FakeScreening_1(
          this,
          Invocation.method(
            #getScreeningById,
            [id],
          ),
        )),
      ) as _i5.Future<_i3.Screening>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i7.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<bool> get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
}