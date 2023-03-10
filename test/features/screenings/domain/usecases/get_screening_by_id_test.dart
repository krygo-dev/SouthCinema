import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/screenings/domain/entities/screening.dart';
import 'package:south_cinema/features/screenings/domain/repositories/screenings_repository.dart';
import 'package:south_cinema/features/screenings/domain/usecases/get_screening_by_id.dart';

import 'get_screening_by_id_test.mocks.dart';

@GenerateMocks([ScreenignsRepository])
void main() {
  late GetScreeningById usecase;
  late MockScreenignsRepository mockScreenignsRepository;

  setUp(() {
    mockScreenignsRepository = MockScreenignsRepository();
    usecase = GetScreeningById(mockScreenignsRepository);
  });

  const tId = 'testId';
  const tGettingDataError = GettingDataError();
  final tScreening = Screening(
    id: 'testId',
    date: Timestamp(1000, 1000),
    movieID: 'movieID',
    movieTitle: 'movieTitle',
    roomID: 'roomID',
    reservationOn: true,
    seatsTaken: const ['0101', '0102'],
  );

  test('should return Screening from repository for provided id', () async {
    // arrange
    when(mockScreenignsRepository.getScreeningById(id: anyNamed('id')))
        .thenAnswer((_) async => Right(tScreening));
    // act
    final result = await usecase(id: tId);
    // assert
    expect(result, Right(tScreening));
    verify(mockScreenignsRepository.getScreeningById(id: tId));
    verifyNoMoreInteractions(mockScreenignsRepository);
  });

  test('should return error when getting data was unsuccessful', () async {
    // arrange
    when(mockScreenignsRepository.getScreeningById(id: anyNamed('id')))
        .thenAnswer((_) async => const Left(tGettingDataError));
    // act
    final result = await usecase(id: tId);
    // assert
    expect(result, const Left(tGettingDataError));
    verify(mockScreenignsRepository.getScreeningById(id: tId));
    verifyNoMoreInteractions(mockScreenignsRepository);
  });
}
