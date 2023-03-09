import 'package:dartz/dartz.dart';
import 'package:south_cinema/features/movies/domain/repositories/movies_repository.dart';
import 'package:south_cinema/core/error/error.dart';

import '../entities/movie.dart';

class GetAnnouncedMovies {
  final MoviesRepository repository;

  GetAnnouncedMovies(this.repository);

  Future<Either<BaseError, List<Movie>>> call() async {
    return await repository.getAnnouncedMovies();
  }
}