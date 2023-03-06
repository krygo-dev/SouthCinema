import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:south_cinema/features/authentication/domain/entities/auth_user.dart';
import 'package:south_cinema/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:south_cinema/features/authentication/domain/usecases/get_current_user.dart';

import 'get_current_user_test.mocks.dart';

@GenerateMocks([AuthenticationRepository])
void main() {
  late GetCurrentUser usecase;
  late MockAuthenticationRepository mockAuthenticationRepository;

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();
    usecase = GetCurrentUser(mockAuthenticationRepository);
  });

  group('get current user', () {
    test('should forward call to AuthenticationRepository.currentUser', () {
      // arrange
      const tAuthUser =
          AuthUser(uid: "testID", email: "test@test.com", displayName: "Test");
      when(mockAuthenticationRepository.currentUser)
          .thenAnswer((_) => tAuthUser);
      // act
      final result = usecase.call;
      // assert
      verify(mockAuthenticationRepository.currentUser);
      expect(result, tAuthUser);
    });
  });
}
