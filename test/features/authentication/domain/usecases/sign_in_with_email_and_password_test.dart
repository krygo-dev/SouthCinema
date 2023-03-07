import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:south_cinema/features/authentication/domain/entities/auth_user.dart';
import 'package:south_cinema/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:south_cinema/features/authentication/domain/usecases/sign_in_with_email_and_password.dart';

import 'sign_in_with_email_and_password_test.mocks.dart';

@GenerateMocks([AuthenticationRepository])
void main() {
  late SignInWithEmailAndPassword usecase;
  late MockAuthenticationRepository mockAuthenticationRepository;

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();
    usecase = SignInWithEmailAndPassword(mockAuthenticationRepository);
  });

  const tEmail = "test@test.com";
  const tPassword = "qqqqqq";
  const tAuthUser =
      AuthUser(uid: "testID", email: "test@test.com", displayName: "Test");

  test('should return AuthUser when signed in successfully', () async {
    // arrange
    when(mockAuthenticationRepository.signInWithEmailAndPassword(
      email: anyNamed("email"),
      password: anyNamed("password"),
    )).thenAnswer((_) async => const Right(tAuthUser));
    // act
    final result = await usecase(email: tEmail, password: tPassword);
    // assert
    expect(result, const Right(tAuthUser));
    verify(mockAuthenticationRepository.signInWithEmailAndPassword(
      email: tEmail,
      password: tPassword,
    ));
    verifyNoMoreInteractions(mockAuthenticationRepository);
  });
}
