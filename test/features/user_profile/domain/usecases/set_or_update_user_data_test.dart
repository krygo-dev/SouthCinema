import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/user_profile/domain/entities/user.dart';
import 'package:south_cinema/features/user_profile/domain/repositories/user_profile_repository.dart';
import 'package:south_cinema/features/user_profile/domain/usecases/set_or_update_user_data.dart';

import 'get_user_by_id_test.mocks.dart';

@GenerateMocks([UserProfileRepository])
void main() {
  late SetOrUpdateUserData usecase;
  late MockUserProfileRepository mockUserProfileRepository;

  setUp(() {
    mockUserProfileRepository = MockUserProfileRepository();
    usecase = SetOrUpdateUserData(mockUserProfileRepository);
  });

  const tUser = User(
    uid: 'uid',
    email: 'email',
    name: 'name',
    city: 'city',
    postCode: 'postCode',
    street: 'street',
    contactNumber: 'contactNumber',
  );
  const tGettingDataError = GettingDataError();

  test('should return true when setting data was successful', () async {
    // arrange
    when(mockUserProfileRepository.setOrUpdateUserData(user: anyNamed('user')))
        .thenAnswer((_) async => const Right(true));
    // act
    final result = await usecase(user: tUser);
    // assert
    expect(result, const Right(true));
    verify(mockUserProfileRepository.setOrUpdateUserData(user: tUser));
    verifyNoMoreInteractions(mockUserProfileRepository);
  });

  test('should return error when setting data was unsuccessful', () async {
    // arrange
    when(mockUserProfileRepository.setOrUpdateUserData(user: anyNamed('user')))
        .thenAnswer((_) async => const Left(tGettingDataError));
    // act
    final result = await usecase(user: tUser);
    // assert
    expect(result, const Left(tGettingDataError));
    verify(mockUserProfileRepository.setOrUpdateUserData(user: tUser));
    verifyNoMoreInteractions(mockUserProfileRepository);
  });
}
