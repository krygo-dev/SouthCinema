import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:south_cinema/features/authentication/domain/entities/auth_user.dart';

void main() {
  const tAuthUser =
      AuthUser(uid: "testID", email: "test@test.com", displayName: "Test");

  test('should return valid entity from firebase User', () {
    // arrange
    final user =
        MockUser(uid: "testID", email: "test@test.com", displayName: "Test");
    // act
    final result = AuthUser.fromFirebaseUser(user);
    // assert
    expect(result, tAuthUser);
  });
}
