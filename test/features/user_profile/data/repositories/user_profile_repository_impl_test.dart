import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/core/network/network_info.dart';
import 'package:south_cinema/features/user_profile/data/datasources/user_service.dart';
import 'package:south_cinema/features/user_profile/data/repositories/user_profile_repository_impl.dart';
import 'package:south_cinema/features/user_profile/domain/entities/user.dart';

import 'user_profile_repository_impl_test.mocks.dart';

@GenerateMocks([UserService, NetworkInfo])
void main() {
  late UserProfileRepositoryImpl repositoryImpl;
  late MockUserService mockUserService;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockUserService = MockUserService();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = UserProfileRepositoryImpl(
      userService: mockUserService,
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

  group('getUserById', () {
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

    test('should check if device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockUserService.getUserById(any)).thenAnswer((_) async => tUser);
      // act
      repositoryImpl.getUserById(uid: tId);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test('should return User when getting data for id was successful',
          () async {
        // arrange
        when(mockUserService.getUserById(any)).thenAnswer((_) async => tUser);
        // act
        final result = await repositoryImpl.getUserById(uid: tId);
        // assert
        verify(mockUserService.getUserById(tId));
        expect(result, const Right(tUser));
      });

      test('should return error when getting data was unsuccessful', () async {
        // arrange
        when(mockUserService.getUserById(any)).thenThrow(tGettingDataError);
        // act
        final result = await repositoryImpl.getUserById(uid: tId);
        // assert
        verify(mockUserService.getUserById(tId));
        verifyNoMoreInteractions(mockUserService);
        expect(result, const Left(tGettingDataError));
      });
    });

    runTestsOffline(() {
      test('should return NetworkError when device is offline', () async {
        // act
        final result = await repositoryImpl.getUserById(uid: tId);
        // assert
        verifyZeroInteractions(mockUserService);
        expect(result, const Left(NetworkError()));
      });
    });
  });

  group('setOrUpdateUserData', () {
    const tUser = User(
      uid: 'uid',
      email: 'email',
      name: 'name',
      city: 'city',
      postCode: 'postCode',
      street: 'street',
      contactNumber: 'contactNumber',
    );
    const tSettingDataError = SettingDataError();

    test('should check if device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockUserService.setOrUpdateUserData(any))
          .thenAnswer((_) async => true);
      // act
      repositoryImpl.setOrUpdateUserData(user: tUser);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test('should return true when setting data was successful', () async {
        // arrange
        when(mockUserService.setOrUpdateUserData(any)).thenAnswer((_) async => true);
        // act
        final result = await repositoryImpl.setOrUpdateUserData(user: tUser);
        // assert
        verify(mockUserService.setOrUpdateUserData(tUser));
        expect(result, const Right(true));
      });

      test('should return error when setting data was unsuccessful', () async {
        // arrange
        when(mockUserService.setOrUpdateUserData(any)).thenThrow(tSettingDataError);
        // act
        final result = await repositoryImpl.setOrUpdateUserData(user: tUser);
        // assert
        verify(mockUserService.setOrUpdateUserData(tUser));
        verifyNoMoreInteractions(mockUserService);
        expect(result, const Left(tSettingDataError));
      });
    });

    runTestsOffline(() {
      test('should return NetworkError when device is offline', () async {
        // act
        final result = await repositoryImpl.setOrUpdateUserData(user: tUser);
        // assert
        verifyZeroInteractions(mockUserService);
        expect(result, const Left(NetworkError()));
      });
    });
  });
}
