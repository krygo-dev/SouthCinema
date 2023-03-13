import 'package:south_cinema/features/movies/domain/entities/movie.dart';

abstract class MoviesService {
  Future<List<Movie>> getCurrentlyPlayedMovies();
  Future<List<Movie>> getAnnouncedMovies();
  Future<Movie> getMovieById({required String id});
}