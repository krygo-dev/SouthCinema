import 'package:flutter_test/flutter_test.dart';
import 'package:south_cinema/features/screenings/domain/entities/repertoire_screening.dart';

void main() {
  const tRepertoireScreening = RepertoireScreening(
    id: 'testId',
    title: 'Test',
    date: '15/03/2023',
    screenings: [
      {'screeningID': '123456', 'time': '13:30'},
      {'screeningID': '345678', 'time': '16:30'},
    ],
  );

  test('should return valid RepertoireScreening entity from json', () {
    // arrange
    const tJson = {
      'id': 'testId',
      'title': 'Test',
      'date': '15/03/2023',
      'screenings': [
        {'screeningID': '123456', 'time': '13:30'},
        {'screeningID': '345678', 'time': '16:30'},
      ]
    };
    // act
    final result = RepertoireScreening.fromJson(tJson);
    // assert
    expect(result, tRepertoireScreening);
  });
}
