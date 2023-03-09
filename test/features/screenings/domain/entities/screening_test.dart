import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:south_cinema/features/screenings/domain/entities/screening.dart';

void main() {
  final tScreening = Screening(
    id: 'testID',
    date: Timestamp.fromDate(DateTime(2023, 3, 15)),
    movieID: 'movieID',
    movieTitle: 'movieTitle',
    roomID: 'roomID',
    reservationOn: true,
    seatsTaken: const ['0101', '0102'],
  );

  final tJson = {
    'id': 'testID',
    'date': Timestamp.fromDate(DateTime(2023, 3, 15)),
    'movieID': 'movieID',
    'movieTitle': 'movieTitle',
    'roomID': 'roomID',
    'reservationOn': true,
    'seatsTaken': const ['0101', '0102'],
  };

  test('should return valid Screening entity from json', () {
    // act
    final result = Screening.fromJson(tJson);
    // assert
    expect(result, tScreening);
  });
}
