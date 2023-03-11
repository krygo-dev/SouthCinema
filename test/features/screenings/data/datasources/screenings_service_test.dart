import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/screenings/data/datasources/screenings_service_impl.dart';
import 'package:south_cinema/features/screenings/domain/entities/repertoire_screening.dart';

import 'screenings_service_test.mocks.dart';

@GenerateMocks([
  FirebaseFirestore,
  CollectionReference,
  QuerySnapshot,
  Query,
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

  setUp(() {
    mockFirebaseFirestore = MockFirebaseFirestore();
    mockCollectionReference = MockCollectionReference();
    mockQuery = MockQuery();
    mockQuerySnapshot = MockQuerySnapshot();
    mockQueryDocumentSnapshot = MockQueryDocumentSnapshot();
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
}

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
