import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:south_cinema/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:south_cinema/features/authentication/domain/usecases/sign_out.dart';

import 'sign_in_with_email_and_password_test.mocks.dart';

@GenerateMocks([AuthenticationRepository])
void main() {
  late SignOut usecase;
  late MockAuthenticationRepository mockAuthenticationRepository;

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();
    usecase = SignOut(mockAuthenticationRepository);
  });

  group('sign out', () {
    test('should sign out user', () async {
      // arrange
      when(mockAuthenticationRepository.signOut())
          .thenAnswer((_) async => const Right(null));
      // act
      final result = usecase();
      // assert
      verify(mockAuthenticationRepository.signOut());
      verifyNoMoreInteractions(mockAuthenticationRepository);
      expect(result, isA<void>());
    });
  });
}