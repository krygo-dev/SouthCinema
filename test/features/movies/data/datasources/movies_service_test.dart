import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/movies/data/datasources/movies_service_impl.dart';
import 'package:south_cinema/features/movies/domain/entities/movie.dart';

import 'movies_service_test.mocks.dart';

@GenerateMocks([
  FirebaseFirestore,
  CollectionReference,
  QuerySnapshot,
  Query,
  DocumentReference,
  DocumentSnapshot
], customMocks: [
  MockSpec<QueryDocumentSnapshot>(
      unsupportedMembers: {Symbol('data')},
      fallbackGenerators: {Symbol('data'): jsonData})
])
void main() {
  late MoviesServiceImpl moviesServiceImpl;
  late MockFirebaseFirestore mockFirebaseFirestore;
  late MockCollectionReference<Map<String, dynamic>> mockCollectionReference;
  late MockQuery<Map<String, dynamic>> mockQuery;
  late MockQuerySnapshot<Map<String, dynamic>> mockQuerySnapshot;
  late MockQueryDocumentSnapshot<Map<String, dynamic>>
      mockQueryDocumentSnapshot;
  late MockDocumentReference<Map<String, dynamic>> mockDocumentReference;
  late MockDocumentSnapshot<Map<String, dynamic>> mockDocumentSnapshot;
  const tCollectionPath = 'movies';
  final tMovie = sampleListOfMovies[0];

  setUp(() {
    mockFirebaseFirestore = MockFirebaseFirestore();
    mockCollectionReference = MockCollectionReference();
    mockQuery = MockQuery();
    mockQuerySnapshot = MockQuerySnapshot();
    mockQueryDocumentSnapshot = MockQueryDocumentSnapshot();
    mockDocumentReference = MockDocumentReference();
    mockDocumentSnapshot = MockDocumentSnapshot();
    moviesServiceImpl = MoviesServiceImpl(mockFirebaseFirestore);
  });

  group('getCurrentlyPlayedMovies', () {
    test('''should get all documents from movies collection where 
      currentlyPlayed is equal to true''', () async {
      // arrange
      when(mockFirebaseFirestore.collection(any))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.where(any, isEqualTo: anyNamed('isEqualTo')))
          .thenReturn(mockQuery);
      when(mockQuery.get()).thenAnswer((_) async => mockQuerySnapshot);
      when(mockQuerySnapshot.docs).thenReturn([mockQueryDocumentSnapshot]);
      when(mockQueryDocumentSnapshot.data()).thenReturn(jsonData());
      // act
      final result = await moviesServiceImpl.getCurrentlyPlayedMovies();
      // assert
      expect(result, contains(tMovie));
      verify(mockFirebaseFirestore.collection(tCollectionPath));
      verify(mockCollectionReference.where('currentlyPlayed', isEqualTo: true));
    });

    test('should throw GettingDataError when getting data fails', () async {
      // arrange
      when(mockFirebaseFirestore.collection(any))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.where(any, isEqualTo: anyNamed('isEqualTo')))
          .thenReturn(mockQuery);
      when(mockQuery.get()).thenThrow(FirebaseException(plugin: 'firestore'));
      // act
      final call = moviesServiceImpl.getCurrentlyPlayedMovies;
      // assert
      verifyNoMoreInteractions(mockFirebaseFirestore);
      await expectLater(() => call(), throwsA(isA<GettingDataError>()));
    });
  });

  group('getAnnouncedMovies', () {
    test('''should get all documents from movies collection where 
      currentlyPlayed is equal to false''', () async {
      // arrange
      when(mockFirebaseFirestore.collection(any))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.where(any, isEqualTo: anyNamed('isEqualTo')))
          .thenReturn(mockQuery);
      when(mockQuery.get()).thenAnswer((_) async => mockQuerySnapshot);
      when(mockQuerySnapshot.docs).thenReturn([mockQueryDocumentSnapshot]);
      when(mockQueryDocumentSnapshot.data()).thenReturn(jsonData());
      // act
      final result = await moviesServiceImpl.getAnnouncedMovies();
      // assert
      expect(result, contains(tMovie));
      verify(mockFirebaseFirestore.collection(tCollectionPath));
      verify(
          mockCollectionReference.where('currentlyPlayed', isEqualTo: false));
    });

    test('should throw GettingDataError when getting data fails', () async {
      // arrange
      when(mockFirebaseFirestore.collection(any))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.where(any, isEqualTo: anyNamed('isEqualTo')))
          .thenReturn(mockQuery);
      when(mockQuery.get()).thenThrow(FirebaseException(plugin: 'firestore'));
      // act
      final call = moviesServiceImpl.getAnnouncedMovies;
      // assert
      verifyNoMoreInteractions(mockFirebaseFirestore);
      await expectLater(() => call(), throwsA(isA<GettingDataError>()));
    });
  });

  group('getMovieById', () {
    const tId = 'id';

    test('''should get document by provided id from movies collection and 
      return it as Movie entity''', () async {
      // arrange
      when(mockFirebaseFirestore.collection(any))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
      when(mockDocumentReference.get())
          .thenAnswer((_) async => mockDocumentSnapshot);
      when(mockDocumentSnapshot.data()).thenReturn(jsonData());
      // act
      final result = await moviesServiceImpl.getMovieById(id: tId);
      // assert
      expect(result, tMovie);
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
      final call = moviesServiceImpl.getMovieById;
      // assert
      verifyNoMoreInteractions(mockFirebaseFirestore);
      await expectLater(() => call(id: tId), throwsA(isA<GettingDataError>()));
    });
  });
}

// Function used to mock behavior of QueryDocumentSnapshot.data() method
// See usage in @GenerateMocks annotation
Map<String, dynamic> jsonData() {
  return {
    'id': 'id',
    'ageRestriction': 15,
    'description': 'description',
    'director': 'director',
    'distribution': 'distribution',
    'format': 'format',
    'posterUrl': 'posterUrl',
    'premiereDate': 'premiereDate',
    'productionCountry': 'productionCountry',
    'title': 'title',
    'trailerUrl': 'trailerUrl',
    'durationMin': 100,
    'subtitles': true,
    'currentlyPlayed': true,
    'cast': ["Test", "Test2"],
    'genre': ["SF"],
  };
}
