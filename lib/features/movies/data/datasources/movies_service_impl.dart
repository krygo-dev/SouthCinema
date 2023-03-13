import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/movies/data/datasources/movies_service.dart';
import 'package:south_cinema/features/movies/domain/entities/movie.dart';

class MoviesServiceImpl implements MoviesService {
  final FirebaseFirestore firebaseFirestore;

  MoviesServiceImpl(this.firebaseFirestore);

  @override
  Future<List<Movie>> getCurrentlyPlayedMovies() async {
    try {
      final snapshots = (await firebaseFirestore
              .collection('movies')
              .where('currentlyPlayed', isEqualTo: true)
              .get())
              .docs;
      final moviesList =
          snapshots.map((snapshot) => Movie.fromJson(snapshot.data())).toList();
      return moviesList;
    } on FirebaseException catch (e) {
      throw GettingDataError(message: e.message ?? 'Unexpected error');
    }
  }

  @override
  Future<List<Movie>> getAnnouncedMovies() async {
    try {
      final snapshots = (await firebaseFirestore
          .collection('movies')
          .where('currentlyPlayed', isEqualTo: false)
          .get())
          .docs;
      final moviesList =
      snapshots.map((snapshot) => Movie.fromJson(snapshot.data())).toList();
      return moviesList;
    } on FirebaseException catch (e) {
      throw GettingDataError(message: e.message ?? 'Unexpected error');
    }
  }

  @override
  Future<Movie> getMovieById({required String id}) async {
    try {
      final doc = await firebaseFirestore.collection('movies').doc(id).get();
      return Movie.fromJson(doc.data()!);
    } on FirebaseException catch (e) {
      throw GettingDataError(message: e.message ?? 'Unexpected error');
    }
  }
}
