import 'package:dartz/dartz.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/movies/domain/entities/movie.dart';
import 'package:south_cinema/features/movies/domain/repositories/movies_repository.dart';

class GetMovieById {
  final MoviesRepository repository;

  GetMovieById(this.repository);

  Future<Either<BaseError, Movie>> call({required String id}) async {
    return await repository.getMovieById(id: id);
  }
}