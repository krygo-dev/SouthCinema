import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/reservations/data/datasources/reservations_service_impl.dart';
import 'package:south_cinema/features/reservations/domain/entities/reservation.dart';

import 'reservations_service_test.mocks.dart';

@GenerateMocks([
  FirebaseFirestore,
  CollectionReference,
  QuerySnapshot,
  Query,
  DocumentReference,
  DocumentSnapshot,
], customMocks: [
  MockSpec<QueryDocumentSnapshot>(
    unsupportedMembers: {Symbol('data')},
    fallbackGenerators: {Symbol('data'): jsonData},
  ),
])
void main() {
  late ReservationsServiceImpl reservationsServiceImpl;
  late MockFirebaseFirestore mockFirebaseFirestore;
  late MockCollectionReference<Map<String, dynamic>> mockCollectionReference;
  late MockQuery<Map<String, dynamic>> mockQuery;
  late MockQuerySnapshot<Map<String, dynamic>> mockQuerySnapshot;
  late MockQueryDocumentSnapshot<Map<String, dynamic>>
  mockQueryDocumentSnapshot;
  late MockDocumentReference<Map<String, dynamic>> mockDocumentReference;

  const tCollectionPath = 'reservations';

  setUp(() {
    mockFirebaseFirestore = MockFirebaseFirestore();
    mockCollectionReference = MockCollectionReference();
    mockQuery = MockQuery();
    mockQuerySnapshot = MockQuerySnapshot();
    mockQueryDocumentSnapshot = MockQueryDocumentSnapshot();
    mockDocumentReference = MockDocumentReference();
    reservationsServiceImpl = ReservationsServiceImpl(mockFirebaseFirestore);
  });

  group('createNewReservation', () {
    final tReservation = Reservation.fromJson(jsonData());

    test('return true when setting data was successful', () async {
      // arrange
      when(mockFirebaseFirestore.collection(tCollectionPath))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.add(any))
          .thenAnswer((_) async => mockDocumentReference);
      when(mockDocumentReference.id).thenReturn('id');
      when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
      when(mockDocumentReference.update(any)).thenAnswer((_) async => true);
      // act
      final result =
      await reservationsServiceImpl.createNewReservation(tReservation);
      // assert
      expect(result, true);
      verify(mockFirebaseFirestore.collection(tCollectionPath));
      verify(mockCollectionReference.add(tReservation.toJson()));
      verify(mockDocumentReference.id);
      verify(mockCollectionReference.doc(tReservation.id));
      verify(mockDocumentReference.update({'id': 'id'}));
    });

    test('should throw SettingDataError when setting data fails', () async {
      // arrange
      when(mockFirebaseFirestore.collection(tCollectionPath))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.add(any))
          .thenThrow(FirebaseException(plugin: 'firestore'));
      // act
      final call = reservationsServiceImpl.createNewReservation;
      // assert
      verifyNoMoreInteractions(mockFirebaseFirestore);
      await expectLater(
              () => call(tReservation), throwsA(isA<SettingDataError>()));
    });
  });

  group('getUserReservations', () {
    const tId = 'userId';
    final tReservation = Reservation.fromJson(jsonData());

    test('''should get all documents from reservation collection where 
      userId is equal provided id and return them as list of Reservation''', () async {
      // arrange
      when(mockFirebaseFirestore.collection(any))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.where(any, isEqualTo: anyNamed('isEqualTo')))
          .thenReturn(mockQuery);
      when(mockQuery.get()).thenAnswer((_) async => mockQuerySnapshot);
      when(mockQuerySnapshot.docs).thenReturn([mockQueryDocumentSnapshot]);
      when(mockQueryDocumentSnapshot.data()).thenReturn(jsonData());
      // act
      final result = await reservationsServiceImpl.getUserReservations(tId);
      // assert
      expect(result, contains(tReservation));
      verify(mockFirebaseFirestore.collection(tCollectionPath));
      verify(mockCollectionReference.where('userId', isEqualTo: tId));
    });

    test('should throw GettingDataError when getting data fails', () async {
      // arrange
      when(mockFirebaseFirestore.collection(any))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.where(any, isEqualTo: anyNamed('isEqualTo')))
          .thenReturn(mockQuery);
      when(mockQuery.get()).thenThrow(FirebaseException(plugin: 'firestore'));
      // act
      final call = reservationsServiceImpl.getUserReservations;
      // assert
      verifyNoMoreInteractions(mockFirebaseFirestore);
      await expectLater(() => call(tId), throwsA(isA<GettingDataError>()));
    });
  });
}

// Function used to mock behavior of QueryDocumentSnapshot.data() method
// See usage in @GenerateMocks annotation
Map<String, dynamic> jsonData() {
  return {
    'id': 'id',
    'screeningId': 'screeningId',
    'userId': 'userId',
    'createdAt': Timestamp.fromDate(DateTime(2023, 3, 15, 11, 45)),
    'phoneNumber': 'phoneNumber',
    'seats': ['0101', '0102'],
  };
}
