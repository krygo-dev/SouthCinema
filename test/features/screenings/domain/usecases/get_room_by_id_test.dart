import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/screenings/domain/entities/room.dart';
import 'package:south_cinema/features/screenings/domain/repositories/screenings_repository.dart';
import 'package:south_cinema/features/screenings/domain/usecases/get_room_by_id.dart';

import 'get_room_by_id_test.mocks.dart';

@GenerateMocks([ScreenignsRepository])
void main() {
  late GetRoomById usecase;
  late MockScreenignsRepository mockScreenignsRepository;

  setUp(() {
    mockScreenignsRepository = MockScreenignsRepository();
    usecase = GetRoomById(mockScreenignsRepository);
  });

  const tId = 'room_1';
  const tRoom = Room(id: 'room_1', name: 'Room 1', rows: 10, rowsLength: 10);
  const tGettingDataError = GettingDataError();

  test('should return Room from repository for provided id', () async {
    // arrange
    when(mockScreenignsRepository.getRoomById(id: anyNamed('id')))
        .thenAnswer((_) async => const Right(tRoom));
    // act
    final result = await usecase(id: tId);
    // assert
    expect(result, const Right(tRoom));
    verify(mockScreenignsRepository.getRoomById(id: tId));
    verifyNoMoreInteractions(mockScreenignsRepository);
  });

  test('should return error when getting data was unsuccessful', () async {
    // arrange
    when(mockScreenignsRepository.getRoomById(id: anyNamed('id')))
        .thenAnswer((_) async => const Left(tGettingDataError));
    // act
    final result = await usecase(id: tId);
    // assert
    expect(result, const Left(tGettingDataError));
    verify(mockScreenignsRepository.getRoomById(id: tId));
    verifyNoMoreInteractions(mockScreenignsRepository);
  });
}
