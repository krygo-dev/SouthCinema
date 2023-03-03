import 'package:dartz/dartz.dart';
import 'package:south_cinema/features/movies/domain/entities/movie.dart';
import 'package:south_cinema/features/movies/domain/repositories/movies_repository.dart';
import 'package:south_cinema/core/error/error.dart';

class GetAllMovies {
  final MoviesRepository repository;

  GetAllMovies(this.repository);

  Future<Either<Error, List<Movie>>> call() async {
    return await repository.getAllMovies();
  }
}