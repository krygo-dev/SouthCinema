import 'package:dartz/dartz.dart';
import 'package:south_cinema/features/movies/domain/entities/movie.dart';
import 'package:south_cinema/features/movies/domain/repositories/movies_repository.dart';
import 'package:south_cinema/core/error/error.dart';

class GetCurrentlyPlayedMovies {
  final MoviesRepository repository;

  GetCurrentlyPlayedMovies(this.repository);

  Future<Either<Error, List<Movie>>> call() async {
    return await repository.getCurrentlyPlayedMovies();
  }
}