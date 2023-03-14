import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/user_profile/domain/entities/user.dart';
import 'package:south_cinema/features/user_profile/domain/repositories/user_profile_repository.dart';
import 'package:south_cinema/features/user_profile/domain/usecases/get_user_by_id.dart';

import 'get_user_by_id_test.mocks.dart';

@GenerateMocks([UserProfileRepository])
void main() {
  late GetUserById usecase;
  late MockUserProfileRepository mockUserProfileRepository;

  setUp(() {
    mockUserProfileRepository = MockUserProfileRepository();
    usecase = GetUserById(mockUserProfileRepository);
  });

  const tId = 'uid';
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

  test('should return User from repository for provided id', () async {
    // arrange
    when(mockUserProfileRepository.getUserById(uid: anyNamed('uid')))
        .thenAnswer((_) async => const Right(tUser));
    // act
    final result = await usecase(uid: tId);
    // assert
    expect(result, const Right(tUser));
    verify(mockUserProfileRepository.getUserById(uid: tId));
    verifyNoMoreInteractions(mockUserProfileRepository);
  });

  test('should return error when getting data was unsuccessful', () async {
    // arrange
    when(mockUserProfileRepository.getUserById(uid: anyNamed('uid')))
        .thenAnswer((_) async => const Left(tGettingDataError));
    // act
    final result = await usecase(uid: tId);
    // assert
    expect(result, const Left(tGettingDataError));
    verify(mockUserProfileRepository.getUserById(uid: tId));
    verifyNoMoreInteractions(mockUserProfileRepository);
  });
}
