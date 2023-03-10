import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/core/network/network_info.dart';
import 'package:south_cinema/features/authentication/data/datasources/authentication_service.dart';
import 'package:south_cinema/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:south_cinema/features/authentication/domain/entities/auth_user.dart';

import 'authentication_repository_impl_test.mocks.dart';

@GenerateMocks([AuthenticationService, NetworkInfo])
void main() {
  late AuthenticationRepositoryImpl repository;
  late MockAuthenticationService mockAuthenticationService;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockAuthenticationService = MockAuthenticationService();
    repository = AuthenticationRepositoryImpl(
      authenticationService: mockAuthenticationService,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('signInWithEmailAndPassword', () {
    const tEmail = "test@test.com";
    const tPassword = "qqqqqq";
    const tAuthUser =
        AuthUser(uid: "testID", email: "test@test.com", displayName: "Test");

    test('should check if device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockAuthenticationService.signInWithEmailAndPassword(any, any))
          .thenAnswer((_) async => tAuthUser);
      // act
      repository.signInWithEmailAndPassword(email: tEmail, password: tPassword);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test('should return AuthUser when signing in is successful', () async {
        // arrange
        when(mockAuthenticationService.signInWithEmailAndPassword(any, any))
            .thenAnswer((_) async => tAuthUser);
        // act
        final result = await repository.signInWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        );
        // assert
        verify(mockAuthenticationService.signInWithEmailAndPassword(
            tEmail, tPassword));
        expect(result, equals(const Right(tAuthUser)));
      });

      test('should return AuthError when signing in is unsuccessful', () async {
        // arrange
        const tAuthError = AuthError(message: 'Unexpected error');
        when(mockAuthenticationService.signInWithEmailAndPassword(any, any))
            .thenThrow(tAuthError);
        // act
        final result = await repository.signInWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        );
        // assert
        verify(mockAuthenticationService.signInWithEmailAndPassword(
            tEmail, tPassword));
        expect(result, equals(const Left(tAuthError)));
      });
    });

    runTestsOffline(() {
      test('should return NetworkError when device is offline', () async {
        // arrange
        // act
        final result = await repository.signInWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        );
        // assert
        verifyZeroInteractions(mockAuthenticationService);
        expect(result, equals(const Left(NetworkError())));
      });
    });
  });

  group('signUpWithEmailAndPassword', () {
    const tEmail = "test@test.com";
    const tPassword = "qqqqqq";
    const tAuthUser =
        AuthUser(uid: "testID", email: "test@test.com", displayName: "Test");

    test('should check if device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockAuthenticationService.signUpWithEmailAndPassword(any, any))
          .thenAnswer((_) async => tAuthUser);
      // act
      repository.signUpWithEmailAndPassword(email: tEmail, password: tPassword);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test('should return AuthUser when signing up is successful', () async {
        // arrange
        when(mockAuthenticationService.signUpWithEmailAndPassword(any, any))
            .thenAnswer((_) async => tAuthUser);
        // act
        final result = await repository.signUpWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        );
        // assert
        verify(mockAuthenticationService.signUpWithEmailAndPassword(
            tEmail, tPassword));
        expect(result, equals(const Right(tAuthUser)));
      });

      test('should return AuthError when signing up is unsuccessful', () async {
        // arrange
        const tAuthError = AuthError(message: 'Unexpected error');
        when(mockAuthenticationService.signUpWithEmailAndPassword(any, any))
            .thenThrow(tAuthError);
        // act
        final result = await repository.signUpWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        );
        // assert
        verify(mockAuthenticationService.signUpWithEmailAndPassword(
            tEmail, tPassword));
        expect(result, equals(const Left(tAuthError)));
      });
    });

    runTestsOffline(() {
      test('should return NetworkError when device is offline', () async {
        // act
        final result = await repository.signUpWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        );
        // assert
        verifyZeroInteractions(mockAuthenticationService);
        expect(result, equals(const Left(NetworkError())));
      });
    });
  });

  group('get currentUser', () {
    test('should forward call to AuthenticationService.currentUser', () {
      // arrange
      const tAuthUser =
          AuthUser(uid: "testID", email: "test@test.com", displayName: "Test");
      when(mockAuthenticationService.currentUser).thenAnswer((_) => tAuthUser);
      // act
      final result = repository.currentUser;
      // assert
      verify(mockAuthenticationService.currentUser);
      expect(result, tAuthUser);
    });
  });

  group('signOut', () {
    test('should check if device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repository.signOut();
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test('should sign out any signed in user', () async {
        // arrange
        final tSignedOutFuture = Future.value();
        when(mockAuthenticationService.signOut())
            .thenAnswer((_) => tSignedOutFuture);
        // act
        final _ = await repository.signOut();
        // assert
        expect(() async => await repository.signOut(), isA<void>());
        verify(mockAuthenticationService.signOut());
        verifyNoMoreInteractions(mockAuthenticationService);
      });
    });

    runTestsOffline(() {
      test('should throw NetworkError when device is offline', () async {
        // act
        final call = repository.signOut;
        // assert
        verifyZeroInteractions(mockAuthenticationService);
        expect(() => call(), throwsA(const TypeMatcher<NetworkError>()));
      });
    });
  });
}
