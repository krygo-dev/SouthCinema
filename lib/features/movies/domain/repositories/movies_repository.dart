import 'package:dartz/dartz.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/movies/domain/entities/movie.dart';

abstract class MoviesRepository {
  Future<Either<Error, List<Movie>>> getCurrentlyPlayedMovies();
  Future<Either<Error, List<Movie>>> getAnnouncedMovies();
  Future<Either<Error, List<Movie>>> getAllMovies();
}