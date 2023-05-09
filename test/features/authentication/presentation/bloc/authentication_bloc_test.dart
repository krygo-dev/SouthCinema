import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/authentication/domain/entities/auth_user.dart';
import 'package:south_cinema/features/authentication/domain/usecases/get_current_user.dart';
import 'package:south_cinema/features/authentication/domain/usecases/sign_in_with_email_and_password.dart';
import 'package:south_cinema/features/authentication/domain/usecases/sign_out.dart';
import 'package:south_cinema/features/authentication/domain/usecases/sign_up_with_email_and_password.dart';
import 'package:south_cinema/features/authentication/presentation/bloc/authentication_bloc.dart';

import 'authentication_bloc_test.mocks.dart';

@GenerateMocks([
  GetCurrentUser,
  SignInWithEmailAndPassword,
  SignUpWithEmailAndPassword,
  SignOut,
])
void main() {
  late AuthenticationBloc bloc;
  late MockGetCurrentUser mockGetCurrentUser;
  late MockSignInWithEmailAndPassword mockSignInWithEmailAndPassword;
  late MockSignUpWithEmailAndPassword mockSignUpWithEmailAndPassword;
  late MockSignOut mockSignOut;

  setUp(() {
    mockGetCurrentUser = MockGetCurrentUser();
    mockSignInWithEmailAndPassword = MockSignInWithEmailAndPassword();
    mockSignUpWithEmailAndPassword = MockSignUpWithEmailAndPassword();
    mockSignOut = MockSignOut();
    bloc = AuthenticationBloc(
      getCurrentUser: mockGetCurrentUser,
      signInWithEmailAndPassword: mockSignInWithEmailAndPassword,
      signUpWithEmailAndPassword: mockSignUpWithEmailAndPassword,
      signOut: mockSignOut,
    );
  });

  test('initial state should be UserEmpty', () {
    // assert
    expect(bloc.state, equals(AuthenticationEmpty()));
  });

  group('getCurrentUser', () {
    const tAuthUser = AuthUser(
      uid: 'uid',
      email: 'email',
      displayName: 'displayName',
    );

    test('should get data from GetCurrentUser usecase', () async {
      // arrange
      when(mockGetCurrentUser.call).thenReturn(tAuthUser);
      // act
      bloc.add(GetCurrentUserEvent());
      await untilCalled(mockGetCurrentUser.call);
      // assert
      verify(mockGetCurrentUser.call);
    });

    test('''should emit [AuthenticationLoading, AuthenticationLoaded] when 
        getting data was successful''', () async {
      // arrange
      when(mockGetCurrentUser.call).thenReturn(tAuthUser);
      // assert later
      final expected = [
        AuthenticationLoading(),
        AuthenticationLoaded(authUser: tAuthUser)
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(GetCurrentUserEvent());
    });

    test('''should emit [AuthenticationLoading, AuthenticationLoggedOut] when 
      getting data fails''', () {
      // arrange
      when(mockGetCurrentUser.call).thenReturn(null);
      // assert later
      final expected = [
        AuthenticationLoading(),
        AuthenticationLoggedOut(),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(GetCurrentUserEvent());
    });
  });

  group('signIn', () {
    const tEmail = 'email';
    const tPassword = 'password';
    const tAuthUser = AuthUser(
      uid: 'uid',
      email: 'email',
      displayName: 'displayName',
    );

    test('should sign in user using SignInWithEmailAndPassword usecase',
        () async {
      // arrange
      when(mockSignInWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => const Right(tAuthUser));
      // act
      bloc.add(
          SignInWithEmailAndPasswordEvent(email: tEmail, password: tPassword));
      await untilCalled(mockSignInWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      ));
      // assert
      verify(mockSignInWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
      ));
    });

    test('''should emit [AuthenticationLoading, AuthenticationLoaded] when
        signing in was successful''', () async {
      // arrange
      when(mockSignInWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => const Right(tAuthUser));
      // assert later
      final expected = [
        AuthenticationLoading(),
        AuthenticationLoaded(authUser: tAuthUser)
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(
          SignInWithEmailAndPasswordEvent(email: tEmail, password: tPassword));
    });

    test('''should emit [AuthenticationLoading, AuthenticationError] when
        signing in fails''', () async {
      // arrange
      when(mockSignInWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => const Left(AuthError()));
      // assert later
      final expected = [
        AuthenticationLoading(),
        AuthenticationError(message: const AuthError().message)
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(
          SignInWithEmailAndPasswordEvent(email: tEmail, password: tPassword));
    });

    test('''should emit [AuthenticationLoading, AuthenticationError] with 
      proper message when error occurs''', () async {
      // arrange
      when(mockSignInWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => const Left(NetworkError()));
      // assert later
      final expected = [
        AuthenticationLoading(),
        AuthenticationError(message: const NetworkError().message)
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(
          SignInWithEmailAndPasswordEvent(email: tEmail, password: tPassword));
    });
  });

  group('signUp', () {
    const tEmail = 'email';
    const tPassword = 'password';
    const tRepeatPassword = 'password';
    const tAuthUser = AuthUser(
      uid: 'uid',
      email: 'email',
      displayName: 'displayName',
    );

    test('should sign up user using SignUpWithEmailAndPassword usecase',
        () async {
      // arrange
      when(mockSignUpWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
        repeatPassword: anyNamed('repeatPassword'),
      )).thenAnswer((_) async => const Right(tAuthUser));
      // act
      bloc.add(SignUpWithEmailAndPasswordEvent(
        email: tEmail,
        password: tPassword,
        repeatPassword: tRepeatPassword,
      ));
      await untilCalled(mockSignUpWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
        repeatPassword: anyNamed('repeatPassword'),
      ));
      // assert
      verify(mockSignUpWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
        repeatPassword: tRepeatPassword,
      ));
    });

    test('''should emit [AuthenticationLoading, AuthenticationLoaded] when
        signing up was successful''', () async {
      // arrange
      when(mockSignUpWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
        repeatPassword: anyNamed('repeatPassword'),
      )).thenAnswer((_) async => const Right(tAuthUser));
      // assert later
      final expected = [
        AuthenticationLoading(),
        AuthenticationLoaded(authUser: tAuthUser)
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(SignUpWithEmailAndPasswordEvent(
        email: tEmail,
        password: tPassword,
        repeatPassword: tRepeatPassword,
      ));
    });

    test('''should emit [AuthenticationLoading, AuthenticationError] when
        signing up fails''', () async {
      // arrange
      when(mockSignUpWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
        repeatPassword: anyNamed('repeatPassword'),
      )).thenAnswer((_) async => const Left(AuthError()));
      // assert later
      final expected = [
        AuthenticationLoading(),
        AuthenticationError(message: const AuthError().message)
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(SignUpWithEmailAndPasswordEvent(
        email: tEmail,
        password: tPassword,
        repeatPassword: tRepeatPassword,
      ));
    });

    test('''should emit [AuthenticationLoading, AuthenticationError] with 
      proper message when error occurs''', () async {
      // arrange
      when(mockSignUpWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
        repeatPassword: anyNamed('repeatPassword'),
      )).thenAnswer((_) async => const Left(NetworkError()));
      // assert later
      final expected = [
        AuthenticationLoading(),
        AuthenticationError(message: const NetworkError().message)
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(SignUpWithEmailAndPasswordEvent(
        email: tEmail,
        password: tPassword,
        repeatPassword: tRepeatPassword,
      ));
    });
  });

  group('signOut', () {
    test('should sign out currently logged in user using SignOut usecase', () async {
      // arrange
      when(mockSignOut()).thenAnswer((_) async => const Right(null));
      // act
      bloc.add(SignOutEvent());
      await untilCalled(mockSignOut());
      // assert
      verify(mockSignOut());
    });

    test('''should emit [AuthenticationLoading, AuthenticationLoggedOut] when 
      signing out was successful''', () async {
      // arrange
      when(mockSignOut()).thenAnswer((_) async => const Right(null));
      // assert later
      final expected = [
        AuthenticationLoading(),
        AuthenticationLoggedOut(),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(SignOutEvent());
    });

    test('''should emit [AuthenticationLoading, AuthenticationError] when 
      signing out fails''', () async {
      // arrange
      when(mockSignOut()).thenAnswer((_) async => const Left(AuthError()));
      // assert later
      final expected = [
        AuthenticationLoading(),
        AuthenticationError(message: const AuthError().message),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(SignOutEvent());
    });

    test('''should emit [AuthenticationLoading, AuthenticationError] with 
      proper message when error occurs''', () async {
      // arrange
      when(mockSignOut()).thenAnswer((_) async => const Left(NetworkError()));
      // assert later
      final expected = [
        AuthenticationLoading(),
        AuthenticationError(message: const NetworkError().message),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(SignOutEvent());
    });
  });
}
