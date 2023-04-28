import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:south_cinema/features/reservations/domain/entities/purchase.dart';

void main() {
  final time = Timestamp.now();
  final tPurchase = Purchase(
    id: 'id',
    screeningId: 'screeningId',
    userId: 'userId',
    fullName: 'fullName',
    createdAt: time,
    phoneNumber: 'phoneNumber',
    email: 'email',
    tickets: const {'0101': 'ADULT', '0102': 'STUDENT'},
    totalPrice: 15.0,
  );
  final tPurchaseJson = {
    'id': 'id',
    'screeningId': 'screeningId',
    'userId': 'userId',
    'fullName': 'fullName',
    'createdAt': time,
    'phoneNumber': 'phoneNumber',
    'email': 'email',
    'tickets': {'0101': 'ADULT', '0102': 'STUDENT'},
    'totalPrice': 15.0,
  };

  test('should return valid Purchase entity from json map', () {
    // act
    final result = Purchase.fromJson(tPurchaseJson);
    // assert
    expect(result, tPurchase);
  });

  test('should return json map from Reservation entity', () {
    // act
    final result = tPurchase.toJson();
    // assert
    expect(result, tPurchaseJson);
  });
}
