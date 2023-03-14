import 'package:flutter_test/flutter_test.dart';
import 'package:south_cinema/features/user_profile/domain/entities/user.dart';

void main() {
  const tUser = User(
    uid: 'uid',
    email: 'email',
    name: 'name',
    city: 'city',
    postCode: 'postCode',
    street: 'street',
    contactNumber: 'contactNumber',
  );

  const tJson = {
    'uid': 'uid',
    'email': 'email',
    'name': 'name',
    'city': 'city',
    'postCode': 'postCode',
    'street': 'street',
    'contactNumber': 'contactNumber',
  };

  test('should return valid User entity from json', () {
    // act
    final result = User.fromJson(tJson);
    // assert
    expect(result, tUser);
  });

  test('should return json from User entity', () {
    // act
    final result = tUser.toJson();
    // assert
    expect(result, tJson);
  });
}
