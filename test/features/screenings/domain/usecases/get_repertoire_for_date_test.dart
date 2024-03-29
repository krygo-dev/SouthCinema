import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/screenings/domain/entities/repertoire_screening.dart';
import 'package:south_cinema/features/screenings/domain/repositories/screenings_repository.dart';
import 'package:south_cinema/features/screenings/domain/usecases/get_repertoire_for_date.dart';

import 'get_repertoire_for_date_test.mocks.dart';


@GenerateMocks([ScreeningsRepository])
void main() {
  late GetRepertoireForDate usecase;
  late MockScreeningsRepository mockScreenignsRepository;

  setUp(() {
    mockScreenignsRepository = MockScreeningsRepository();
    usecase = GetRepertoireForDate(mockScreenignsRepository);
  });

  const tDate = '15/03/2023';
  const tRepertoireList = [
    RepertoireScreening(
      id: 'id',
      title: 'title',
      date: 'date',
      screenings: [],
    )
  ];
  const tGettingDataError = GettingDataError();

  test(
      'should return list of RepertoireScreening from repository for provided date',
      () async {
    // arrange

    when(mockScreenignsRepository.getRepertoireForDate(date: anyNamed('date')))
        .thenAnswer((_) async => const Right(tRepertoireList));
    // act
    final result = await usecase(date: tDate);
    // assert
    expect(result, const Right(tRepertoireList));
    verify(mockScreenignsRepository.getRepertoireForDate(date: tDate));
    verifyNoMoreInteractions(mockScreenignsRepository);
  });

  test('should return error when getting data was unsuccessful', () async {
    // arrange
    when(mockScreenignsRepository.getRepertoireForDate(date: anyNamed('date')))
        .thenAnswer((_) async => const Left(tGettingDataError));
    // act
    final result = await usecase(date: tDate);
    // assert
    expect(result, const Left(tGettingDataError));
    verify(mockScreenignsRepository.getRepertoireForDate(date: tDate));
    verifyNoMoreInteractions(mockScreenignsRepository);
  });
}
