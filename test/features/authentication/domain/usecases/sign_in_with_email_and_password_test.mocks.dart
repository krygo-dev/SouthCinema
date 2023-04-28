// Mocks generated by Mockito 5.4.0 from annotations
// in south_cinema/test/features/authentication/domain/usecases/sign_in_with_email_and_password_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:south_cinema/core/error/error.dart' as _i5;
import 'package:south_cinema/features/authentication/domain/entities/auth_user.dart'
    as _i6;
import 'package:south_cinema/features/authentication/domain/repositories/authentication_repository.dart'
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

/// A class which mocks [AuthenticationRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthenticationRepository extends _i1.Mock
    implements _i3.AuthenticationRepository {
  MockAuthenticationRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.BaseError, _i6.AuthUser>>
      signInWithEmailAndPassword({
    required String? email,
    required String? password,
  }) =>
          (super.noSuchMethod(
            Invocation.method(
              #signInWithEmailAndPassword,
              [],
              {
                #email: email,
                #password: password,
              },
            ),
            returnValue:
                _i4.Future<_i2.Either<_i5.BaseError, _i6.AuthUser>>.value(
                    _FakeEither_0<_i5.BaseError, _i6.AuthUser>(
              this,
              Invocation.method(
                #signInWithEmailAndPassword,
                [],
                {
                  #email: email,
                  #password: password,
                },
              ),
            )),
          ) as _i4.Future<_i2.Either<_i5.BaseError, _i6.AuthUser>>);
  @override
  _i4.Future<_i2.Either<_i5.BaseError, _i6.AuthUser>>
      signUpWithEmailAndPassword({
    required String? email,
    required String? password,
  }) =>
          (super.noSuchMethod(
            Invocation.method(
              #signUpWithEmailAndPassword,
              [],
              {
                #email: email,
                #password: password,
              },
            ),
            returnValue:
                _i4.Future<_i2.Either<_i5.BaseError, _i6.AuthUser>>.value(
                    _FakeEither_0<_i5.BaseError, _i6.AuthUser>(
              this,
              Invocation.method(
                #signUpWithEmailAndPassword,
                [],
                {
                  #email: email,
                  #password: password,
                },
              ),
            )),
          ) as _i4.Future<_i2.Either<_i5.BaseError, _i6.AuthUser>>);
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
