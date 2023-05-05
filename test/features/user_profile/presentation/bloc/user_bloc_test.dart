import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/user_profile/domain/entities/user.dart';
import 'package:south_cinema/features/user_profile/domain/usecases/get_user_by_id.dart';
import 'package:south_cinema/features/user_profile/domain/usecases/set_or_update_user_data.dart';
import 'package:south_cinema/features/user_profile/presentation/bloc/user_bloc.dart';

import 'user_bloc_test.mocks.dart';

@GenerateMocks([GetUserById, SetOrUpdateUserData])
void main() {
  late UserBloc bloc;
  late MockGetUserById mockGetUserById;
  late MockSetOrUpdateUserData mockSetOrUpdateUserData;

  setUp(() {
    mockGetUserById = MockGetUserById();
    mockSetOrUpdateUserData = MockSetOrUpdateUserData();
    bloc = UserBloc(
      getUserById: mockGetUserById,
      setOrUpdateUserData: mockSetOrUpdateUserData,
    );
  });

  test('initial state should be UserEmpty', () {
    // assert
    expect(bloc.state, equals(UserEmpty()));
  });

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

    test('should get data from GetUserById usecase', () async {
      // arrange
      when(mockGetUserById(uid: anyNamed('uid')))
          .thenAnswer((_) async => const Right(tUser));
      // act
      bloc.add(GetUserByIdEvent(tId));
      await untilCalled(mockGetUserById(uid: anyNamed('uid')));
      // assert
      verify(mockGetUserById(uid: tId));
    });

    test(
        'should emit [UserLoading, UserLoaded] when getting data was successful',
        () async {
      // arrange
      when(mockGetUserById(uid: anyNamed('uid')))
          .thenAnswer((_) async => const Right(tUser));
      // assert later
      final expected = [UserLoading(), UserLoaded(user: tUser)];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(GetUserByIdEvent(tId));
    });

    test('should emit [UserLoading, UserError] when getting data fails',
        () async {
      // arrange
      when(mockGetUserById(uid: anyNamed('uid')))
          .thenAnswer((_) async => const Left(GettingDataError()));
      // assert later
      final expected = [
        UserLoading(),
        UserError(message: const GettingDataError().message)
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(GetUserByIdEvent(tId));
    });

    test(
        'should emit [UserLoading, UserError] with proper message when error occurs',
        () async {
      // arrange
      when(mockGetUserById(uid: anyNamed('uid')))
          .thenAnswer((_) async => const Left(NetworkError()));
      // assert later
      final expected = [
        UserLoading(),
        UserError(message: const NetworkError().message)
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(GetUserByIdEvent(tId));
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

    test('should set/update data of given user by SetOrUpdateUserData usecase',
        () async {
      // arrange
      when(mockSetOrUpdateUserData(user: anyNamed('user')))
          .thenAnswer((_) async => const Right(true));
      when(mockGetUserById(uid: anyNamed('uid')))
          .thenAnswer((_) async => const Right(tUser));
      // act
      bloc.add(SetOrUpdateUserDataEvent(tUser));
      await untilCalled(mockSetOrUpdateUserData(user: anyNamed('user')));
      await untilCalled(mockGetUserById(uid: anyNamed('uid')));
      // assert
      verify(mockSetOrUpdateUserData(user: tUser));
      verify(mockGetUserById(uid: tUser.uid));
    });

    test(
        'should emit [UserLoading, UserLoaded] when setting data was successful',
        () async {
      // arrange
      when(mockSetOrUpdateUserData(user: anyNamed('user')))
          .thenAnswer((_) async => const Right(true));
      when(mockGetUserById(uid: anyNamed('uid')))
          .thenAnswer((_) async => const Right(tUser));
      // assert later
      final expected = [UserLoading(), UserLoaded(user: tUser)];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(SetOrUpdateUserDataEvent(tUser));
    });

    test('''should emit [UserLoading, UserError] when setting data was 
        successful but getting user data after update fails''', () async {
      // arrange
      when(mockSetOrUpdateUserData(user: anyNamed('user')))
          .thenAnswer((_) async => const Right(true));
      when(mockGetUserById(uid: anyNamed('uid')))
          .thenAnswer((_) async => const Left(GettingDataError()));
      // assert later
      final expected = [
        UserLoading(),
        UserError(message: const GettingDataError().message)
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(SetOrUpdateUserDataEvent(tUser));
    });

    test('should emit [UserLoading, UserError] when setting data fails',
        () async {
      // arrange
      when(mockSetOrUpdateUserData(user: anyNamed('user')))
          .thenAnswer((_) async => const Left(SettingDataError()));
      // assert later
      final expected = [
        UserLoading(),
        UserError(message: const SettingDataError().message)
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(SetOrUpdateUserDataEvent(tUser));
    });

    test(
        'should emit [UserLoading, UserError] with proper message when error occurs',
        () async {
      // arrange
      when(mockSetOrUpdateUserData(user: anyNamed('user')))
          .thenAnswer((_) async => const Left(NetworkError()));
      // assert later
      final expected = [
        UserLoading(),
        UserError(message: const NetworkError().message)
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(SetOrUpdateUserDataEvent(tUser));
    });
  });
}
