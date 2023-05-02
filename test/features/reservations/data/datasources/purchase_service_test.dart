import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/reservations/data/datasources/purchase_service_impl.dart';
import 'package:south_cinema/features/reservations/domain/entities/purchase.dart';
import 'package:south_cinema/features/screenings/data/datasources/screenings_service.dart';

import 'purchase_service_test.mocks.dart';

@GenerateMocks([
  ScreeningsService,
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
  late PurchaseServiceImpl purchaseServiceImpl;
  late MockScreeningsService mockScreeningsService;
  late MockFirebaseFirestore mockFirebaseFirestore;
  late MockCollectionReference<Map<String, dynamic>> mockCollectionReference;
  late MockQuery<Map<String, dynamic>> mockQuery;
  late MockQuerySnapshot<Map<String, dynamic>> mockQuerySnapshot;
  late MockQueryDocumentSnapshot<Map<String, dynamic>>
      mockQueryDocumentSnapshot;
  late MockDocumentReference<Map<String, dynamic>> mockDocumentReference;

  const tCollectionPath = 'purchases';

  setUp(() {
    mockScreeningsService = MockScreeningsService();
    mockFirebaseFirestore = MockFirebaseFirestore();
    mockCollectionReference = MockCollectionReference();
    mockQuery = MockQuery();
    mockQuerySnapshot = MockQuerySnapshot();
    mockQueryDocumentSnapshot = MockQueryDocumentSnapshot();
    mockDocumentReference = MockDocumentReference();
    purchaseServiceImpl = PurchaseServiceImpl(
      mockFirebaseFirestore,
      mockScreeningsService,
    );
  });

  group('createNewPurchase', () {
    final tPurchase = Purchase.fromJson(jsonData());
    final tSeats = ['0101', '0102'];

    test('should return true when setting data was successful', () async {
      // arrange
      when(mockFirebaseFirestore.collection(tCollectionPath))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.add(any))
          .thenAnswer((_) async => mockDocumentReference);
      when(mockDocumentReference.id).thenReturn('id');
      when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
      when(mockDocumentReference.update(any)).thenAnswer((_) async => true);
      when(mockScreeningsService.updateScreeningSeatsTaken(any, any))
          .thenAnswer((_) async => true);
      // act
      final result = await purchaseServiceImpl.createNewPurchase(tPurchase);
      // assert
      expect(result, true);
      verify(mockFirebaseFirestore.collection(tCollectionPath));
      verify(mockCollectionReference.add(tPurchase.toJson()));
      verify(mockDocumentReference.id);
      verify(mockCollectionReference.doc(tPurchase.id));
      verify(mockDocumentReference.update({'id': 'id'}));
      verify(mockScreeningsService.updateScreeningSeatsTaken(
          tPurchase.screeningId, tSeats));
    });

    test('should throw SettingDataError when setting data fails', () async {
      // arrange
      when(mockFirebaseFirestore.collection(tCollectionPath))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.add(any))
          .thenThrow(FirebaseException(plugin: 'firestore'));
      // act
      final call = purchaseServiceImpl.createNewPurchase;
      // assert
      verifyNoMoreInteractions(mockFirebaseFirestore);
      await expectLater(
          () => call(tPurchase), throwsA(isA<SettingDataError>()));
    });
  });

  group('getUserPurchasedTickets', () {
    const tId = 'userId';
    final tPurchase = Purchase.fromJson(jsonData());

    test('''should get all documents from purchases collection where 
      userId is equal provided id and return them as list of Purchase''',
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
      final result = await purchaseServiceImpl.getUserPurchasedTickets(tId);
      // assert
      expect(result, contains(tPurchase));
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
      final call = purchaseServiceImpl.getUserPurchasedTickets;
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
    'fullName': 'fullName',
    'createdAt': Timestamp.fromDate(DateTime(2023, 3, 15, 11, 45)),
    'phoneNumber': 'phoneNumber',
    'email': 'email',
    'tickets': {'0101': 'ADULT', '0102': 'STUDENT'},
    'totalPrice': 15.0,
  };
}
