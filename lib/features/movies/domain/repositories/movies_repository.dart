import 'package:dartz/dartz.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/movies/domain/entities/movie.dart';

abstract class MoviesRepository {
  Future<Either<BaseError, List<Movie>>> getCurrentlyPlayedMovies();
  Future<Either<BaseError, List<Movie>>> getAnnouncedMovies();
  Future<Either<BaseError, Movie>> getMovieById({required String id});
}