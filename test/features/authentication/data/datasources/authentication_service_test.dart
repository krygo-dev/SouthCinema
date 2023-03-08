import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart' as auth_mocks;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/authentication/data/datasources/authentication_service_impl.dart';
import 'package:south_cinema/features/authentication/domain/entities/auth_user.dart';

import 'authentication_service_test.mocks.dart';

@GenerateMocks([FirebaseAuth, UserCredential])
void main() {
  late AuthenticationServiceImpl authenticationServiceImpl;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockUserCredential mockUserCredential;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockUserCredential = MockUserCredential();
    authenticationServiceImpl = AuthenticationServiceImpl(mockFirebaseAuth);
  });

  group('get currentUser', () {
    final mockUser = auth_mocks.MockUser(
        uid: "testID", email: "test@test.com", displayName: "Test");
    const tAuthUser =
        AuthUser(uid: "testID", email: "test@test.com", displayName: "Test");

    test('should get currently logged in AuthUser from Firebase', () async {
      // arrange
      when(mockFirebaseAuth.currentUser).thenAnswer((_) => mockUser);
      // act
      final result = authenticationServiceImpl.currentUser;
      // assert
      verify(mockFirebaseAuth.currentUser);
      verifyNoMoreInteractions(mockFirebaseAuth);
      expect(result, tAuthUser);
    });

    test('should return null when there is no logged in user', () async {
      // arrange
      when(mockFirebaseAuth.currentUser).thenAnswer((_) => null);
      // act
      final result = authenticationServiceImpl.currentUser;
      // assert
      verify(mockFirebaseAuth.currentUser);
      verifyNoMoreInteractions(mockFirebaseAuth);
      expect(result, null);
    });
  });

  group('signInWithEmailAndPassword', () {
    final mockUser = auth_mocks.MockUser(
        uid: "testID", email: "test@test.com", displayName: "Test");
    const tAuthUser =
        AuthUser(uid: "testID", email: "test@test.com", displayName: "Test");
    const tEmail = "test@test.com";
    const tPassword = "qqqqqq";

    test('should return AuthUser when signing in was successful', () async {
      // arrange
      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => mockUserCredential);
      when(mockFirebaseAuth.currentUser).thenAnswer((_) => mockUser);
      // act
      final result = await authenticationServiceImpl.signInWithEmailAndPassword(tEmail, tPassword);
      // assert
      verify(mockFirebaseAuth.signInWithEmailAndPassword(email: tEmail, password: tPassword));
      verify(mockFirebaseAuth.currentUser);
      verifyNoMoreInteractions(mockFirebaseAuth);
      expect(result, tAuthUser);
    });

    test('should throw AuthError when signing in failed', () async {
      // arrange
      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenThrow(FirebaseAuthException(code: 'test_code'));
      // act
      final call = authenticationServiceImpl.signInWithEmailAndPassword;
      // assert
      verifyNoMoreInteractions(mockFirebaseAuth);
      await expectLater(call(tEmail, tPassword), throwsA(isA<AuthError>()));
    });
  });

  group('signUpWithEmailAndPassword', () {
    final mockUser = auth_mocks.MockUser(uid: "testID", email: "test@test.com", displayName: "Test");
    const tAuthUser = AuthUser(uid: "testID", email: "test@test.com", displayName: "Test");
    const tEmail = "test@test.com";
    const tPassword = "qqqqqq";

    test('should return AuthUser when creating user was successful', () async {
      // arrange
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => mockUserCredential);
      when(mockFirebaseAuth.currentUser).thenAnswer((_) => mockUser);
      // act
      final result = await authenticationServiceImpl.signUpWithEmailAndPassword(tEmail, tPassword);
      // assert
      verify(mockFirebaseAuth.createUserWithEmailAndPassword(email: tEmail, password: tPassword));
      verify(mockFirebaseAuth.currentUser);
      verifyNoMoreInteractions(mockFirebaseAuth);
      expect(result, tAuthUser);
    });

    test('should throw AuthError when creating user failed', () async {
      // arrange
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenThrow(FirebaseAuthException(code: 'test_code'));
      // act
      final call = authenticationServiceImpl.signUpWithEmailAndPassword;
      // assert
      verifyNoMoreInteractions(mockFirebaseAuth);
      await expectLater(call(tEmail, tPassword), throwsA(isA<AuthError>()));
    });
  });
}
