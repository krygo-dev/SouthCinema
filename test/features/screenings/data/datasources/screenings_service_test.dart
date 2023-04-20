import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/screenings/data/datasources/screenings_service_impl.dart';
import 'package:south_cinema/features/screenings/domain/entities/repertoire_screening.dart';
import 'package:south_cinema/features/screenings/domain/entities/room.dart';
import 'package:south_cinema/features/screenings/domain/entities/screening.dart';

import 'screenings_service_test.mocks.dart';

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
  late ScreeningsServiceImpl screeningsServiceImpl;
  late MockFirebaseFirestore mockFirebaseFirestore;
  late MockCollectionReference<Map<String, dynamic>> mockCollectionReference;
  late MockQuery<Map<String, dynamic>> mockQuery;
  late MockQuerySnapshot<Map<String, dynamic>> mockQuerySnapshot;
  late MockQueryDocumentSnapshot<Map<String, dynamic>>
      mockQueryDocumentSnapshot;
  late MockDocumentReference<Map<String, dynamic>> mockDocumentReference;
  late MockDocumentSnapshot<Map<String, dynamic>> mockDocumentSnapshot;

  setUp(() {
    mockFirebaseFirestore = MockFirebaseFirestore();
    mockCollectionReference = MockCollectionReference();
    mockQuery = MockQuery();
    mockQuerySnapshot = MockQuerySnapshot();
    mockQueryDocumentSnapshot = MockQueryDocumentSnapshot();
    mockDocumentReference = MockDocumentReference();
    mockDocumentSnapshot = MockDocumentSnapshot();
    screeningsServiceImpl = ScreeningsServiceImpl(mockFirebaseFirestore);
  });

  group('getRepertoireForDate', () {
    const tCollectionPath = 'repertoire';
    const tDate = '15/03/2023';
    const tRepertoireScreening = RepertoireScreening(
      id: 'testId',
      title: 'Test',
      date: tDate,
      screenings: [
        {'screeningID': '123456', 'time': '13:30'},
        {'screeningID': '345678', 'time': '16:30'},
      ],
    );

    test('''should get all documents from repertoire collection where date is 
      equal to provided date and return as list of RepertoireScreening''',
        () async {
      // arrange
      when(mockFirebaseFirestore.collection(any))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.where(any, isEqualTo: anyNamed('isEqualTo')))
          .thenReturn(mockQuery);
      when(mockQuery.get()).thenAnswer((_) async => mockQuerySnapshot);
      when(mockQuerySnapshot.docs).thenReturn([mockQueryDocumentSnapshot]);
      when(mockQueryDocumentSnapshot.data()).thenReturn(jsonData());
      // act
      final result = await screeningsServiceImpl.getRepertoireForDate(tDate);
      // assert
      expect(result, contains(tRepertoireScreening));
      verify(mockFirebaseFirestore.collection(tCollectionPath));
      verify(mockCollectionReference.where('date', isEqualTo: tDate));
    });

    test('should throw GettingDataError when getting data fails', () async {
      // arrange
      when(mockFirebaseFirestore.collection(any))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.where(any, isEqualTo: anyNamed('isEqualTo')))
          .thenReturn(mockQuery);
      when(mockQuery.get()).thenThrow(FirebaseException(plugin: 'firestore'));
      // act
      final call = screeningsServiceImpl.getRepertoireForDate;
      // assert
      verifyNoMoreInteractions(mockFirebaseFirestore);
      await expectLater(() => call(tDate), throwsA(isA<GettingDataError>()));
    });
  });

  group('getRoomById', () {
    const tCollectionPath = 'rooms';
    const tId = 'room_id';
    const tRoom = Room(
      id: 'room_id',
      name: 'name',
      seatsConfiguration: [13, 12, 13, 12],
    );
    const tJson = <String, Object>{
      'id': 'room_id',
      'name': 'name',
      'seatsConfiguration': [13, 12, 13, 12],
    };

    test(
        'should get document by provided id from rooms collection and return it as Room entity',
        () async {
      // arrange
      when(mockFirebaseFirestore.collection(any))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
      when(mockDocumentReference.get())
          .thenAnswer((_) async => mockDocumentSnapshot);
      when(mockDocumentSnapshot.data()).thenReturn(tJson);
      // act
      final result = await screeningsServiceImpl.getRoomById(tId);
      // assert
      expect(result, tRoom);
      verify(mockFirebaseFirestore.collection(tCollectionPath));
      verify(mockCollectionReference.doc(tId));
    });

    test('should throw GettingDataError when getting data fails', () async {
      // arrange
      when(mockFirebaseFirestore.collection(any))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
      when(mockDocumentReference.get())
          .thenThrow(FirebaseException(plugin: 'firestore'));
      // act
      final call = screeningsServiceImpl.getRoomById;
      // assert
      verifyNoMoreInteractions(mockFirebaseFirestore);
      await expectLater(() => call(tId), throwsA(isA<GettingDataError>()));
    });
  });

  group('getScreeningById', () {
    const tCollectionPath = 'screenings';
    const tId = 'test_id';
    final tScreening = Screening(
      id: 'test_id',
      date: Timestamp.fromDate(DateTime(2023, 3, 15)),
      movieID: 'movieID',
      movieTitle: 'movieTitle',
      roomID: 'roomID',
      reservationOn: true,
      seatsTaken: const ['0101', '0102'],
    );
    final tJson = {
      'id': 'test_id',
      'date': Timestamp.fromDate(DateTime(2023, 3, 15)),
      'movieID': 'movieID',
      'movieTitle': 'movieTitle',
      'roomID': 'roomID',
      'reservationOn': true,
      'seatsTaken': const ['0101', '0102'],
    };

    test('''should get document by provided id from screenings collection 
      and return in as Screening entity''', () async {
      // arrange
      when(mockFirebaseFirestore.collection(any))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
      when(mockDocumentReference.get())
          .thenAnswer((_) async => mockDocumentSnapshot);
      when(mockDocumentSnapshot.data()).thenReturn(tJson);
      // act
      final result = await screeningsServiceImpl.getScreeningById(tId);
      // assert
      expect(result, tScreening);
      verify(mockFirebaseFirestore.collection(tCollectionPath));
      verify(mockCollectionReference.doc(tId));
    });

    test('should throw GettingDataError when getting data fails', () async {
      // arrange
      when(mockFirebaseFirestore.collection(any))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
      when(mockDocumentReference.get())
          .thenThrow(FirebaseException(plugin: 'firestore'));
      // act
      final call = screeningsServiceImpl.getScreeningById;
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
    'id': 'testId',
    'title': 'Test',
    'date': '15/03/2023',
    'screenings': [
      {'screeningID': '123456', 'time': '13:30'},
      {'screeningID': '345678', 'time': '16:30'},
    ]
  };
}
