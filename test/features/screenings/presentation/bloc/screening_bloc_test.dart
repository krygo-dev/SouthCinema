import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/screenings/domain/entities/room.dart';
import 'package:south_cinema/features/screenings/domain/entities/screening.dart';
import 'package:south_cinema/features/screenings/domain/usecases/get_room_by_id.dart';
import 'package:south_cinema/features/screenings/domain/usecases/get_screening_by_id.dart';
import 'package:south_cinema/features/screenings/presentation/bloc/screening_bloc.dart';

import 'screening_bloc_test.mocks.dart';

@GenerateMocks([GetScreeningById, GetRoomById])
void main() {
  late ScreeningBloc bloc;
  late MockGetScreeningById mockGetScreeningById;
  late MockGetRoomById mockGetRoomById;

  setUp(() {
    mockGetScreeningById = MockGetScreeningById();
    mockGetRoomById = MockGetRoomById();
    bloc = ScreeningBloc(
      getScreeningById: mockGetScreeningById,
      getRoomById: mockGetRoomById,
    );
  });

  test('initial state should be Empty', () {
    // assert
    expect(bloc.state, equals(Empty()));
  });

  group('GetScreeningById', () {
    const tId = 'id';
    const tRoomId = 'roomID';
    final tScreening = Screening(
      id: 'id',
      date: Timestamp.now(),
      movieID: 'movieID',
      movieTitle: 'movieTitle',
      roomID: 'roomID',
      reservationOn: true,
      seatsTaken: const ['0101', '0102'],
    );
    const tRoom = Room(id: 'roomID', name: 'name', rows: 10, rowsLength: 10);

    test('should get data from GetScreeningById usecase', () async {
      // arrange
      when(mockGetScreeningById(id: anyNamed('id')))
          .thenAnswer((_) async => Right(tScreening));
      when(mockGetRoomById(id: anyNamed('id')))
          .thenAnswer((_) async => const Right(tRoom));
      // act
      bloc.add(GetScreeningByIdEvent(tId));
      await untilCalled(mockGetScreeningById(id: anyNamed('id')));
      // assert
      verify(mockGetScreeningById(id: tId));
    });

    test('should get data from GetRoomById usecase', () async {
      // arrange
      when(mockGetScreeningById(id: anyNamed('id')))
          .thenAnswer((_) async => Right(tScreening));
      when(mockGetRoomById(id: anyNamed('id')))
          .thenAnswer((_) async => const Right(tRoom));
      // act
      bloc.add(GetScreeningByIdEvent(tId));
      await untilCalled(mockGetRoomById(id: anyNamed('id')));
      // assert
      verify(mockGetRoomById(id: tRoomId));
    });

    test('should emit [Loading, Loaded] when getting data was successful',
        () async {
      // arrange
      when(mockGetScreeningById(id: anyNamed('id')))
          .thenAnswer((_) async => Right(tScreening));
      when(mockGetRoomById(id: anyNamed('id')))
          .thenAnswer((_) async => const Right(tRoom));
      // assert later
      final expected = [
        Loading(),
        Loaded(screening: tScreening, room: tRoom),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(GetScreeningByIdEvent(tId));
    });

    test('''should emit [Loading, Error] when getting data from 
      GetScreeningById usecase was unsuccessful''', () async {
      // arrange
      when(mockGetScreeningById(id: anyNamed('id')))
          .thenAnswer((_) async => const Left(GettingDataError()));
      // assert later
      final expected = [
        Loading(),
        Error(message: const GettingDataError().message),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      verifyZeroInteractions(mockGetRoomById);
      // act
      bloc.add(GetScreeningByIdEvent(tId));
    });

    test('''should emit [Loading, Error] when getting data from 
      GetRoomById usecase was unsuccessful''', () async {
      // arrange
      when(mockGetScreeningById(id: anyNamed('id')))
          .thenAnswer((_) async => Right(tScreening));
      when(mockGetRoomById(id: anyNamed('id')))
          .thenAnswer((_) async => const Left(GettingDataError()));
      // assert later
      final expected = [
        Loading(),
        Error(message: const GettingDataError().message),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(GetScreeningByIdEvent(tId));
    });

    test('''should emit [Loading, Error] with proper message for the 
      error when getting data fails''', () async {
      // arrange
      when(mockGetScreeningById(id: tId))
          .thenAnswer((_) async => const Left(NetworkError()));
      // assert later
      final expected = [
        Loading(),
        Error(message: const NetworkError().message),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(GetScreeningByIdEvent(tId));
    });
  });
}
