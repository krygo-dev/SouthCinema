import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/screenings/domain/entities/repertoire_screening.dart';
import 'package:south_cinema/features/screenings/domain/usecases/get_repertoire_for_date.dart';
import 'package:south_cinema/features/screenings/presentation/bloc/repertoire_bloc.dart';

import 'repertoire_bloc_test.mocks.dart';

@GenerateMocks([GetRepertoireForDate])
void main() {
  late RepertoireBloc bloc;
  late MockGetRepertoireForDate mockGetRepertoireForDate;

  setUp(() {
    mockGetRepertoireForDate = MockGetRepertoireForDate();
    bloc = RepertoireBloc(getRepertoireForDate: mockGetRepertoireForDate);
  });

  test('initial state should be Empty', () {
    // assert
    expect(bloc.state, equals(RepertoireEmpty()));
  });

  group('GetRepertoireForDate', () {
    const tDateString = '15/03/2023';
    const tRepertoireScreeningList = [
      RepertoireScreening(
        id: 'id',
        title: 'title',
        date: '15/03/2023',
        screenings: [
          {'screeningID': '111111', 'time': '13:30'},
        ],
      )
    ];

    test('should get data from GetRepertoireForDate usecase', () async {
      // arrange
      when(mockGetRepertoireForDate(date: anyNamed('date')))
          .thenAnswer((_) async => const Right(tRepertoireScreeningList));
      // act
      bloc.add(GetRepertoireForDateEvent(tDateString));
      await untilCalled(mockGetRepertoireForDate(date: anyNamed('date')));
      // assert
      verify(mockGetRepertoireForDate(date: tDateString));
    });

    test('should emit [Loading, Loaded] when getting data was successful',
        () async {
      // arrange
      when(mockGetRepertoireForDate(date: anyNamed('date')))
          .thenAnswer((_) async => const Right(tRepertoireScreeningList));
      // assert later
      final expected = [
        RepertoireLoading(),
        RepertoireLoaded(repertoireList: tRepertoireScreeningList)
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(GetRepertoireForDateEvent(tDateString));
    });

    test('should emit [Loading, Error] when getting data fails', () async {
      // arrange
      when(mockGetRepertoireForDate(date: anyNamed('date')))
          .thenAnswer((_) async => const Left(GettingDataError()));
      // assert later
      final expected = [
        RepertoireLoading(),
        RepertoireError(message: const GettingDataError().message),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(GetRepertoireForDateEvent(tDateString));
    });

    test('''should emit [Loading, Error] with proper message for the 
      error when getting data fails''', () async {
      // arrange
      when(mockGetRepertoireForDate(date: anyNamed('date')))
          .thenAnswer((_) async => const Left(NetworkError()));
      // assert later
      final expected = [
        RepertoireLoading(),
        RepertoireError(message: const NetworkError().message),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(GetRepertoireForDateEvent(tDateString));
    });
  });
}
