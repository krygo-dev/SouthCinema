import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/user_profile/data/datasources/user_service_impl.dart';
import 'package:south_cinema/features/user_profile/domain/entities/user.dart';

import 'user_service_test.mocks.dart';

@GenerateMocks([
  FirebaseFirestore,
  CollectionReference,
  DocumentReference,
  DocumentSnapshot
])
void main() {
  late UserServiceImpl userServiceImpl;
  late MockFirebaseFirestore mockFirebaseFirestore;
  late MockCollectionReference<Map<String, dynamic>> mockCollectionReference;
  late MockDocumentReference<Map<String, dynamic>> mockDocumentReference;
  late MockDocumentSnapshot<Map<String, dynamic>> mockDocumentSnapshot;

  setUp(() {
    mockFirebaseFirestore = MockFirebaseFirestore();
    mockCollectionReference = MockCollectionReference();
    mockDocumentReference = MockDocumentReference();
    mockDocumentSnapshot = MockDocumentSnapshot();
    userServiceImpl = UserServiceImpl(mockFirebaseFirestore);
  });

  const tCollectionPath = 'users';
  const tUser = User(
    uid: 'uid',
    email: 'email',
    name: 'name',
    city: 'city',
    postCode: 'postCode',
    street: 'street',
    contactNumber: 'contactNumber',
  );

  group('getUserById', () {
    const tId = 'uid';
    const tJson = {
      'uid': 'uid',
      'email': 'email',
      'name': 'name',
      'city': 'city',
      'postCode': 'postCode',
      'street': 'street',
      'contactNumber': 'contactNumber',
    };

    test('''should get document from users collection for provided id and 
      return it as User entity''', () async {
      // arrange
      when(mockFirebaseFirestore.collection(any))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
      when(mockDocumentReference.get())
          .thenAnswer((_) async => mockDocumentSnapshot);
      when(mockDocumentSnapshot.data()).thenReturn(tJson);
      // act
      final result = await userServiceImpl.getUserById(tId);
      // arrange
      expect(result, tUser);
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
      final call = userServiceImpl.getUserById;
      // assert
      verifyNoMoreInteractions(mockFirebaseFirestore);
      await expectLater(() => call(tId), throwsA(isA<GettingDataError>()));
    });
  });

  group('setOrUpdateUserData', () {
    test('should return true when setting data was successful', () async {
      // arrange
      when(mockFirebaseFirestore.collection(any)).thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
      when(mockDocumentReference.set(any)).thenAnswer((_) async => true);
      // act
      final result = await userServiceImpl.setOrUpdateUserData(tUser);
      // assert
      expect(result, true);
      verify(mockFirebaseFirestore.collection(tCollectionPath));
      verify(mockCollectionReference.doc(tUser.uid));
      verify(mockDocumentReference.set(tUser.toJson()));
    });

    test('should throw SettingDataError when setting data fails', () async {
      // arrange
      when(mockFirebaseFirestore.collection(any))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
      when(mockDocumentReference.set(any))
          .thenThrow(FirebaseException(plugin: 'firestore'));
      // act
      final call = userServiceImpl.setOrUpdateUserData;
      // assert
      verifyNoMoreInteractions(mockFirebaseFirestore);
      await expectLater(() => call(tUser), throwsA(isA<SettingDataError>()));
    });
  });
}
