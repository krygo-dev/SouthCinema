import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:south_cinema/features/reservations/domain/entities/reservation.dart';

void main() {
  final time = Timestamp.now();
  final tReservation = Reservation(
    id: 'id',
    screeningId: 'screeningId',
    userId: 'userId',
    fullName: 'Full Name',
    createdAt: time,
    phoneNumber: 'phoneNumber',
    email: 'email',
    seats: const ['0101', '0102'],
  );

  final tJson = {
    'id': 'id',
    'screeningId': 'screeningId',
    'userId': 'userId',
    'fullName': 'Full Name',
    'createdAt': time,
    'phoneNumber': 'phoneNumber',
    'email': 'email',
    'seats': ['0101', '0102'],
  };

  test('should return valid Reservation entity from json map', () {
    // act
    final result = Reservation.fromJson(tJson);
    // assert
    expect(result, tReservation);
  });

  test('should return json map from Reservation entity', () {
    // act
    final result = tReservation.toJson();
    // assert
    expect(result, tJson);
  });
}
