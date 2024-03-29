// Mocks generated by Mockito 5.4.0 from annotations
// in south_cinema/test/features/authentication/data/repositories/authentication_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:south_cinema/core/network/network_info.dart' as _i5;
import 'package:south_cinema/features/authentication/data/datasources/authentication_service.dart'
    as _i3;
import 'package:south_cinema/features/authentication/domain/entities/auth_user.dart'
    as _i2;

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

class _FakeAuthUser_0 extends _i1.SmartFake implements _i2.AuthUser {
  _FakeAuthUser_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AuthenticationService].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthenticationService extends _i1.Mock
    implements _i3.AuthenticationService {
  MockAuthenticationService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.AuthUser> signInWithEmailAndPassword(
    String? email,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #signInWithEmailAndPassword,
          [
            email,
            password,
          ],
        ),
        returnValue: _i4.Future<_i2.AuthUser>.value(_FakeAuthUser_0(
          this,
          Invocation.method(
            #signInWithEmailAndPassword,
            [
              email,
              password,
            ],
          ),
        )),
      ) as _i4.Future<_i2.AuthUser>);
  @override
  _i4.Future<_i2.AuthUser> signUpWithEmailAndPassword(
    String? email,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #signUpWithEmailAndPassword,
          [
            email,
            password,
          ],
        ),
        returnValue: _i4.Future<_i2.AuthUser>.value(_FakeAuthUser_0(
          this,
          Invocation.method(
            #signUpWithEmailAndPassword,
            [
              email,
              password,
            ],
          ),
        )),
      ) as _i4.Future<_i2.AuthUser>);
  @override
  _i4.Future<void> signOut() => (super.noSuchMethod(
        Invocation.method(
          #signOut,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i5.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<bool> get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
}
